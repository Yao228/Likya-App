import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_links/app_links.dart';
import 'package:likya_app/common/bloc/auth/auth_state.dart';
import 'package:likya_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/presentation/auth/pages/auth_screen.dart';
import 'package:likya_app/presentation/deposit/success_deposit_page.dart';
import 'package:likya_app/presentation/navigation_menu.dart';
import 'package:likya_app/presentation/onboarding_screen.dart';
import 'package:likya_app/presentation/splash_screen.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  String? userRole = await ApiService().getRole();
  if (userRole != null) {
    LocalStorageService.putString(LocalStorageService.userRole, userRole);
  }

  LocalStorageService.deleteKey(LocalStorageService.payementUrl);
  LocalStorageService.deleteKey(LocalStorageService.depositAmount);
  LocalStorageService.deleteKey(LocalStorageService.transactionId);

  String? transactionID = await LocalStorageService.getString(LocalStorageService.transactionId);
  print(transactionID);

  final prefs = await SharedPreferences.getInstance();
  final showAuthPage = prefs.getBool('showAuthPage') ?? false;

  runApp(MyApp(showAuthPage: showAuthPage));
}

class MyApp extends StatefulWidget {
  final bool showAuthPage;
  const MyApp({super.key, required this.showAuthPage});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() async {
    final Uri? initialLink = await _appLinks.getInitialAppLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }

    _appLinks.uriLinkStream.listen((Uri uri) {
      _handleDeepLink(uri);
    }, onError: (err) {
      print("Erreur de deep link: $err");
    });
  }

  void _handleDeepLink(Uri uri) async {
    String? paymentStatus = uri.queryParameters['payment_status'];
    String? ref = uri.queryParameters['ref'];

    if (paymentStatus != null && ref != null) {
      print("Paiement $paymentStatus avec ref: $ref");
      String? transactionId = await LocalStorageService.getString(LocalStorageService.transactionId);
      bool verifyTransaction = await ApiService().verifyTransaction(transactionId!);
      print(verifyTransaction);

      if (verifyTransaction) {
        // ignore: use_build_context_synchronously
        String? depositAmount = await LocalStorageService.getString(LocalStorageService.depositAmount);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => SuccessDepositPage(totalAmount: double.tryParse(depositAmount!) ?? 0,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthStateCubit()..appStarted()),
        BlocProvider(create: (context) => ButtonStateCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fr', '')],
        locale: const Locale('fr', ''),
        title: 'Likya App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2FA9A2)),
          useMaterial3: true,
          fontFamily: 'Quicksand',
        ),
        home: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const NavigationMenu();
            } else if (state is UnAuthenticated) {
              return widget.showAuthPage
                  ? const AuthPage()
                  : const OnboardingScreen();
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
