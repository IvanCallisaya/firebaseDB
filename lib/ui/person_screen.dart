import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prueba_firebase/model/person.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

File image;
String filename;

class PersonScreen extends StatefulWidget {
  final Person person;
  PersonScreen(this.person);
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

final PersonReference = FirebaseDatabase.instance.reference().child('Person');

class _PersonScreenState extends State<PersonScreen> {
  List<Person> items;

  TextEditingController _nameController;
  TextEditingController _emailController;

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.person.name);
    _emailController = new TextEditingController(text: widget.person.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Persons'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _emailController,
                  style: TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.person), labelText: 'Email'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.person.id != null) {
                        var part1 =
                            'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/'; //esto cambia segun su firestore
                        PersonReference.child(widget.person.id).set({
                          'name': _nameController.text,
                          'email': _emailController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        var part1 =
                            'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/'; //esto cambia segun su firestore
                        PersonReference.push().set({
                          'name': _nameController.text,
                          'email': _emailController.text,
//nuevo imagen
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
