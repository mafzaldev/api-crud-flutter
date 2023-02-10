import 'dart:async';
import 'dart:convert';
import 'constants.dart';
import 'service_model.dart';
import 'package:http/http.dart' as http;

Future<List<Service>> fetchServices() async {
  final response = await http.get(Uri.parse(ApiConstants.apiUrl));
  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    return body.map<Service>(Service.fromJson).toList();
  } else {
    throw Exception('Failed to load record');
  }
}

Future<String> postService(
    String title, String description, String status) async {
  var body = jsonEncode({
    "title": title.toString(),
    "description": description.toString(),
    "status": status.toString(),
  });
  final response = await http.post(Uri.parse(ApiConstants.apiUrl),
      body: body, headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    return responseMessage['message'];
  } else {
    throw Exception('Failed to send record');
  }
}

Future<String> deleteService(String id) async {
  var body = jsonEncode({"id": id});
  final response =
      await http.delete(Uri.parse(ApiConstants.apiUrl), body: body);

  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    return responseMessage['message'];
  } else {
    throw Exception('Failed to delete record');
  }
}

Future<String> updateService(
    String id, String title, String description, String status) async {
  var body = jsonEncode({
    "id": id.toString(),
    "title": title.toString(),
    "description": description.toString(),
    "status": status.toString(),
  });
  final response = await http.put(Uri.parse(ApiConstants.apiUrl),
      body: body, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var responseMessage = jsonDecode(response.body);
    return responseMessage['message'];
  } else {
    throw Exception('Failed to update record');
  }
}
