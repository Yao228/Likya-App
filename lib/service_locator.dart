import 'package:get_it/get_it.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/repository/auth.dart';
import 'package:likya_app/data/repository/collect.dart';
import 'package:likya_app/data/source/auth_api_service.dart';
import 'package:likya_app/data/source/auth_local_service.dart';
import 'package:likya_app/data/source/collect_api_service.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/domain/usecases/collect.dart';
import 'package:likya_app/domain/usecases/get_collect.dart';
import 'package:likya_app/domain/usecases/get_collects.dart';
import 'package:likya_app/domain/usecases/get_user.dart';
import 'package:likya_app/domain/usecases/is_logged_in.dart';
import 'package:likya_app/domain/usecases/login.dart';
import 'package:likya_app/domain/usecases/password_request.dart';
import 'package:likya_app/domain/usecases/password_reset.dart';
import 'package:likya_app/domain/usecases/resend_otp.dart';
import 'package:likya_app/domain/usecases/signup.dart';
import 'package:likya_app/domain/usecases/verify_otp.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<CollectApiService>(CollectApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<CollectRepository>(CollectRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<LoginUseCase>(LoginUseCase());

  sl.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase());

  sl.registerSingleton<ResendOtpUsecase>(ResendOtpUsecase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<PasswordRequestUseCase>(PasswordRequestUseCase());

  sl.registerSingleton<PasswordResetUseCase>(PasswordResetUseCase());

  sl.registerSingleton<CollectUseCase>(CollectUseCase());

  sl.registerSingleton<GetCollectsUseCase>(GetCollectsUseCase());

  sl.registerSingleton<GetCollectUseCase>(GetCollectUseCase());
}
