import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      body: Container(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("GOT A NEW IDEA?", style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: 1),),
                      Text("FIND YOUR TEAMMATE", style: TextStyle(color: Colors.white70,fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
              ),


              SizedBox(height: 0,),
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                child: Center(
                  child: Container(
                    height: 100,
                  width: 100,
                    decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(Radius.circular(70))
                    ),
                    child: Icon(Icons.photo_camera, size: 30,),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text('Add a display picture of your project', style: TextStyle(color: Colors.white, letterSpacing: 1),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white10
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(


                      style: TextStyle(color: Colors.white),
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
                padding: const EdgeInsets.only(left: 10, top: 15,right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                        keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyle(color: Colors.white),
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
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 30,
                    width: 150,

                    color: Colors.white,
                      child: Center(child: Text('POST',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 3),)),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
