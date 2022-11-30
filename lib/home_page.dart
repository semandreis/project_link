import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_link/Favorites.dart';
import 'package:project_link/components/project_card.dart';
import 'package:project_link/create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<List<String>> projectsInfo = [];
List<String> tempInfo = [];

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    _getProjects();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
      tempInfo.add(a["imageUrl"]);
      projectsInfo.add(tempInfo);
      tempInfo = [];
    }
  }

  //Builds a List of widgets (projects card) that are passed to the UI
  List<Widget> getList() {
    List<Widget> childs = [];
    for (var i = 0; i < projectsInfo.length; i++) {
      childs.add(new ProjectCard(
        projectTitle: projectsInfo[i][0],
        projectDesc: projectsInfo[i][1],
        projectRole: projectsInfo[i][2],
        delete: false,
        imageUrl: projectsInfo[i][3],
      ));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePost()),
          );
        },
      ),
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
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF004D40), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Hello",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900),
                            ),
                            const Text(
                              "hola ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        const Text(
                          'Looking forward to work on a project?',
                          style: TextStyle(color: Colors.white60, fontSize: 18),
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

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
