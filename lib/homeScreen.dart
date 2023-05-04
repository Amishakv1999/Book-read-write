import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_write/readData.dart';



class AddBookScreen extends StatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  TextEditingController titleControl=TextEditingController();
  TextEditingController entryControl=TextEditingController();
  TextEditingController publisherControl=TextEditingController();
  TextEditingController pagesControl=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _bookTitle = '';
  String _authorName = '';
  String _publisherName = '';
  int _numberOfPages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleControl,
                decoration: InputDecoration(
                  labelText: 'Book Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a book title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _bookTitle = value!;
                  });
                },
              ),
              TextFormField(
                controller: entryControl,
                decoration: InputDecoration(
                  labelText: 'Author Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an author name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _authorName = value!;
                  });
                },
              ),
              TextFormField(
                controller: publisherControl,
                decoration: InputDecoration(
                  labelText: 'Publisher Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a publisher name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _publisherName = value!;
                  });
                },
              ),
              TextFormField(
                controller: pagesControl,
                decoration: InputDecoration(
                  labelText: 'Number of Pages',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of pages';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _numberOfPages = int.parse(value!);
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                  child: Text('Add Book'),
                  onPressed: () async {
                    if(titleControl.text.isEmpty||entryControl.text.isEmpty)
                      print("Please enter title and entry");
                    else
                    {
                      // added to firebase


                      await FirebaseFirestore.instance.collection('Books').add(
                          {
                            'Title':titleControl.text,
                            'Name':entryControl.text,
                            'Publisher':publisherControl.text,
                            'Pages':pagesControl.text,

                          }).then((value) => print("Entry added succesfully"),
                      ).catchError((error)=>print("Entry not added due to $error"));
                      titleControl.clear();
                      entryControl.clear();
                      publisherControl.clear();
                      pagesControl.clear();

                    }
                  }
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                  child: Text('Read Book'),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadBook(docs: [],),));
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
