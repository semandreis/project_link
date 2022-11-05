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
               decoration: const BoxDecoration(
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
                      const Text("Hello,", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w900),),
                      Text(_userName, style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w200),)
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text("Registered Email", style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  user.email!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                 "Unhappy with current username?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 17),
                child: Container(
                  decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: TextField(

                        controller: userNameController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'New username', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                        const Icon(Icons.change_circle),
                        const SizedBox(width: 10,),
                        const Text("Update username"),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap:  () => FirebaseAuth.instance.signOut(),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white70
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 40,
                        width: 300,
                        child: const Center(child: Text("SIGN OUT",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),)),
                        decoration: const BoxDecoration(
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
