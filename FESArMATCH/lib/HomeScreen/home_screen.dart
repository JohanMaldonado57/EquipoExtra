import 'package:fesarmatch/TabScreen/User_detalles_screen.dart';
import 'package:fesarmatch/TabScreen/fav_sfrs.dart';
import 'package:fesarmatch/TabScreen/like_slrs.dart';
import 'package:fesarmatch/TabScreen/swipping_screen.dart';
import 'package:fesarmatch/TabScreen/viewS_VR_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List tabScreensList = [
    SwippingScreen(),
    ViewSVRS(),
    FavSFR_screen(),
    LikeSLR_screen(),
    UserDetailScreen(userID: FirebaseAuth.instance.currentUser?.uid,),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber){
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white,
        currentIndex: screenIndex,
        items: const [
          //SWIPPING ICON
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.home,
                  size: 30,
              ),
            label: ""
          ),
          //VIEW SENT / RECIEVED ICON
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""
          ),
          //FAVORITES ICON
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""
          ),
          //LIKES ICON
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""
          ),
          //USERDETAILSCREEN ICON
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""
          ),
        ],
      ),
      body: tabScreensList[screenIndex],

    );
  }
}

