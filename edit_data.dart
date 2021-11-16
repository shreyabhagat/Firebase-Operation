import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shreya_demo/student.dart';

class EditData extends StatelessWidget {
  //
  final Student oldstudent;

  EditData({Key? key, required this.oldstudent}) : super(key: key);
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();

  //
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('Students');

  @override
  Widget build(BuildContext context) {
    //
    nameController.text = oldstudent.name;
    ageController.text = oldstudent.age.toString();
    percentageController.text = oldstudent.percentage.toString();

    return Scaffold(
      //
      appBar: AppBar(
        title: Text('EditData'),
      ),

      //
      body: ListView(
        //
        padding: EdgeInsets.all(16),

        //
        children: [
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
            child: Text('Edit Data'),

            //
            onPressed: () async {
              await editData();

              //
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> editData() async {
    Student newStudent = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      percentage: double.parse(percentageController.text),
    );

    await studentCollection.doc(oldstudent.id).update(newStudent.toMap());
  }
}
