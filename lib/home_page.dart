import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        child: Icon(Icons.add),
        onPressed: () {  },),
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  width: 450,
                  height: 150,

                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Good", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),),
                            Text("Evening ", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        Text('Looking forward to work on a project?', style: TextStyle(color: Colors.white60, fontSize: 18),),

                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Container(

                        width: 450,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text("ADIRA", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight:  FontWeight.w500, letterSpacing: 2),)),
                              SizedBox(height: 10,),
                              Text("Adira is a social networking site that makes it easy for you to connect and share with family and friends online", style: TextStyle(color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                height: 300,
                                width: 440,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(

                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("CYALA", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight:  FontWeight.w500, letterSpacing: 2),)),
                        SizedBox(height: 10,),
                        Text("Cyala is a social networking site that makes it easy for you to connect and share with family and friends online", style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10,),
                        Container(
                          height: 300,
                          width: 440,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
