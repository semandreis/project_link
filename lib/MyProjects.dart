import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_link/Favorites.dart';
import 'package:project_link/components/project_card.dart';
import 'package:project_link/create_post.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({Key? key}) : super(key: key);

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

List<List<String>> projectsInfo = [];
List<String> tempInfo = [];

class _MyProjectsState extends State<MyProjects> {
  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  CollectionReference _projects =
      FirebaseFirestore.instance.collection('projects');
  String? user = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _getProjects() async {
    QuerySnapshot querySnapshot =
        await _projects.where("creator", isEqualTo: user).get();
    print(querySnapshot.docs.length);
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      tempInfo.add(a["title"]);
      tempInfo.add(a["description"]);
      tempInfo.add(a["role"]);
      tempInfo.add(a["imageUrl"]);
      tempInfo.add(a.id);
      projectsInfo.add(tempInfo);
      tempInfo = [];
    }
  }

  List<Widget> getList() {
    List<Widget> childs = [];
    for (var i = 0; i < projectsInfo.length; i++) {
      childs.add(
        GestureDetector(
          onTap: (){_showDialog(i);} ,
          child: new ProjectCard(
            projectTitle: projectsInfo[i][0],
            projectDesc: projectsInfo[i][1],
            projectRole: projectsInfo[i][2],
            imageUrl : projectsInfo[i][3],
            delete: true,
          ),
        ),
      );
      childs.add(new SizedBox(
        height: 20,
      ));
    }
    projectsInfo = [];
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: 900,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    width: 450,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF004D40), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50,),
                          Row(
                            children: [
                              const Text(
                                "Your",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              const Text(
                                "Projects ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                          const Text(
                            'Here\'s a list of your projects',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: getList(),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }

// user defined function
 void _showDialog(int i) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("DELETE"),
          content: new Text("Are you sure you want to delete this project?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text("Delete"),
              onPressed: () {
                  FirebaseFirestore.instance.collection('projects').doc(projectsInfo[i][4]).delete();
                  Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
