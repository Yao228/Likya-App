import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';

class ApiService {
  Dio dio = Dio();
  Future<String?> getRole() async {
    try {
      Response response = await dio.get(ApiUrls.roles);
      if (response.statusCode == 200) {
        var data = response.data;
        for (var item in data['items']) {
          if (item['name'] == 'Patient') {
            return item['_id'];
          }
        }
      }
    } catch (e) {
      var error = "Error: $e";
      return error;
    }
    return null;
  }

  Future<Object?> getCategories() async {
    try {
      Response response = await dio.get(ApiUrls.categories);
      if (response.statusCode == 200) {
        var data = response.data;
        return (data["items"] as List).map((item) {
          return {
            "_id": item["_id"],
            "name": item["name"],
          };
        }).toList();
      }
    } catch (e) {
      // ignore: non_constant_identifier_names
      var Error = "Error fetching categories: $e";
      return Error;
    }
    return null;
  }
}
