import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider_getx_api_demo/utills/models/data_model.dart';

class DataController extends GetxController {
  var dataList = <DataModel>[].obs;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;

  final int limit = 10;
  var page = 1;

  @override
  void onInit() {
    dataPosts();
    super.onInit();
  }

  void dataPosts() async {
    if (!isMoreDataAvailable.value) return;

    isLoading(true);

    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'User-Agent': 'Mozilla/5.0',
      });

      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);

        // Simulate pagination
        final start = (page - 1) * limit;
        final end = start + limit;

        if (start >= result.length) {
          isMoreDataAvailable(false);
        } else {
          final newData = result
              .sublist(start, end > result.length ? result.length : end)
              .map((e) => DataModel.fromJson(e))
              .toList();

          dataList.addAll(newData);
          page++;
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
