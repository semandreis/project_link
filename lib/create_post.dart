import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_link/main.dart';
import 'package:project_link/user_authentication/utils.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>();
  final pTitleController = TextEditingController();
  final pDescController = TextEditingController();
  final pRoleController = TextEditingController();
  String imageUrl = '';

  @override
  void dispose() {
    pTitleController.dispose();
    pDescController.dispose();
    pRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 500,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF004D40), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GOT A NEW IDEA?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1),
                          ),
                          Text(
                            "FIND YOUR TEAMMATE",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius:
                                BorderRadius.all(Radius.circular(70))),
                        child: IconButton(
                          onPressed: () async {
                            ImagePicker imagepicker = ImagePicker();
                            XFile? file = await imagepicker.pickImage(source: ImageSource.camera);

                            if(file==null) return;
                            String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                            Reference referenceRoot = FirebaseStorage.instance.ref();
                            Reference referenceDirImages = referenceRoot.child('images');

                            Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

                            try{
                              await referenceImageToUpload.putFile(File(file.path));
                              imageUrl = await referenceImageToUpload.getDownloadURL();//get img url
                            }catch(error){

                            }
                          },
                          icon: Icon(Icons.photo_camera,size: 30,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Add a display picture of your project',
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: pTitleController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.white),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value == ""
                              ? 'Empty field'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Project title (ex: CYALA)",
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          controller: pDescController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          style: TextStyle(color: Colors.white),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value == ""
                              ? 'Empty field'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Short Description",
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: pRoleController,
                          style: TextStyle(color: Colors.white),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value == ""
                              ? 'Empty field'
                              : null,
                          decoration: InputDecoration(
                            hintText: "Project role (ex: Android Developer)",
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: addProject,
                          child: Container(
                            height: 30,
                            width: 150,
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              'POST',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addProject() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    //show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    if(imageUrl.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please upload an image')));
      return;
    }
    //async function to create new user
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("projects").add({
        'creator': user?.uid,
        'description': pDescController.text.trim(),
        'role': pRoleController.text.trim(),
        'title': pTitleController.text.trim(),
        'imageUrl':imageUrl,
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    //hides the loading indicator
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
