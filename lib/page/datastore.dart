import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(groceries());
}

class groceries extends StatefulWidget {
  const groceries({Key? key}) : super(key: key);

  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<groceries> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference groceries =
        FirebaseFirestore.instance.collection('groceries');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: textController,
          ),
        ),
        body: Center(
          child: StreamBuilder(
              stream: groceries.orderBy('name').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((grocery) {
                    return Center(
                      child: ListTile(
                        title: Text(grocery['name']),
                        onLongPress: () {
                          grocery.reference.delete();
                        },
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            groceries.add({
              'name': textController.text,
            });
            textController.clear();
          },
        ),
      ),
    );
  }
}
