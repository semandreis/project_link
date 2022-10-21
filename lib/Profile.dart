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
      appBar: AppBar(
        title: Center(
          child: Text("Project Link"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("UserName", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              _userName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Signed In as", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text('Sign out', style: TextStyle(fontSize: 24)),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userNameController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'UserName'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              icon: Icon(Icons.change_circle, size: 32),
              label: Text('Change UserName', style: TextStyle(fontSize: 24)),
              onPressed: () => FirebaseFirestore.instance.collection('users').doc(user.uid).update({'userName': userNameController.text}),
            )
          ],
        ),
      ),
    );
  }
}
