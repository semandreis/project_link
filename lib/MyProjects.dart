import 'package:flutter/material.dart';


class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(

                    gradient: LinearGradient(
                        colors: [Color(0xFF004D40),Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(

                      children: [
                        Text("YOUR", style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 1),),
                        Text("PROJECTS ", style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w200, letterSpacing: 1),),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
