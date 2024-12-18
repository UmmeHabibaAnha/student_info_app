import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:student_info_app/add_student.dart';
import 'package:student_info_app/model/student.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_info_app/update_student.dart';

import 'database/database_helper.dart';

class ViewAllStudents extends StatefulWidget {
  const ViewAllStudents({super.key});

  @override
  State<ViewAllStudents> createState() => _ViewAllStudentsState();
}

class _ViewAllStudentsState extends State<ViewAllStudents> {
  //declared variables
  late DatabaseHelper dbHelper;
  List<Student> notes = [];

  @override
  void initState() {
    super.initState();
    //initializing dbHelper
    dbHelper = DatabaseHelper.instance;

    //load notes on startup
    addAllStudent();
  }

  //for loading data from db
  Future addAllStudent() async {
    final data = await dbHelper.getAllData();
    setState(() {
      //This line converts a list of map entries (database records) into a list of Note objects using the Note.fromMap method, making it easier to work with custom objects in your app.
      //each element is a map, represented by e
      notes = data.map((e) => Student.fromMap(e)).toList();
    });
  }

  //for deleting a note
  Future deleteNote(int id) async {
    int check = await dbHelper.deleteData(id);
    if (check > 0) {
      Fluttertoast.showToast(msg: "Note deleted successfully");
      addAllStudent();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete note");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent  ,
        title: const Text(
          "View All Students",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No Student Available!"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Student student = notes[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateStudent(student: student)));
                    },
                    // for clickable list item
                    title: Text(
                      student.name!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(student.phone!),
                    leading: const Icon(
                      Icons.phone,
                      size: 40,
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      onPressed: () {
                        deleteNote(student.id!);
                        Get.back();
                      },
                    ),
                  ),
                );
              },
            ),

    );
  }
}
