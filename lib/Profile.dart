import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

}
String _userName ="";


class _ProfileState extends State<Profile> {
  final userNameController = TextEditingController();

  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()!['userName'] ?? " ";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 450,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   colors: [Color(0xFF004D40),Colors.black],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter
                 ),
                 
               ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello,", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w900),),
                      Text(_userName, style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w200),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Registered Email", style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  user.email!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                 "Unhappy with current username?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: TextField(

                        controller: userNameController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'New username', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () => FirebaseFirestore.instance.collection('users').doc(user.uid).update({'userName': userNameController.text}),
                  child: Container(
                    height: 40,
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.change_circle),
                        SizedBox(width: 10,),
                        Text("Update username"),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              ),



              SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap:  () => FirebaseAuth.instance.signOut(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white70
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: Center(child: Text("SIGN OUT",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black87
                        ),
                      ),
                    ),
                  ),
                ),
              ),



            ],
          ),
      ),

    );
  }
}
