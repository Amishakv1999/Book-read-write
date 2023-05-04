import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<List<QueryDocumentSnapshot>> getBooks() async {
  QuerySnapshot querySnapshot =
  await FirebaseFirestore.instance.collection('Books').get();
  return querySnapshot.docs;
}
class ReadBook extends StatefulWidget {
  const ReadBook({Key? key, required this.docs}) : super(key: key);

  final List<QueryDocumentSnapshot> docs;

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Books')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Books').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book Name: ${document['Title']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pages: ${document['Pages']}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Publisher: ${document['Publisher']}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Author name: ${document['Name']}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );

  }
}
