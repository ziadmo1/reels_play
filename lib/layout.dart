import 'package:flutter/material.dart';
import 'package:reels_play/home_screen.dart';
import 'package:reels_play/upload_video.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex= 0;
  List screens = [HomeScreen(),UploadVideo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 1
            )
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
            onTap: (index){
            currentIndex = index;
            setState(() {

            });
            },
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.red,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.video_collection),label: 'Reels',),
          BottomNavigationBarItem(icon: Icon(Icons.upload),label: 'Upload',),
        ]),
      ),
      body: screens[currentIndex],
    );
  }
}
