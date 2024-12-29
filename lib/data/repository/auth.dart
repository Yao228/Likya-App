import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/login_req_params.dart';
import 'package:likya_app/data/models/password_req_params.dart';
import 'package:likya_app/data/models/password_reset.dart';
import 'package:likya_app/data/models/resendotp_req_params.dart';
import 'package:likya_app/data/models/signup_req_params.dart';
import 'package:likya_app/data/models/user.dart';
import 'package:likya_app/data/models/verifyotp_req_params.dart';
import 'package:likya_app/data/source/auth_api_service.dart';
import 'package:likya_app/data/source/auth_local_service.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    return sl<AuthApiService>().signup(signupReq);
  }

  @override
  Future<Either> verifyOtp(VerifyotpReqParams verifyotpReq) async {
    return sl<AuthApiService>().verifyOtp(verifyotpReq);
  }

  @override
  Future<Either> resendOtp(ResendotpReqParams resendotpReq) async {
    return sl<AuthApiService>().resendOtp(resendotpReq);
  }

  @override
  Future<Either> login(LoginReqParams loginReq) async {
    Either result = await sl<AuthApiService>().login(loginReq);
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      LocalStorageService.putString(
          LocalStorageService.token, response.data['access_token']);
      LocalStorageService.putString(
          LocalStorageService.userId, response.data['user']['_id']);
      LocalStorageService.putString(
          LocalStorageService.userDetail, jsonEncode(response.data["user"]));
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either<dynamic, dynamic>> getUser() async {
    try {
      String? userJson =
          await LocalStorageService.getString(LocalStorageService.userDetail);
      if (userJson == null) {
        return Left("Utilisateur non trouvés");
      }
      Map<String, dynamic> userMap = jsonDecode(userJson);
      var userModel = UserModel.fromMap(userMap);
      var userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left("Erreur d'analyse des données utilisateur: ${e.toString()}");
    }
  }

  @override
  Future<Either> passwordRequest(PasswordReqParams passwordReq) async {
    return sl<AuthApiService>().passwordRequest(passwordReq);
  }

  @override
  Future<Either> passwordReset(PasswordResetParams passwordReset) async {
    return sl<AuthApiService>().passwordReset(passwordReset);
  }
}
