import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_link/main.dart';
import 'package:project_link/user_authentication/utils.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CYALA', style: TextStyle(color: Colors.white, fontSize: 40, letterSpacing: 25, fontWeight: FontWeight.w400),),
            SizedBox(height: 50,),


            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Colors.white30,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: TextField(

                      controller: emailController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Email (ex: cyala@gmail.com)', hintStyle: TextStyle(color: Colors.white70), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Colors.white30,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: 'Password', hintStyle: TextStyle(color: Colors.white70),focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                    obscureText: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            GestureDetector(
              onTap: signIn ,
              child: Container(height: 40, width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),

                child: Center(child: Text('SIGN IN', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),)),

              ),
            ),

            SizedBox(height: 20),
            Container(
              height: 0.5,
              width: 350,
              color: Colors.white,
            ),
            SizedBox(height: 20,),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 17),
                text: 'Don\'t have an account? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Create Account',
                    style: TextStyle(
                      fontSize: 17,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
