import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:prueba_firebase/ui/person_screen.dart';
import 'package:prueba_firebase/model/person.dart';

class ListViewPerson extends StatefulWidget {
  @override
  _ListViewPersonState createState() => _ListViewPersonState();
}

final personReference = FirebaseDatabase.instance.reference().child('person');

class _ListViewPersonState extends State<ListViewPerson> {
  List<Person> people;
  StreamSubscription<Event> _onPersonAddedRegister;

  @override
  void initState() {
    super.initState();
    people = new List();
    _onPersonAddedRegister = personReference.onChildAdded.listen(_onPersonAdded);

    @override
    void dispose() {
      super.dispose();
      _onPersonAddedRegister.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Persona'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: people.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: ListTile(
                        title: Text(
                          '${people[position].name}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 21.0,
                          ),
                        ),
                        subtitle: Text(
                          '${people[position].email}',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 21.0,
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[],
                        ),
                      ))
                    ],
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _createNewPerson(context),
        ),
      ),
    );
  }

  void _onPersonAdded(Event event) {
    setState(() {
      people.add(new Person.fromSnapShot(event.snapshot));
    });
  }

  void _createNewPerson(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonScreen(Person(null, '', ''))),
    );
  }
}
