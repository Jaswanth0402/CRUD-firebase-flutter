import 'package:crud_operation/firebase_methods.dart';
import 'package:crud_operation/modal/student_data.dart';
import 'package:crud_operation/page/list_page.dart';
import 'package:flutter/material.dart';


class EditPage extends StatefulWidget {
    final StudentData? studentData;
  const EditPage({super.key,this.studentData});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
 final name =TextEditingController();
  final registerno =TextEditingController();
  final email =TextEditingController();
  final contact =TextEditingController();
  final docid =TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
  void initState() {
    super.initState();
    docid.value = TextEditingValue(text: widget.studentData!.uid.toString());
    name.value = TextEditingValue(text: widget.studentData!.name.toString());
registerno.value = TextEditingValue(text: widget.studentData!.registerno.toString());
   email.value = TextEditingValue(text: widget.studentData!.email.toString());
   contact.value = TextEditingValue(text: widget.studentData!.contact.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Student details'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  [
          Form(
            key: _formKey,
            
            child: Column(
            children: [
              TextField(
                 controller:docid ,
                 readOnly: true,
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Student_id",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
    
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                 controller:name ,
                 validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
               else{
              return null;
              }
            },
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
    
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                 controller:registerno ,
                 validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              else{
              return null;
              }
            },
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Register No",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
    
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                 controller:email ,
                 validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
               else{
              return null;
              }
            },
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
    
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                 controller:contact ,
                 validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
               else{
              return null;
              }
            },
                  decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Contact no",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))),
             const SizedBox(height: 25.0),
              ElevatedButton(onPressed: ()async {
                if(_formKey.currentState!.validate()){
                  var response = await FirebaseMethods.updateStudent(docId:docid.text,name: name.text, registerno: registerno.text, email: email.text, contact: contact.text);
                   if (response.code != 200) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(response.message.toString()),
                        );
                      });
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(response.message.toString()),
                        );
                      });
                }
                }
                docid.text='';
                name.text='';
                registerno.text='';
                email.text="";
                contact.text='';

              }, child: const Text('UPDATE')),
              const SizedBox(height: 25.0),

               ElevatedButton(
              onPressed:(){
                 Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const ListPage(),
                ),
                (route) => false, //if you want to disable back feature set to false
              );
              } ,
             child: const Text("View"))
             
    
            ],
            
    
          )),
        ],
        
      ),
    );
  }
}