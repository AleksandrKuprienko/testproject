import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final description;
  final imageUrl;
  final title;

  const DetailsScreen(
      {@required this.description,
      @required this.imageUrl,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title'),
        ),
        body: Column(
          children: [
            Image(
              image: NetworkImage(imageUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
