import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shreya_demo/student.dart';

class AddData extends StatelessWidget {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  //
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('Students');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Add Data'),
      ),

      //
      body: ListView(
        //
        padding: EdgeInsets.all(16),

        //
        children: [
          //
          TextField(
            //
            controller: nameController,

            //
            textCapitalization: TextCapitalization.words,
            //
            decoration: InputDecoration(
                //
                labelText: 'Name',
                hintText: 'Name',

                //
                border: OutlineInputBorder()),
          ),

          SizedBox(height: 16),
          //
          TextField(
            //
            controller: ageController,

            //
            keyboardType: TextInputType.number,
            //
            decoration: InputDecoration(
                //
                labelText: 'Age',
                hintText: 'Age',

                //
                border: OutlineInputBorder()),
          ),

          SizedBox(height: 16),
          //
          TextField(
            //
            controller: percentageController,

            //
            keyboardType: TextInputType.number,
            //
            decoration: InputDecoration(
                //
                labelText: 'Percentage',
                hintText: 'Percentage',

                //
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 16),
          //

          ElevatedButton(
            //
            child: Text('Add Data'),

            //
            onPressed: () async {
              //
              await addData();

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> addData() async {
    //
    Student student = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      percentage: double.parse(percentageController.text),
    );

    //
    studentsCollection.add(student.toMap());
  }
}
