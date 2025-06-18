import 'package:flutter/foundation.dart';
import 'package:provider_getx_api_demo/utills/models/user_model.dart';
import 'package:provider_getx_api_demo/utills/services/fetch_users.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // _users = await _apiService.fetchUsers();
      _users = await ApiService().fetchUsers();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
