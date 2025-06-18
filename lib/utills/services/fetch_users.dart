import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_getx_api_demo/utills/models/user_model.dart';

class ApiService {
  Future<List<User>> fetchUsers() async {
    String Url = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(
      Uri.parse(Url),
      headers: {'Content-Type': 'application/json'},
    );
    print("Url ====> $Url");
    print("Response status: ${response.body}");

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
