import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_info_app/View_all_students.dart';
import 'database/database_helper.dart';
import 'home_page.dart';
import 'model/student.dart';


class UpdateStudent extends StatefulWidget {

   final student;
   const UpdateStudent({super.key,required this.student});
   //const ViewAllStudents({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  late DatabaseHelper dbHelper;

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var locationController=TextEditingController();

  final GlobalKey<FormState> noteFormKey = GlobalKey();

  int? id;

  //add notes to database
  Future  updateInfo(int id) async
  {
    final updatedStudent = Student(

      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,

    );

    print("student id=$id");
    int check= await dbHelper.updateData(updatedStudent.toMap(),id);
    print("Check=$check");
    if(check>0)
    {

      Get.snackbar("Updated", "Information Updated",snackPosition: SnackPosition.BOTTOM);
     // Get.offAll(HomePage());
      Get.offAll(ViewAllStudents());

    }
    else
    {
      Get.snackbar("Error", "Error in Information update",snackPosition: SnackPosition.BOTTOM);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DatabaseHelper.instance;
    nameController.text=widget.student.name;
    phoneController.text=widget.student.phone;
    emailController.text=widget.student.email;
    locationController.text=widget.student.location;
    id=widget.student.id;

    //print("student_id= $id");


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.pinkAccent,
        title: Text("Update Information",style: TextStyle(
            color: Colors.white
        ),),

      ),
      body: Form(
        key: noteFormKey,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [

              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Name",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.person,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pinkAccent)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pinkAccent)
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter proper details";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                controller: phoneController,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",labelStyle: TextStyle(color: Colors.pinkAccent),
                  prefixIcon: const Icon(Icons.phone,color: Colors.pinkAccent,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
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
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: ()  async{
                  if(noteFormKey.currentState!.validate())
                  {
                    noteFormKey.currentState!.save();

                      //updateInfo(widget.student.id!);
                    updateInfo(id!);
                    Get.to(ViewAllStudents());

                  }

                },
                child:  Text(
                  "Update Information",
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),

                ),
              ),

            ],
          ),

        ) ,
      ),



    );
  }
}





















