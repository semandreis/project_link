import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_link/main.dart';
import 'package:project_link/user_authentication/utils.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(

        backgroundColor: Colors.black,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CYALA', style: TextStyle(color: Colors.white, fontSize: 40, letterSpacing: 25, fontWeight: FontWeight.w400),),
                SizedBox(height: 40,),
                Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: userNameController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Username (ex: cyala)', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),),

        ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.white),

                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Email (ex: cyala@gmail.com)', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),),
              autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter valid email'
                                : null),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Colors.white30,
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.white),

                        controller: passwordController,
                        textInputAction: TextInputAction.done,

                        decoration: const InputDecoration(hintText: 'Password', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Enter min. 6 Characters'
                            : null),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    color: Colors.white30,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                        style: TextStyle(color: Colors.white),

                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.done,

                        decoration: const InputDecoration(hintText: 'Confirm Password', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value != passwordController.text
                            ? 'Password not matching'
                            : null),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    height: 40,
                    width: 300,
                    
                    child: Center(child: Text('SIGN UP',style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),)),

                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 0.5,
                  width: 350,
                  color: Colors.white,
                ),
                SizedBox(height: 15),

                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'Log In',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return; //return if the form is not valid
    //show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    //async function to create new user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).then((value) async{
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection("users").doc(user?.uid).set(
            {
              'uid': user?.uid,
              'userName': userNameController.text.trim(),
               'email': emailController.text.trim(),
               'password': passwordController.text.trim(),
            });
      });
    } on FirebaseAuthException catch (e) {

      Utils.showSnackBar(e.message);
    }
    //hides the loading indicator
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
