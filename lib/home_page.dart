import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_link/components/project_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<List<String>> projectsInfo = [];
List<String> tempInfo = [];


class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    _getProjects();
  }
  //Gets the projects from the database and

  CollectionReference _projects =
  FirebaseFirestore.instance.collection('projects');

  Future<void> _getProjects() async {
    QuerySnapshot querySnapshot = await _projects.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      tempInfo.add(a["title"]);
      tempInfo.add(a["description"]);
      tempInfo.add(a["role"]);
      projectsInfo.add(tempInfo);
      tempInfo = [];
    }
  }

  //Builds a List of widgets (projects card) that are passed to the UI
  List<Widget> getList() {
    List<Widget> childs = [];
    for (var i = 0; i < projectsInfo.length; i++) {
      childs.add(new ProjectCard(projectTitle: projectsInfo[i][0], projectDesc: projectsInfo[i][1], projectRole: projectsInfo[i][2],));
      childs.add(new SizedBox(height: 20,));
    }
    projectsInfo =[];
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        child: const Icon(Icons.add),
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
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Good", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),),
                            const Text("Evening ", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w300),),
                          ],
                        ),
                        const Text('Looking forward to work on a project?', style: TextStyle(color: Colors.white60, fontSize: 18),),
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
}
