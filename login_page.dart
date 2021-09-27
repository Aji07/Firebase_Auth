import 'dart:ui';
import 'package:firebase_login/register_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);
  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool PasswordVisibility = false;
  final _formkey = GlobalKey<FormState>();

  //LoginRequestModel requestModel;

  void PasswordOffOn() {
    setState(() {
      print('Show Password');
      PasswordVisibility = !PasswordVisibility;
    });
  }

  /* void Submit(){
   final isValid=_formkey.currentState.;
   if(!isValid){
     return;
   }
 }*/
  void validateAndSave() async {
    final form = _formkey.currentState;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (form!.validate()) {
      //form.save();
      //Api_Service(Dio(),).getLogin().then((value) => print(value));
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: Username.text, password: Password.text)
            .then((value) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home_Page())));
        pref.setString("email", Username.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Auth Message"),
              content: Text(
                "${e.toString()}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp))
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Form Message"),
            content: Text("${form}"),
          );
        },
      );

      print('Not Valid${form}');
    }
  }

  void GoogleSign() async {
    print('Enter Gmail Sign......... ');
    //FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    //final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    print('User Account........${googleSignInAccount.toString()}');

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        user = userCredential.user;
        if (user != null) {print('User Found ${user.toString()}');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home_Page()));
        }else{print('User Not Fount');Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));}
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {}
    }
    else{print('Gmail Auth Failed!!!..........');}
  }

  /*@override
      void initState(){
   super.initState();
   requestModel=new LoginRequestModel( );
     }*/
  /* void loginapi()async{
    print('enter Api');
    var data=jsonEncode(<String,dynamic>{
      "employee_name":Username.text,
      "employee_salary":Password.text,
    });
    var response=await http.get("https://dummy.restapiexample.com/api/v1/employee/1",body:data);
    if(response.statusCode==200){
      print('RESPONSE${response}');
      Map<String,dynamic> map=jsonDecode(response.body);
      String status = map['status'];
      String message= map['message'];
      print('Success${response.body}');
      if(status=='success'){
        showDialog(context: context,
            builder: (context)=>AlertDialog(
              title: Text("Massage\n${message}"),
              actions: [
                FloatingActionButton(onPressed: (){
                  Navigator.pop(context);},
                  child: Text('OK'),
                ),
              ],
            ));
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page()));
        print('create Success${message}');
      }
      else if(status=='failed')
      {
        print('Failed');
        showDialog(context: context,
            builder: (context)=>AlertDialog(
              title: Text("Message\n${message}"),
              actions: [
                FloatingActionButton(onPressed: (){
                  Navigator.pop(context);},
                  child: Text('OK'),
                ),
              ],
            ));

      }
    }else{
      print(" Api Failed");

    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 800,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://wallpapershome.com/images/pages/pic_v/14009.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 150, bottom: 150),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 3,
                        blurRadius: 5,
                      ),
                    ],
                    color: Colors.black54,
                    //border: Border.all(width: 2,color: Colors.green),
                    borderRadius: BorderRadius.circular(25),
                    /*boxShadow: [ BoxShadow(
                        color: Col
                        ors.blue,


                        //offset: Offset(19.0,15.0),
                        blurRadius: 50.0
                      )
                      ]*/
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 60, left: 30, right: 30),
                          child: TextFormField(
                            controller: Username,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Email Not Empty ";
                              } else if ((!value.contains('@') ||
                                  (!RegExp(r'^[0-9,a-z]').hasMatch(value)))) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              )),
                              hintText: 'Enter User Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 30, right: 30),
                          child: TextFormField(
                            controller: Password,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            obscureText: PasswordVisibility,
                            //onSaved: (value) => requestModel.password=value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password Not Empty";
                              } else if (value.length < 6) {
                                return "more then 6 character";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(PasswordVisibility
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: PasswordOffOn,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black54,
                                width: 2.0,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              )),
                              hintText: 'Enter Password',
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.yellow),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Colors.black38,
                                            width: 1.0)))),
                            onPressed: validateAndSave,
                            child: Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          'OR',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                        /*IconButton(onPressed: (){},
                            icon:Icon(Icons.email_sharp,size: 40.0,color: Colors.white,)
                          /*Container(
                          width: 40,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image:DecorationImage(
                              image:NetworkImage('data:image/png;base64,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')
                            ),
                          ),
                        )*/
                        ),*/
                        SizedBox(
                          height: 5.0,
                        ),
                        GestureDetector(
                            onTap: GoogleSign,
                            //radius: 30.0,
                            child: Container(
                              width: 70,
                              height: 55,
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(55.0),
                                  bottomRight: Radius.circular(55.0),
                                  topLeft: Radius.circular(55.0),
                                  topRight: Radius.circular(55.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('Assets/Gmail4.png'),
                                  fit: BoxFit.cover,
                                ),
                                //borderRadius: BorderRadius.all(Radius.circular(30.0))
                              ),
                              //child: Image.asset('Assets/Gmail.png',fit: BoxFit.cover,),
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register_Page()));
                            },
                            child: Text(
                              'Create New Account --->',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
