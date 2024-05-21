
import 'dart:convert';
import 'dart:io';
import 'package:blood/models/calories.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/steps.dart';
import 'package:blood/services/impact2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
 
 
 
 class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : 
super(key: key);
  static const routename = 'Homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routename),
      ),

 body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await _requestDataHeartRate();
               
                print(result);
                final message = result == null ? 'Request failed' : 'Request successful';
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              },
              child: Text('REQUEST THE DATA'),
            ),
            SizedBox(height: 20), // Spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // Logic for logout
                Navigator.pushReplacementNamed(context, '/login'); // Assuming you have a login route
              },
              child: Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
 }

 Future<List<Steps>?> _requestDataSteps() async {
    //Initialize the result
    List<Steps>? result;
   

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final startDate = '2023-05-04';
    final endDate = '2023-05-07'; // prendo i dati di tre giorni
    final url = '${Impact.baseUrl}${Impact.stepsEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
    
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);//steps

    //if OK parse the response, otherwise return null
    if (response.statusCode  == 200) {
      final decodedResponse = jsonDecode(response.body);//steps
    
      result = [];
     List<dynamic> daysData = decodedResponse['data'];//steps
    
     
    for (var dayData in daysData) {
      String date = dayData['date'];
      List<dynamic> stepsData = dayData['data'];
      for (var stepData in stepsData) {
        result.add(Steps.fromJson(date, stepData));
      }
    }
     print('CIAOOOOOOOOOOOOOOOOO');
     print(result.last);
    }
    else{
      result = null;
    }//else
   return result;

  }//_requestData
  Future<List<Calories>?> _requestDataCalories() async {
  // Initialize the result
  List<Calories>? result;

  // Get the stored access token
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');

  // Check and refresh access token if expired
  if (JwtDecoder.isExpired(access!)) {
    await _refreshTokens();
    access = sp.getString('access');
  }

  // Create the request URL (replace with your actual endpoint)
  final startDate = '2023-05-04';
  final endDate = '2023-05-07';
  final url = '${Impact.baseUrl}${Impact.caloriesEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';

  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  // Print request URL for debugging
  print('Calling: $url');

  // Make the GET request
  final response = await http.get(Uri.parse(url), headers: headers);

  // Check for successful response (200)
  if (response.statusCode == 200) {
    try {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      List<dynamic> daysData = decodedResponse['data'];

      for (var dayData in daysData) {
        String date = dayData['date'];
        List<dynamic> caloriesData = dayData['data']; // Replace 'stepsData' with 'caloriesData' if the key is different

        for (var calorieData in caloriesData) {
          // Parse time in hh:mm:ss format
          final timeString = '$date ${calorieData["time"]}';
          final time = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeString);

          // Parse calorie value (consider potential missing value)
          final value = double.parse(calorieData["value"] ?? 0.0); // Use double.parse for decimals, handle missing value

          // Create Calories object
          result.add(Calories(time: time, value: value));
        }
      }
    } on FormatException catch (e) {
      // Handle potential date parsing error
      print("Error parsing date: $e");
      result = null;
    } catch (e) {
      // Handle other unexpected errors
      print("Error fetching calorie data: $e");
      result = null;
    }
  } else {
    print("Request failed with status: ${response.statusCode}");
    result = null;
  }

  return result;
}
  Future<List<HeartRate>?> _requestDataHeartRate() async {
  // Initialize the result
  List<HeartRate>? result;

  // Get the stored access token
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');

  // Check and refresh access token if expired
  if (JwtDecoder.isExpired(access!)) {
    await _refreshTokens();
    access = sp.getString('access');
  }

  // Create the request URL
  final startDate = '2023-03-04';
  final endDate = '2023-03-07';
  var url = '${Impact.baseUrl}${Impact.heartrateEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
  url = 'https://impact.dei.unipd.it/bwthw/data/v1/heart_rate/patients/Jpefaq6m58/daterange/start_date/$startDate/end_date/$endDate/';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  // Print request URL for debugging
  print('Calling: $url');
  // Make the GET request
  final response = await http.get(Uri.parse(url), headers: headers);

  // Check for successful response (200)
  if (response.statusCode == 200) {
    
      final decodedResponse = jsonDecode(response.body);
      result = [];
      List<dynamic> daysData = decodedResponse['data'];

      for (var dayData in daysData) {
        String date = dayData['date'];
        List<dynamic> HRData = dayData['data'];
        for (var hrData in HRData) {
          // Parse time in hh:mm:ss format
          final timeString = '$date ${hrData["time"]}';
          final time = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeString);

          // Parse confidence (handle potential missing value)
          final confidence = hrData["confidence"];

          // Create HeartRate object
          result.add(HeartRate(time: time, value: hrData["value"], confidence: confidence));
           }
    }
     print('CIAOOOOOOOOOOOOOOOOO');
     print(result.last);
    }
    else{
      result = null;
    }//else
     return result;
  }

       


Future<int> _refreshTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 set the tokens
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Return just the status code
    return response.statusCode;

  } //_refreshTokens

    //Return the result
     