import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bottombar.dart';
import 'package:eduklio/presentation/pages/teacher_interface/subject_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter_login/entity/user.dart';

import '../../../data/repositories/general_repository.dart';
import '../../../domain/entities/class.dart';
import '../../../domain/usecases/manageclass_usecase.dart';
import '../../dialogs/class_dialog.dart';

class ManageClass extends StatefulWidget {
  final ClassManager classManager;
  String className = "";
  ManageClass({required this.classManager});

  @override
  _ManageClassState createState() => _ManageClassState(className);
}

class _ManageClassState extends State<ManageClass> {
  @override
  String className = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _ManageClassState(this.className);

  Widget build(BuildContext context) {



    UserRepository userRepository = UserRepository();
    ClassRepository classRepository = ClassRepository();

    //streambuilder to get
    Widget realTimeDisplayOfAdding(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        //subscribed to firestore collection called users
        //so whenever doc is added/changed, we get 'notification'
        stream: _firestore.collection("teacher_classes").snapshots(),
        //snapshot is real time data we will get
        builder: (context, snapshot) {
          //if connection (With firestore) is established then.....
          if (snapshot.connectionState == ConnectionState.active) {
            if(snapshot.hasData && snapshot.data != null) {
              return Expanded(
                child: ListView.builder(
                  //length as much as doc we have
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //from docs array we are now selecting a doc
                    Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    //get users document id
                    String documentId = snapshot.data!.docs[index].id;

                    if(FirebaseAuth.instance.currentUser!.uid == userRepository.getUserUID()) {
                      return Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          BottomBar(userMap["className"])));
                                },

                                title: Text(userMap["className"],
                                    style: TextStyle(fontSize: 22)),
                                subtitle: Text(userMap["classCode"],
                                    style: TextStyle(fontSize: 15)),
                                trailing: IconButton(onPressed: () {
                                  //delete with specific document function comes
                                  userRepository.deleteSomethingFromCollection("teacher_classes", documentId);
                                  classRepository.deleteArrayValueFromCollection("teachers", documentId, FirebaseAuth.instance.currentUser!.uid);
                                  classRepository.deleteArrayValueFromCollection("users", documentId, FirebaseAuth.instance.currentUser!.uid);

                                },
                                  icon: Icon(Icons.delete),

                                ),
                              ),
                            ],
                          ),

                        ),
                        /* title: Text(currentClass.className),
                    subtitle: Text(currentClass.classCode),*/
                      );
                    }
                  },),
              );
            }
            else {
              return Text("No Data");
            }}
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }},
      );
    }


    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.arrowLeft)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 14),
            child: Text(
              'Manage your classes',
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          realTimeDisplayOfAdding(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ClassDialog(classManager: widget.classManager);

            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
