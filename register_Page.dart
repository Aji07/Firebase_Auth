//import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';

class Register_Page extends StatefulWidget {
  const Register_Page({Key? key}) : super(key: key);
  @override
  _Register_PageState createState() => _Register_PageState();
}
class _Register_PageState extends State<Register_Page> {
  TextEditingController Username=TextEditingController();
  TextEditingController Password=TextEditingController();
  bool PasswordVisibility=false;
  final _formkey=GlobalKey<FormState>();

  //LoginRequestModel requestModel;

  void PasswordOffOn(){
    setState(() {
            PasswordVisibility = !PasswordVisibility;
    });
   }
 /* void Submit(){
   final isValid=_formkey.currentState.;
   if(!isValid){
     return;
   }
 }*/
 void validateAndSave()async{
    final form=_formkey.currentState;
    SharedPreferences pref=await SharedPreferences.getInstance();
    if(form!.validate())
      {
        //form.save();
        //loginapi();
        if(Username.text.isNotEmpty && Password.text.isNotEmpty){
          print('Enter Firebase.....');
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: Username.text, password: Password.text)
              .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page())));
          pref.setString("email", Username.text);
        }return print('Null Box');

      }else {
      print(' Form Not Valid');
    }

     }
     /*@override
      void initState(){
   super.initState();
   requestModel=new LoginRequestModel( );
     }*/
 /* void loginapi()async{
    print('enter Api');
var data=jsonEncode(<String,dynamic>{
  "name":Username.text,
  "salary":Password.text,
});
var response=await http.post(Uri.parse('https://dummy.restapiexample.com/api/v1/create'),body:data);
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
                     image: NetworkImage("https://wallpapershome.com/images/pages/pic_v/14009.jpg",),
                     fit: BoxFit.cover,
                   ),
                  borderRadius: BorderRadius.circular(15),
                ),
                 child: Container(
                    margin: EdgeInsets.only(top: 150,bottom: 150),
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
                     key:_formkey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text("Register",style: TextStyle(color: Colors.amber,fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                            ),
                            Padding(
                          padding: const EdgeInsets.only(top: 60,left: 30,right: 30),
                          child: TextFormField(
                            controller: Username,
                            keyboardType:TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            validator: (value) {
                              if(value!.isEmpty)
                                {
                                  return " Email Not Empty ";
                                }
                              else if(!value.contains('@')|| (!value.endsWith('.com') || (!RegExp(r'^[a-z]').hasMatch(value)) )){
                                   return "Enter Valid Email";
                              }
                                  return null;
                            },
                            decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor:Colors.white,
                            enabledBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,width: 2.0,
                                ),
                            ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,width: 2.0,
                            )
                          ),
                            hintText: 'Enter Email ID',
                            labelStyle: TextStyle(color:Colors.black,fontSize: 20),
                      ),
                ),
                        ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30,left: 30,right: 30),
                              child: TextFormField(
                                controller: Password,
                                keyboardType:TextInputType.text,
                                cursorColor: Colors.black,
                                obscureText:PasswordVisibility,
                                //onSaved: (value) => password=value,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Password Not Empty";
                                    } else if (value.length<8) {
                                    return "more then 8 character";
                                  }
                                    return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon:IconButton(
                                    icon: Icon(PasswordVisibility ? Icons.visibility_off : Icons.visibility),
                                    onPressed:
                                    PasswordOffOn,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder:OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black54,width: 2.0,
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,width: 2.0,
                                      )
                                  ),
                                  hintText: 'Enter Password',
                                  labelStyle: TextStyle(color:Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow),
                                foregroundColor: MaterialStateProperty.all(Colors.black54),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.black38,width: 1.0)
                                  )
                                )),
                                onPressed:validateAndSave,
                                    /*() {
                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page()));

                                },*/

                                 child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold),),),),
                             SizedBox(height: 20.0,),
                             GestureDetector(
                               onTap: (){
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));
                               },
                               child: Text('Back To Login !!! --->',
                                 style: TextStyle(fontSize: 30.0,
                                     fontWeight: FontWeight.bold,color: Colors.white),),
                             )

                              /*IconButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));

                              }, icon: Icon(Icons.login),iconSize: 15,color: Colors.white,)*/
                            ],)

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
