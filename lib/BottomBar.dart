import 'package:flutter/material.dart';
import 'package:project_link/Favorites.dart';
import 'package:project_link/Profile.dart';
import 'MyProjects.dart';
import 'home_page.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentTabIndex = 0;
  void onPageChanged(int index){
    setState(() {
      currentTabIndex= index;
    });
  }
  PageController pageController= PageController();
  List<Widget> pages = [const HomePage(), /*const Favorites(),*/ const MyProjects(), const Profile()];

  void onItemTap(int selectedItem){

    pageController.jumpToPage(selectedItem);
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        onTap: onItemTap,
        items: const [
          BottomNavigationBarItem(label: '',icon: Icon(Icons.home_filled, color: Colors.white,)),
          /*BottomNavigationBarItem(label: '',icon: Icon(Icons.favorite, color: Colors.white,)),*/
          BottomNavigationBarItem(label: '',icon: Icon(Icons.star, color: Colors.white,)),
          BottomNavigationBarItem(label: '',icon: Icon(Icons.person, color: Colors.white,)),

        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: pages,

      ),
    );
  }
}
