import 'package:flipr_employee_managment/app_services/database/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpRequests {
  static const String _baseUrl = "https://localhost:8080/";

  Future<Map<String, dynamic>?> sendGetRequest(
      {required String url, bool requiresAccess = false}) async {
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          final response = await http.get(Uri.parse(_baseUrl + url),
              headers: {"x-access-token": accessToken});
          return response;
        }
        debugPrint("No access token found");
        return null;
      } else {
        debugPrint("Sending without access token");
        final response = await http.get(Uri.parse(_baseUrl + url));
        return response;
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
    return null;
  }

  Future<Map<String, dynamic>?> sendPostRequest(
      {required String url,
      Map<String, dynamic>? body,
      bool requiresAccess = false}) async {
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          final response = await http.post(Uri.parse(url),
              headers: {"x-access-token": accessToken}, body: body);
          return response;
        }
        debugPrint("No access token found");
        return null;
      } else {
        debugPrint("Sending without access token");
        final response = await http.post(Uri.parse(url), body: body);
        return response;
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
    return null;
  }

  Future<Map<String, dynamic>?> sendDeleteRequest(
      {required String url,
      Map<String, dynamic>? body,
      bool requiresAccess = false}) async {
    await SharedPreferenceServices.getAccessToken().then((accessToken) async {
      if (requiresAccess) {
        if (accessToken != null) {
          debugPrint("Sending with access token");
          final response = await http.delete(Uri.parse(url),
              headers: {"x-access-token": accessToken}, body: body);
          return response;
        }
        debugPrint("No access token found");
        return null;
      } else {
        debugPrint("Sending without access token");
        final response = await http.delete(Uri.parse(url), body: body);
        return response;
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
    return null;
  }
}
