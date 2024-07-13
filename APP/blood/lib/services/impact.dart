import 'dart:convert';
import 'dart:io';
import 'package:blood/models/calories.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/steps.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Impact {
  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';
  static String stepsEndpoint = 'data/v1/steps/patients/';
  static String heartrateEndpoint = 'data​/v1​/heart_rate​/patients/';
  
  static String caloriesEndpoint = 'data/v1/calories/patients/';
  static String username = 'x9Cr5EWXIY';
  static String password = '12345678!';
  static String patientUsername = 'Jpefaq6m58';


  

  //This method allows to check if the IMPACT backend is up
  Future<bool> isImpactUp() async {
    //Create the request
    final url = Impact.baseUrl + Impact.pingEndpoint;

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url));

    //Just return if the status code is OK
    return response.statusCode == 200;
  } //_isImpactUp

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> getAndStoreTokens(String username, String password) async {
    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': username, 'password': password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens

  //This method allows to refrsh the stored JWT in SharedPreferences
  
  Future<int> refreshTokens() async {
    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    if (refresh != null) {
      final body = {'refresh': refresh};

      //Get the response
      print('Calling: $url');
      final response = await http.post(Uri.parse(url), body: body);

      //If the response is OK, set the tokens in SharedPreferences to the new values
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('access', decodedResponse['access']);
        await sp.setString('refresh', decodedResponse['refresh']);
      } //if

      //Just return the status code
      return response.statusCode;
    }
    return 401;
  } //_refreshTokens

  //This method checks if the saved token is still valid
  Future<bool> checkSavedToken({bool refresh = false}) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(refresh ? 'refresh' : 'access');

    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return Impact.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }
    return true;
  } //checkToken

  //This method prepares the Bearer header for the calls
  Future<Map<String, String>> getBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('access');

    return {'Authorization': 'Bearer $token'};
  }

  Future<void> getPatient() async {
    var header = await getBearer();
    final r = await http.get(
        Uri.parse('${Impact.baseUrl}study/v1/patients/active'),
        headers: header);

    final decodedResponse = jsonDecode(r.body);
    final sp = await SharedPreferences.getInstance();

    sp.setString('impactPatient', decodedResponse['data'][0]['username']);
  }

//funzione che ritorna i dati
//ritorna una variabile di tipo Map con al suo interno chiavi sottoforma di stringhe e valore sottoforma di lista
Future<Map<String, List<dynamic>>?> getDataFrom3Days(DateTime startTime, DateTime endTime) async {
  //Get the stored access token
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');


  // Check and refresh access token if expired
  if (JwtDecoder.isExpired(access!)) {
   print('Expired');
   await refreshTokens();
   access = sp.getString('access');
 }

  // Define URLs and endpoints
  final startDate = DateFormat('yyyy-MM-dd').format(startTime);
  final endDate = DateFormat('yyyy-MM-dd').format(endTime);
  final heartRateUrl = 'https://impact.dei.unipd.it/bwthw/data/v1/heart_rate/patients/Jpefaq6m58/daterange/start_date/$startDate/end_date/$endDate/';
  final stepsUrl = '${Impact.baseUrl}${Impact.stepsEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
  final caloriesUrl = '${Impact.baseUrl}${Impact.caloriesEndpoint}${Impact.patientUsername}/daterange/start_date/$startDate/end_date/$endDate/';
  
  // Make requests for heart rate, steps, and calories
  final heartRateFuture = await _requestDataHeartRate(access, heartRateUrl);
  final stepsFuture = await _requestDataSteps(access, stepsUrl);
  final caloriesFuture = await _requestDataCalories(access, caloriesUrl);

  // Await results
  final heartRateResult =  heartRateFuture;
  final stepsResult =  stepsFuture;
  final caloriesResult =  caloriesFuture;

  // Check for any failed requests
  if (heartRateResult == null || stepsResult == null || caloriesResult == null) {
    // Handle request failure
    return null;
  }

  // Return combined results
  
  return {
    'heartRates': heartRateResult,
    'steps': stepsResult,
    'calories': caloriesResult,
  };
}

//funzione per richiedere steps
 Future<List<Steps>?> _requestDataSteps(access,stepsUrl) async {
    //Initialize the result
    List<Steps>? result;

    
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};
    

    //Get the response
    final response = await http.get(Uri.parse(stepsUrl), headers: headers);//steps

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
    
    }
    else{
      result = null;
    }//else
   return result;

  }//_requestDataSteps

//funzione per richiedere calories
  Future<List<Calories>?> _requestDataCalories(access, caloriesUrl) async {
  // Initialize the result
  List<Calories>? result;
  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};


  // Make the GET request
  final response = await http.get(Uri.parse(caloriesUrl), headers: headers);
  

  // Check for successful response (200)
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    result = [];
    List<dynamic> daysData = decodedResponse['data'];

    for (var dayData in daysData) {
      String date = dayData['date'];
      List<dynamic> caloriesData = dayData['data']; 
      for (var calorieData in caloriesData) {
          // Parse time in hh:mm:ss format
        final timeString = '$date ${calorieData["time"]}';
        final time = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeString);

          // Parse calorie value (consider potential missing value)
        final value = double.parse(calorieData["value"] ?? 0.0);
         // Use double.parse for decimals, handle missing value
        result.add(Calories(time: time, value: value));
      }
    }
  }
  else{
    result= null;
  }
  return result;
  }
//funzione per richiedere heartrate
  Future<List<HeartRate>?> _requestDataHeartRate(access, heartRateUrl) async {
  // Initialize the result
  List<HeartRate>? result;

  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};
  // Make the GET request
  final response = await http.get(Uri.parse(heartRateUrl), headers: headers);
  

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
    
    }
    else{
      result = null;
    }//else
    return result;
  }
  

} //Impact. 