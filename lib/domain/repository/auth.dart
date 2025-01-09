import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/login_req_params.dart';
import 'package:likya_app/data/models/password_req_params.dart';
import 'package:likya_app/data/models/password_reset.dart';
import 'package:likya_app/data/models/resendotp_req_params.dart';
import 'package:likya_app/data/models/signup_req_params.dart';
import 'package:likya_app/data/models/verifyotp_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> verifyOtp(VerifyotpReqParams verifyotpReq);
  Future<Either> resendOtp(ResendotpReqParams resendotpReq);
  Future<Either> login(LoginReqParams loginReq);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
  Future<Either> passwordRequest(PasswordReqParams passwordReq);
  Future<Either> passwordReset(PasswordResetParams passwordReset);
  Future<Either> findPhonenumber(String phoneNumber);
  Future<Either> logout();
}
