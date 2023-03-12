import 'dart:convert';
import 'package:http/http.dart';
import '../business_logic/errors/user_not_found.dart';

class RemoteServerService {
  
  final String serverAddress = 'http://192.168.43.149:8000';
  final Map<String, String> customHeaders = {
    "content-type": "application/json"
  };

  Future<Map<String, dynamic>> signIn(String userId, String password) async {
    Response response = await post(Uri.parse("$serverAddress/users/signin"),
        headers: customHeaders,
        body: jsonEncode({"uniqueId": userId, "password": password}));

    if(response.statusCode == 404){
      throw UserNotFoundError(userId, password);
    } else if(response.statusCode == 500){
      throw "Server error";
    }
    print("response is ");
    print(response.body);
    final Map<String, dynamic> json =  jsonDecode(response.body);
    return json;
  }

  Future<Map<String, dynamic>> signUp(String uniqueId, String password) async {
    throw "oops";
  }

  Future changePassword(String userId, String currentPassword, String newPassword) async {
    final reqBody =  jsonEncode({
      "userId": userId, 
      "current": currentPassword, 
      "new": newPassword
    });
    //todo: change api url
    Response response = await post(Uri.parse("$serverAddress/users/"),
      headers: customHeaders,
      body: reqBody
    );

    if(response.statusCode == 404){
      throw UserNotFoundError(userId, currentPassword);
    } else if(response.statusCode == 500){
      throw "Server error";
    }
  }
} 