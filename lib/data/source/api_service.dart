import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/utils/local_storage_service.dart';

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

  Future<List<Map<String, dynamic>>?> getContributors() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var role =
          await LocalStorageService.getString(LocalStorageService.userRole);

      Response response = await dio.get(
        ApiUrls.users,
        queryParameters: {
          'active': true,
          'sort': 'desc',
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null && data["items"] is List) {
          // Filtrer les utilisateurs par rôle et mapper les résultats
          return (data["items"] as List)
              .where((item) => item["role"] == role)
              .map((item) => {
                    "_id": item["_id"],
                    "name": item["fullname"],
                  })
              .toList();
        }
      }

      // Retourner null si aucune donnée valide n'a été trouvée
      return null;
    } catch (e) {
      // Retourner une exception ou gérer l'erreur selon les besoins
      print("Error fetching users: $e");
      return null;
    }
  }
}
