import 'package:flutter/material.dart';
import 'package:newsappassignment/Presentation/Saved%20Articles/SavedArticles.dart';

Widget appBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(""),
      const Text(
        "True News (Eazr News)",
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SavedArticles()));
        },
      )
    ],
  );
}
