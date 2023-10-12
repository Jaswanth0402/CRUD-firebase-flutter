import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/firebase_methods.dart';
import 'package:crud_operation/modal/student_data.dart';
import 'package:crud_operation/page/add_page.dart';
import 'package:crud_operation/page/edit_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference =
      FirebaseMethods.getStudent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of the student'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const AddPage(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    ListTile(
                      title: Text(e.data().toString().contains("student_name")
                          ? e["student_name"]
                          : ""),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "Register No: " +
                                    (e.data().toString().contains("register_no")
                                        ? e["register_no"]
                                        : ""),
                                style: const TextStyle(fontSize: 14)),
                            Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "Email: " +
                                    (e.data().toString().contains("email")
                                        ? e["email"]
                                        : ""),
                                style: const TextStyle(fontSize: 14)),
                            Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "Contact Number: " +
                                    (e.data().toString().contains("contact_no")
                                        ? e["contact_no"]
                                        : ""),
                                style: const TextStyle(fontSize: 12)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            foregroundColor:
                                const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Edit'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPage(
                                  studentData: StudentData(
                                      uid: e.id,
                                      name: e["student_name"],
                                      registerno: e["register_no"],
                                      email: e["email"],
                                      contact: e['contact_no']),
                                ),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            foregroundColor: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("AlertDialog"),
                                    content: const Text(
                                        "Would you like to Delete the details?"),
                                    actions: [
                                      ElevatedButton(
                                        child: const Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text("Ok"),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          var response =
                                              await FirebaseMethods.delete(
                                                  docId: e.id);
                                          if (response.code != 200) {
                                            // ignore: use_build_context_synchronously
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                });
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
