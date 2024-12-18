import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_info_app/View_all_students.dart';
import 'package:student_info_app/model/student.dart';

import 'database/database_helper.dart';
import 'home_page.dart';
class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  late DatabaseHelper dbHelper;

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var locationController=TextEditingController();

  final GlobalKey<FormState> noteFormKey = GlobalKey();

  //add notes to database
  Future addStudent() async
  {
    final newStudent = Student(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );

    //if data insert successfully, its return row number which is greater that 1 always
    int check= await dbHelper.insertData(newStudent.toMap());
    print("Check=$check");
    if(check>0)
    {


      Get.snackbar("Success", "Student Added",snackPosition: SnackPosition.BOTTOM);
      Get.offAll(HomePage());
    }
    else
    {
      Get.snackbar("Error", "Error in adding notes",snackPosition: SnackPosition.BOTTOM);
    }


  }

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.pinkAccent.shade100,
        title: Text("Add Student Information",style: TextStyle(
            color: Colors.white
        ),),

      ),
      body: Form(
        key: noteFormKey,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.pinkAccent,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.person,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                cursorColor: Colors.pinkAccent,
                decoration: InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.phone,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Phone Number";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10,),

              TextFormField(
                controller: emailController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                cursorColor: Colors.pinkAccent,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.email_outlined,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }

                  return null;
                },
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: locationController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                cursorColor: Colors.pinkAccent,
                decoration: InputDecoration(
                  labelText: "Location",
                  hintText: "Location",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.location_city,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your location";
                  }

                  return null;
                },
              ),

              SizedBox(height: 50,),


              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.pinkAccent.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () async {
                  if(noteFormKey.currentState!.validate())
                  {
                    noteFormKey.currentState!.save();

                    addStudent();
                    Get.to(ViewAllStudents());

                  }

                },
                child:  Text(
                  "Save Information",
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),

        ) ,
      ),
      //floatingActionButton: FloatingActionButton(
       // shape: CircleBorder(
          //side: BorderSide(color: Colors.blue),
        //),  //for making circle shape
       // backgroundColor: Colors.blue,
        //tooltip: "Add Note",
       // mini: false,
       // onPressed: () {
        //  Get.to(AddStudent());
        //},
        //child: const Icon(
         // Icons.add,
          //color: Colors.white,
       // ),
     // ),

    );
  }
}


