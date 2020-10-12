import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/models/product.dart';
import 'package:testproject/screens/addproduct/addproduct.dart';
import 'package:testproject/screens/addproduct/addproduct_provider.dart';
import 'package:testproject/screens/details/details_product.dart';
import 'package:testproject/screens/product/product_provider.dart';
import 'package:testproject/screens/user_profile/user_profile.dart';
import 'package:testproject/screens/user_profile/user_profile_provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider _provider = Provider.of<ProductProvider>(context);
    _provider.getProductsList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.portrait),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<UserProvider>(
                  create: (_) => UserProvider(),
                  child: UserScreen(),
                ),
              ),
            );
          },
        ),
        actions: [
          Switch.adaptive(
            value: _provider.switcher,
            onChanged: (value) {
              _provider.switchGrid();
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _provider.getProductsList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _provider.switcher
                ? ListViewScreen(snapshot: snapshot)
                : GridViewScreen(
                    snapshot: snapshot,
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<AddProducProvider>(
              create: (_) => AddProducProvider(),
              child: AddProductScreen(),
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListViewScreen extends StatelessWidget {
  final snapshot;

  const ListViewScreen({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: snapshot.data[index].title,
                  description: snapshot.data[index].description,
                  imageUrl: snapshot.data[index].imageUrl,
                ),
              ),
            );
          },
          child: ListTile(
            leading: Container(
              width: 100,
              height: 100,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(snapshot.data[index].imageUrl ??
                    'https://firebasestorage.googleapis.com/v0/b/irla-app.appspot.com/o/account_photo_placeholder.png?alt=media'),
              ),
            ),
            title: Text(snapshot.data[index].title),
            subtitle: Text(snapshot.data[index].price),
          ),
        );
      },
    );
  }
}

class GridViewScreen extends StatelessWidget {
  final snapshot;

  const GridViewScreen({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: snapshot.data[index].title,
                  description: snapshot.data[index].description,
                  imageUrl: snapshot.data[index].imageUrl,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(children: [
                Expanded(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(snapshot.data[index].imageUrl ??
                        'https://firebasestorage.googleapis.com/v0/b/irla-app.appspot.com/o/account_photo_placeholder.png?alt=media'),
                  ),
                ),
                Text(snapshot.data[index].title),
                Text(snapshot.data[index].price)
              ]),
            ),
          ),
        );
      },
    );
  }
}
