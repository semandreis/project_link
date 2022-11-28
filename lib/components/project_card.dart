import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String projectTitle;
  final String projectDesc;
  final String projectRole;
  final String imageUrl;
  final bool delete;
  const ProjectCard({Key? key, required this.projectTitle,required this.projectDesc,required this.projectRole, required this.delete, required this.imageUrl}) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(widget.projectTitle, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight:  FontWeight.w500, letterSpacing: 2),)),
            const SizedBox(height: 10,),
            Text(widget.projectDesc, style: const TextStyle(color: Colors.white),),
            const SizedBox(height: 10,),
            Container(
              height: 300,
              width: 440,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child:Image.network(widget.imageUrl) ,
            ),
            const SizedBox(height: 10,),
            Text("Project Role: " + widget.projectRole, style: const TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
