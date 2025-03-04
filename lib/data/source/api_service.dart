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

  Future<List<Map<String, dynamic>>> getCategories() async {
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
      print("Error fetching categories: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>?> getContributors() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var userId =
          await LocalStorageService.getString(LocalStorageService.userId);
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
              .where((item) => item["_id"] != userId)
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
      // ignore: avoid_print
      print("Error fetching users: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> findPhonenumber(String phonenumber) async {
    try {
      Response response = await Dio().get(
        ApiUrls.findPhonenumber,
        queryParameters: {
          'phonenumber': phonenumber,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        // ignore: avoid_print
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching phone number details: $e");
    }
    return null;
  }

  Future<double> fetchAndSumAmounts(String collectId) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      Response response = await Dio().get(
        ApiUrls.contributes,
        queryParameters: {
          'collect_id': collectId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['items'] != null) {
          final List items = data['items'];
          double totalAmount =
              items.fold(0.0, (sum, item) => sum + (item['amount'] ?? 0.0));
          return totalAmount;
        } else {
          throw Exception('Aucun élément trouvé dans la réponse.');
        }
      } else {
        // ignore: avoid_print
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching phone number details: $e");
    }
    return 0.0;
  }

  Future<double> collectPercent(String collectId, double targetAmount) async {
    double collectAmount = await fetchAndSumAmounts(collectId);
    double percent = (collectAmount * 100) / targetAmount;
    return percent;
  }

  Future<String?> listContributors(String contributorItem) async {
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

        // Filtrage des données en fonction du `role` et du `contributorItem`
        for (var user in data['items']) {
          // Vérification du rôle et de la correspondance de l'ID ou du numéro de téléphone
          if (user['role'] == role && (user['_id'] == contributorItem)) {
            return '${user['fullname']}\n${user['phonenumber']}';
          }
        }
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching users: $e");
    }
    return null;
  }

  Future<bool> checkValidateAccessToken() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      Response response = await dio.get(
        ApiUrls.checkValidateAccessToken,
        queryParameters: {
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  Future<String> getWalletId() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      Response response = await dio.get(
        ApiUrls.wallets,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['items'] != null) {
          final items = data['items'];
          return items[0]['_id'];
        } else {
          throw Exception('Aucun élément trouvé dans la réponse.');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return "";
  }

  Future<bool>verifyTransaction(String transactionId) async {
    try {
      Response response = await dio.get(
        ApiUrls.verifyTransaction,
        queryParameters: {
          'transaction_id': transactionId,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}
