import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/login_req_params.dart';
import 'package:likya_app/data/models/password_req_params.dart';
import 'package:likya_app/data/models/password_reset.dart';
import 'package:likya_app/data/models/resendotp_req_params.dart';
import 'package:likya_app/data/models/signup_req_params.dart';
import 'package:likya_app/data/models/update_password_req.dart';
import 'package:likya_app/data/models/verifyotp_req_params.dart';
import 'package:likya_app/utils/local_storage_service.dart';
import '../../service_locator.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> verifyOtp(VerifyotpReqParams verifyotpReq);
  Future<Either> resendOtp(ResendotpReqParams resendotpReq);
  Future<Either> login(LoginReqParams loginReq);
  Future<Either> passwordRequest(PasswordReqParams passwordReq);
  Future<Either> passwordReset(PasswordResetParams passwordReset);
  Future<Either> getUser();
  Future<Either> logout();
  Future<Either> updatePassword(UpdatePasswordReqParams updatePasswordReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.register, data: signupReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> verifyOtp(VerifyotpReqParams verifyotpReq) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.verifyOTP, data: verifyotpReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> resendOtp(ResendotpReqParams resendotpReq) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.resendOtp, data: resendotpReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> login(LoginReqParams loginReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.login, data: loginReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> passwordRequest(PasswordReqParams passwordReq) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.passwordRequest, data: passwordReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> passwordReset(PasswordResetParams passwordReset) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrls.passwordReset, data: passwordReset.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var userId =
          await LocalStorageService.getString(LocalStorageService.userId);
      var response = await sl<DioClient>().get('${ApiUrls.users}/$userId',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      return Right(response);
    } on DioException catch (e) {
      // Check if e.response is null before accessing it
      if (e.response != null) {
        return Left(e.response!.data['message_error']);
      } else {
        // Handle the case when response is null
        return Left('Unknown error occurred');
      }
    }
  }

  @override
  Future<Either> logout() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var response = await sl<DioClient>().get(
        ApiUrls.logout,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> updatePassword(
      UpdatePasswordReqParams updatePasswordReq) async {
    try {
      var userId =
          await LocalStorageService.getString(LocalStorageService.userId);

      var response = await sl<DioClient>().put(
        '${ApiUrls.changePassword}/$userId',
        data: updatePasswordReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
