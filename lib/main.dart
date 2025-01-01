import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/auth/auth_state.dart';
import 'package:likya_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/presentation/auth/pages/auth_screen.dart';
import 'package:likya_app/presentation/navigation_menu.dart';
import 'package:likya_app/presentation/onboarding_screen.dart';
import 'package:likya_app/presentation/splash_screen.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? userRole = await ApiService().getRole();
  LocalStorageService.putString(LocalStorageService.userRole, userRole!);
  //LocalStorageService.deleteKey(LocalStorageService.token);

  final prefs = await SharedPreferences.getInstance();
  final showAuthPage = prefs.getBool('showAuthPage') ?? false;

  setupServiceLocator();
  runApp(MyApp(showAuthPage: showAuthPage));
}

class MyApp extends StatelessWidget {
  final bool showAuthPage;
  const MyApp({super.key, required this.showAuthPage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: BlocProvider<ButtonStateCubit>(
        create: (context) => ButtonStateCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('fr', ''), // French
          ],
          locale: Locale('fr', ''),
          title: 'Likya App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF2FA9A2)),
            useMaterial3: true,
            fontFamily: 'Quicksand',
          ),
          home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return NavigationMenu();
              }
              if (state is UnAuthenticated) {
                return showAuthPage ? AuthPage() : OnboardingScreen();
              }
              return SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
