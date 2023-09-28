import 'dart:convert';
import 'package:flipr_employee_managment/app_services/database/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpRequests {
  static const String _baseUrl = "http://192.168.1.12:3000/api/";

  static Future<Map<String, dynamic>?> sendGetRequest(
      {required String url, bool requiresAccess = false}) async {
    Map<String, dynamic>? responseBody;
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          final response = await http.get(Uri.parse(_baseUrl + url),
              headers: {"x-access-token": accessToken});

          debugPrint(response.body);
          responseBody = json.decode(response.body) as Map<String, dynamic>;
        }
        debugPrint("No access token found");
        return null;
      } else {
        debugPrint("Sending without access token to $_baseUrl$url");
        final response = await http.get(Uri.parse(_baseUrl + url));
        responseBody = json.decode(response.body);
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
    return responseBody;
  }

  static Future<Map<String, dynamic>?> sendPostRequest(
      {required String url,
      Map<String, dynamic>? body,
      bool requiresAccess = false}) async {
    String? responseBody;
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          await http
              .post(Uri.parse(_baseUrl + url),
                  headers: {"x-access-token": accessToken},
                  body: json.encode(body))
              .then((response) {
            responseBody = response.body;
          });
        } else {
          debugPrint("No access token found");
        }
      } else {
        debugPrint("Sending without access token to $_baseUrl$url");
        await http.post(Uri.parse(_baseUrl + url), body: body).then((response) {
          responseBody = response.body.toString();
        });
      }
    });

    if (responseBody != null) {
      return jsonDecode(responseBody!);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendPutRequest(
      {required String url,
      Map<String, dynamic>? body,
      bool requiresAccess = false}) async {
    String? responseBody;
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          await http
              .put(Uri.parse(_baseUrl + url),
                  headers: {"x-access-token": accessToken},
                  body: json.encode(body))
              .then((response) {
            responseBody = response.body;
          });
        } else {
          debugPrint("No access token found");
        }
      } else {
        debugPrint("Sending without access token to $_baseUrl$url");
        await http.put(Uri.parse(_baseUrl + url), body: body).then((response) {
          responseBody = response.body;
          debugPrint('responsebody --> \n${responseBody.toString()}\n');
        });
      }
    });

    if (responseBody != null) {
      return json.decode(responseBody!);
    } else {
      return null;
    }
    // return json.decode(responseBody!);
  }

  static Future<Map<String, dynamic>?> sendDeleteRequest(
      {required String url,
      Map<String, dynamic>? body,
      bool requiresAccess = false}) async {
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          final response = await http.delete(Uri.parse(_baseUrl + url),
              headers: {"x-access-token": accessToken}, body: body);
          return response;
        }
        debugPrint("No access token found");
        return null;
      } else {
        debugPrint("Sending without access token");
        final response =
            await http.delete(Uri.parse(_baseUrl + url), body: body);
        return response;
      }
    }).catchError((err) {
      debugPrint(err.toString());
      throw err;
    });
    return null;
  }
}
