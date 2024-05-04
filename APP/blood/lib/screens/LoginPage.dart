import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:blood/services/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({Key? key}) : super(key: key);
   
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final _formKey = GlobalKey<FormState>();
  final Impact impact = Impact();

  //quando clicco icona occhio mi fa vedere la password e viceversa
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  
  //funzione validate per controllo campi email e password
  bool _validateFields() {
  if (userController.text.isEmpty ||passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Username and password are required'),
      ),
    );
    return false;
  }
 
  return true;
}


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/LoginPage.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeInUp(duration: Duration(milliseconds: 1000), 
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'), //da togliere
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1500), 
                  child:Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  SizedBox(height: 30,),
                  FadeInUp(duration: Duration(milliseconds: 1700), 
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Color.fromRGBO(196, 135, 198, .3)
                            ))
                          ),
                          child: TextFormField(
                            validator: (String? value) {
                               if (value == null || value.isEmpty) {
                                return 'Username is required';}
                                 return null;
                                 },
                            controller: userController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              prefixIcon: Icon(Icons.email)
                            ),
                          ),
                        ),
                         Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                                }
                                return null;},
                            controller: passwordController,
                            obscureText: !_passwordVisible,

                            //obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              prefixIcon: Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                  color: Colors.grey,
                                  ),
                                  onPressed: () {
                                     _showPassword();
                                     },
                              ),


                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1700), child: Center(child: TextButton(onPressed: () {}, child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),)))),
                  SizedBox(height: 30,),
                  FadeInUp(duration: Duration(milliseconds: 1900), 
                  child: MaterialButton(
                    onPressed: () async {
                       if (_validateFields()) {
                       
                        final result = await impact.getAndStoreTokens(
                            userController.text, passwordController.text);
                        if (result == 200) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('username', userController.text);
                          await sp.setString(
                              'password', passwordController.text);
                          Navigator.pushNamed(context, '/form');
                        }
                       
                        else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(8),
                                duration: Duration(seconds: 2),
                                content:
                                    Text("username or password incorrect")));
                        }
                      
                    }
                    },
                    
                    color: Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white),),
                    ),
                  )),
                  SizedBox(height: 30,),
                  FadeInUp(duration: Duration(milliseconds: 2000), child: Center(child: TextButton(onPressed: () {}, child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}