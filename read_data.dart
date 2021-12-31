import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shreya_demo/add_data.dart';
import 'package:shreya_demo/edit_data.dart';
import 'package:shreya_demo/student.dart';

class ReadData extends StatelessWidget {
  //
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('Students');
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Read Data'),
      ),

      //
      body: StreamBuilder(
        //

        stream: studentsCollection.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //

          return ListView.builder(
            //
            itemCount: snapshot.data.docs.length,

            //
            itemBuilder: (BuildContext context, int index) {
              //

              Student student = Student.fromDocumentSnapshot(
                snapshot.data.docs[index],
              );

              //
              return ListTile(
                //
                isThreeLine: true,
                //
                title: Text('${student.name}'),

                //
                subtitle: Column(
                  //
                  crossAxisAlignment: CrossAxisAlignment.start,

                  //
                  children: [
                    //
                    Text('${student.age}'),

                    //
                    Text('${student.percentage}'),
                  ],
                ),

                //
                leading: CircleAvatar(
                  //
                  child: Text('${student.name[0]}'),
                ),

                //
                trailing: IconButton(
                  //
                  icon: Icon(Icons.delete),

                  //
                  onPressed: () async {
                    await studentsCollection.doc(student.id).delete();
                  },
                ),

                //
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EditData(
                              oldstudent: student,
                            )),
                  );
                },
              );
            },
          );
        },
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => AddData()),
          );
        },
      ),
    );
  }
}
