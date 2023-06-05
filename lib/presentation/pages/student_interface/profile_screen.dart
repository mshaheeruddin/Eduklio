import 'dart:developer';
import 'dart:io';

import 'package:eduklio/data/repositories/storage_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/signout_usecase.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/login_screen.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/dp_bloc/dp_bloc.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Logout logout = Logout();
  File? profilePic;
  UserRepository userRepository = UserRepository();
  StorageRepository storageRepository = StorageRepository();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [

              SizedBox(height: 20,),
              Column(

                children: [
                  Center(child: _getProfilePicture()),
                  SizedBox(height: 20,),
                  _getEmailAndTick(context),
                  SizedBox(height: 20,),
                  _getAllButtons(context),
                ],
              ),


            ],
          ),
        ),
      ),


    );

  }

  void _gestureAction(String opt_name, BuildContext context) {
    if(opt_name == 'LOGOUT'){
      logout.logOut(context);      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.blueGrey,
        ),
      );
      const snackBar = SnackBar(
        content: Text('Logged OUT!'),
      );

      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => MyLogin()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

//get Logout button
  Widget _getAllButtons(BuildContext context) {
    return Column(
      children: [

        ListTile(
          onTap: () {
            _gestureAction("LOGOUT", context);
          },
          leading: Icon(
            FontAwesomeIcons.user, // Replace with desired Font Awesome icon
            color: Colors.grey,
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),),

      ],
    );
  }

//get email and green tick
  Widget _getEmailAndTick(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
        child: Row(

          children: [
            Center(child: Text('${widget._user.email!} ')),
            SizedBox(width: 2,),
            /*SizedBox(
                height: 24,
                child: Image.asset("assets/images/verified.png")),*/


          ],),
      ),
    );
  }




  //profile image
  Widget _getProfilePicture() {
    return FutureBuilder(
      future: getDp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the result, you can show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          // If an error occurs or there's no data, you can display a placeholder image
          return CircleAvatar(
            radius: 60,
            child: Icon(Icons.person),
          );
        } else {
          // If the future completes successfully, you can access the image URL

          final imageUrl = snapshot.data;

          // Display the profile picture
          return BlocBuilder<DpBloc, DpState>(
  builder: (context, state) {
    return Container(
            width: 118,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal,
                width: 5.0,
              ),
            ),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(state is DpShowState ? state.imageUrl: imageUrl),

                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      // Handle button press
                      ;
                      XFile? selectedImage =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                      BlocProvider.of<DpBloc>(context).add(DpSelectedEvent(true, selectedImage!.path));
                      if (selectedImage != null) {
                        File convertedFile = File(selectedImage.path);
                          profilePic = state is DpShowState ? profilePic = convertedFile : profilePic = convertedFile;

                        log("ImageSelected");
                        // Upload image

                        storageRepository.uploadDp(profilePic, "profile_pic");
                        BlocProvider.of<DpBloc>(context).add(DpUploadingEvent(true,await getDp()));
                        log("ssdasdasdasdasdasd");
                      } else {
                        // Handle case when no image is selected
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  },
);
        }

      },

    );

  }


  //get dp async
  Future<dynamic> getDp() async{
     return userRepository.getFieldFromDocument("users", FirebaseAuth.instance.currentUser!.uid, "profilePic");
  }
}




