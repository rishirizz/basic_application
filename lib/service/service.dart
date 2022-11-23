import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api_model/api_model.dart';

Future login(LoginRequestModel loginRequestModel) async {
  Uri url = Uri.parse('https://reqres.in/api/login');
  final response = await http.post(
    url,
    body: loginRequestModel.toJson(),
  );
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Can\'t load data at this moment');
  }
}
