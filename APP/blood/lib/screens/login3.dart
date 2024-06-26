import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blood/screens/SignUp_onboarding.dart';
import 'package:blood/services/impact2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage3 extends StatefulWidget {
  const LoginPage3({super.key});

  @override
  State<LoginPage3> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage3> {
  late Color myColor;
  late Size mediaSize;
  static bool _passwordVisible = false;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  final Impact impact = Impact();

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  bool _validateFields() {
    if (userController.text.isEmpty || passwordController.text.isEmpty) {
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
    myColor = const Color.fromARGB(255, 241, 96, 85);
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/prova.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.7), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(children: [
            Positioned(bottom: 0, child: _buildBottom()),
          ]),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 60),
        _buildGreyText("Username"),
        _buildInputField(userController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
       
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextFormField(
      controller: controller,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : Icon(Icons.done),
      ),
      obscureText: isPassword && !_passwordVisible,
    );
}

  

  Widget _buildLoginButton() {
    return MaterialButton(
      onPressed: () async {
        if (_validateFields()) {
          final result = await _authorize();
          if (result == 200) {
            Navigator.pushNamed(context, '/signup_onboarding');
          }
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(8),
                duration: Duration(seconds: 2),
                content: Text("username or password incorrect")));
        }
      },
      color: const Color.fromARGB(255, 241, 96, 85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/twitter.png")),
              Tab(icon: Image.asset("assets/images/instagram.png")),
            ],
          )
        ],
      ),
    );
  }

  Future<int?> _authorize() async {
    // Check if the input credentials match the specified username and password
    if (userController.text == 'x9Cr5EWXIY' && passwordController.text == '12345678!') {
      // Create the request
      final url = Impact.baseUrl + Impact.tokenEndpoint;
      final body = {'username': Impact.username, 'password': Impact.password};

      // Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      // If 200, set the token
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        sp.setString('access', decodedResponse['access']);
        sp.setString('refresh', decodedResponse['refresh']);
      }

      // Just return the status code
      return response.statusCode;
    } else {
      // If credentials don't match, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Incorrect username or password'),
        ),
      );
      return null;
    }
  }
}