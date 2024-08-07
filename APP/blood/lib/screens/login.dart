import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blood/screens/signUp_onboarding.dart';
import 'package:blood/services/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          backgroundColor: Color.fromARGB(255, 240, 175, 175),
          content: Text('Username and password are required'),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 186, 235, 232),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/login_image.png',
                  fit: BoxFit.cover,
                  height: 350, //altezza immagine
                ),
              ),
              Positioned(
                bottom: 0,
                child: _buildBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
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
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
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
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromARGB(255, 145, 144, 144),
          width: 1.0,
        ),
      ),
      child: TextFormField(
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
                  onPressed: _showPassword,
                )
              : Icon(Icons.done),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: isPassword && !_passwordVisible,
      ),
    );
  }

  Widget _buildLoginButton() {
    return MaterialButton(
      onPressed: () async {
        if (_validateFields()) {
          final result = await _authorize();
          if (result == 200) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PersonalInfoOnboarding()),
              (Route<dynamic> route) => false,
            );
          }
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(238, 247, 155, 155),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(8),
              duration: Duration(seconds: 2),
              content: Text("username or password incorrect"),
            ));
        }
      },
      color: Color.fromARGB(255, 240, 175, 175),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
    );
  }

  Future<int?> _authorize() async {
    // Controllo delle credenziali
    if (userController.text == 'x9Cr5EWXIY' &&
        passwordController.text == '12345678!') {
      // creo richiesta
      final url = Impact.baseUrl + Impact.tokenEndpoint;
      final body = {'username': Impact.username, 'password': Impact.password};

      // Risposta
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        sp.setString('access', decodedResponse['access']);
        sp.setString('refresh', decodedResponse['refresh']);
      }

      return response.statusCode;
    } else {
      //messaggio di errore se credenziali non sono corrette
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(238, 247, 155, 155),
          content: Text('Incorrect username or password'),
        ),
      );
      return null;
    }
  }
}
