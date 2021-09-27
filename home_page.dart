import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/login_page.dart';
import 'package:flutter/material.dart';
class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  var CurrentUser = FirebaseAuth.instance.currentUser;
  int CurrentIndex=0;
  void Bottom_OnTap(int index){
    setState(() {
      CurrentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          //radius: 30.0,
          //backgroundImage: NetworkImage('https://www.pngfind.com/pngs/m/292-2924933_image-result-for-png-file-user-icon-black.png',),
          //child:  Image.asset('Assets/Profile.png',),
          child: Icon(Icons.person_rounded,color: Colors.white,size: 50.0,),
        ),
        leadingWidth: 110.0,
        title: Text("      Welcome\n${CurrentUser!.email.toString()}",
          style: TextStyle(color: Colors.white),),
          actions: [
            MaterialButton(
              shape: CircleBorder(),
              onPressed: ()async{
            await FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context,
           MaterialPageRoute(builder: (context)=>Login_Page())));
            },
              //child: Image.asset('Assets/Logout.png'),
              child: Icon(Icons.logout_rounded,color: Colors.white,size: 30.0,),
          )
          ],
      ),
      body: Center(child: CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,)),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: CurrentIndex,
        onTap: Bottom_OnTap,
        iconSize: 30.0,
        elevation: 2.0,
        selectedItemColor: Colors.white,
        //unselectedItemColor: Colors.black,
        backgroundColor: Colors.white60,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded),label: 'Profile'),
        ],
      ),
    );

  }
}
