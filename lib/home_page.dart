import 'package:flutter/material.dart';
import 'package:student_info_app/View_all_students.dart';
import 'package:student_info_app/add_student.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text("Student Information",style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           ElevatedButton(
                  onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStudent()));
              },
             style: ElevatedButton.styleFrom(
                     minimumSize: Size(
                 MediaQuery.of(context).size.width , // 100% of screen width
                 MediaQuery.of(context).size.height * 0.10, // 10% of screen height
               ),
               backgroundColor: Colors.blueAccent.shade100,

             ),

                child:Text("Add Student",style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),),
              ),


            SizedBox(height: 15,),

            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAllStudents()));

                },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height*0.10,

                ),
                backgroundColor: Colors.blueAccent.shade100,

              ),
                child: Text('View All Students',style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                )),
            ),


          ],
        ),
      ),
    );
  }
}
