import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/screens/user_profile/user_profile_provider.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Мой аккаунт'),
        actions: [
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              _provider.logOut();
              Navigator.of(context).popUntil((screen) => screen.isFirst);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: Future.delayed(
            Duration(seconds: 2),
            () => _provider.getUsersData(),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(_provider.userAvatar ??
                      'https://firebasestorage.googleapis.com/v0/b/irla-app.appspot.com/o/account_photo_placeholder.png?alt=media'),
                ),
                title: Text(_provider.userDisplayName ?? 'Имя пользователя'),
                subtitle: Text(_provider.userEmail ?? 'Почта пользователя'),
              );
            if (snapshot.hasError) return Text(snapshot.error);
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
