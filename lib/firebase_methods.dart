import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/modal/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('student');

class FirebaseMethods{

  static Future<Response> addStudent ({
    required String name,
    required String registerno,
    required String email,
    required String contact

  })async{

     Response response =Response();
     DocumentReference documentReference =_Collection.doc();

     Map<String,dynamic> data =<String,dynamic>{
      "student_name" :name,
      "register_no":registerno,
      'email':email,
      'contact_no':contact
     };
     // ignore: unused_local_variable
     var result =await documentReference
     .set(data)
     .whenComplete((){
      response.code =200;
      response.message='Sucessfully added';
     })
     .catchError((e){
      response.code =500;
      response.message =e;
        
     });
    return response;
  }

  static Stream<QuerySnapshot> getStudent(){
    CollectionReference noteItemCollection =_Collection;

    return noteItemCollection.snapshots();
  }


static Future<Response> updateStudent({
    required String name,
    required String registerno,
    required String email,
    required String contact,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "student_name": name,
      "register_no": registerno,
      "email":email,
      "contact_no" : contact
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Sucessfully updated";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

   static Future<Response> delete({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Sucessfully Deleted ";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }

}