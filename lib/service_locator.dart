import 'package:get_it/get_it.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/repository/auth.dart';
import 'package:likya_app/data/repository/collect.dart';
import 'package:likya_app/data/repository/contribution.dart';
import 'package:likya_app/data/repository/setting.dart';
import 'package:likya_app/data/repository/transaction.dart';
import 'package:likya_app/data/repository/wallet.dart';
import 'package:likya_app/data/source/contribution_api_service.dart';
import 'package:likya_app/data/source/auth_api_service.dart';
import 'package:likya_app/data/source/auth_local_service.dart';
import 'package:likya_app/data/source/collect_api_service.dart';
import 'package:likya_app/data/source/setting_api_service.dart';
import 'package:likya_app/data/source/transaction_api_service.dart';
import 'package:likya_app/data/source/wallet_api_service.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/domain/repository/setting.dart';
import 'package:likya_app/domain/repository/transaction.dart';
import 'package:likya_app/domain/repository/wallet.dart';
import 'package:likya_app/domain/usecases/add_collect.dart';
import 'package:likya_app/domain/usecases/add_collects_contributors.dart';
import 'package:likya_app/domain/usecases/add_contribution.dart';
import 'package:likya_app/domain/usecases/add_transaction.dart';
import 'package:likya_app/domain/usecases/add_wallet.dart';
import 'package:likya_app/domain/usecases/collect_access.dart';
import 'package:likya_app/domain/usecases/get_collect.dart';
import 'package:likya_app/domain/usecases/get_collects.dart';
import 'package:likya_app/domain/usecases/get_contribution.dart';
import 'package:likya_app/domain/usecases/get_contributors.dart';
import 'package:likya_app/domain/usecases/get_transactions.dart';
import 'package:likya_app/domain/usecases/get_user.dart';
import 'package:likya_app/domain/usecases/get_wallets.dart';
import 'package:likya_app/domain/usecases/is_logged_in.dart';
import 'package:likya_app/domain/usecases/login.dart';
import 'package:likya_app/domain/usecases/logout.dart';
import 'package:likya_app/domain/usecases/password_request.dart';
import 'package:likya_app/domain/usecases/password_reset.dart';
import 'package:likya_app/domain/usecases/resend_otp.dart';
import 'package:likya_app/domain/usecases/signup.dart';
import 'package:likya_app/domain/usecases/update_collect.dart';
import 'package:likya_app/domain/usecases/update_password.dart';
import 'package:likya_app/domain/usecases/update_user.dart';
import 'package:likya_app/domain/usecases/verify_otp.dart';

import 'domain/usecases/get_contributions.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<CollectApiService>(CollectApiServiceImpl());

  sl.registerSingleton<SettingApiService>(SettingApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<ContributionApiService>(ContributionApiServiceImpl());

  sl.registerSingleton<WalletApiService>(WalletApiServiceImpl());

  sl.registerSingleton<TransactionApiService>(TransactionApiServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<CollectRepository>(CollectRepositoryImpl());

  sl.registerSingleton<SettingRepository>(SettingRepositoryImpl());

  sl.registerSingleton<ContributionRepository>(ContributionRepositoryImpl());

  sl.registerSingleton<WalletRepository>(WalletRepositoryImpl());

  sl.registerSingleton<TransactionRepository>(TransactionRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<LoginUseCase>(LoginUseCase());

  sl.registerSingleton<VerifyOtpUseCase>(VerifyOtpUseCase());

  sl.registerSingleton<ResendOtpUsecase>(ResendOtpUsecase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<PasswordRequestUseCase>(PasswordRequestUseCase());

  sl.registerSingleton<PasswordResetUseCase>(PasswordResetUseCase());

  sl.registerSingleton<AddCollectUseCase>(AddCollectUseCase());

  sl.registerSingleton<UpdateCollectUseCase>(UpdateCollectUseCase());

  sl.registerSingleton<GetCollectsUseCase>(GetCollectsUseCase());

  sl.registerSingleton<GetCollectUseCase>(GetCollectUseCase());

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  sl.registerSingleton<UpdateUserUseCase>(UpdateUserUseCase());

  sl.registerSingleton<AddCollectsContributorsUseCase>(
      AddCollectsContributorsUseCase());

  sl.registerSingleton<GetContributorsUseCase>(GetContributorsUseCase());

  sl.registerSingleton<GetContributionsUseCase>(GetContributionsUseCase());

  sl.registerSingleton<CollectAccessUseCase>(CollectAccessUseCase());

  sl.registerSingleton<AddContributionUseCase>(AddContributionUseCase());

  sl.registerSingleton<GetContributionUseCase>(GetContributionUseCase());

  sl.registerSingleton<UpdatePasswordUseCase>(UpdatePasswordUseCase());

  sl.registerSingleton<AddWalletUseCase>(AddWalletUseCase());

  sl.registerSingleton<GetWalletsUseCase>(GetWalletsUseCase());

  sl.registerSingleton<AddTransactionUseCase>(AddTransactionUseCase());

  sl.registerSingleton<GetTransactionsUseCase>(GetTransactionsUseCase());
}
