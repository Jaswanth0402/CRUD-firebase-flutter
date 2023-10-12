import 'package:crud_operation/firebase_options.dart';
import 'package:crud_operation/page/add_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void>main()async{
WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD Operation',
      home: AddPage()
    );
  }
}

// () async {
//                             var response =
//                                 await FirebaseMethods.delete(docId: e.id);
//                             if (response.code != 200) {
//                               // ignore: use_build_context_synchronously
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       content:
//                                           Text(response.message.toString()),
//                                     );
//                                   });
//                             }
//                           },