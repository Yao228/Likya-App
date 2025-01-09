import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/auth/auth_state_cubit.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/text_base_button.dart';
import 'package:likya_app/data/models/login_req_params.dart';
import 'package:likya_app/domain/usecases/login.dart';
import 'package:likya_app/presentation/auth/pages/login/login_screen.dart';
import 'package:likya_app/presentation/auth/pages/password-reset/password_request.dart';
import 'package:likya_app/presentation/navigation_menu.dart';
import 'package:likya_app/service_locator.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({required this.phonenumber, super.key});
  final String phonenumber;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  bool _autoLoginFailed = false;
  bool _loginProgress = false;
  bool _loginSuccess = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void onChanged(String value, int index) {
    setState(() {
      if (value.isNotEmpty && index < focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else if (value.isEmpty && index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }

      String code = controllers.map((c) => c.text).join();
      if (code.length == 4) {
        _autoLogin(code);
      }
    });
  }

  void _autoLogin(String code) {
    if (code.isNotEmpty) {
      context.read<AuthStateCubit>().appStarted();
      context.read<ButtonStateCubit>().performAutoLogin(
            usecase: sl<LoginUseCase>(),
            params: LoginReqParams(
              password: code,
              phonenumber: widget.phonenumber,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonLoadingState) {
            setState(() {
              _loginProgress = true;
            });
          }
          if (state is ButtonSuccessState) {
            (context) => AuthStateCubit()..appStarted();
            setState(() {
              _loginProgress = false;
              _loginSuccess = true;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NavigationMenu()),
            );
          }
          if (state is ButtonFailureState) {
            setState(() {
              _loginProgress = false;
              _autoLoginFailed = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  formTitle(),
                  const SizedBox(height: 10),
                  signupImage(),
                  const SizedBox(height: 20),
                  phoneNumber(),
                  const SizedBox(height: 20),
                  formDesc(),
                  const SizedBox(height: 15),
                  codeInput(),
                  const SizedBox(height: 15),
                  if (_autoLoginFailed) forgotPassword(),
                  //if (_autoLoginFailed) signIn(context),
                  if (_loginProgress) loginProgress(),
                  if (_loginSuccess) loginSuccess(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding codeInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 75,
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) => onChanged(value, index),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                counterText: '',
              ),
              autofocus: index == 0,
              maxLength: 1,
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  Padding forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextBaseButton(
        title: 'Code secret oublié',
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PasswordRequest()),
          );
        },
      ),
    );
  }

  Padding formTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Connectez-vous',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding phoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        widget.phonenumber,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding formDesc() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Veuillez entrer votre code secret',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding signupImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90),
      child: Image.asset("assets/images/avatar.png"),
    );
  }

  Padding signIn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return TextBaseButton(
            title: 'Réessayer la connexion',
            onPressed: () async {
              String code = controllers.map((c) => c.text).join();
              if (code.isNotEmpty) {
                context.read<ButtonStateCubit>().excute(
                    usecase: sl<LoginUseCase>(),
                    params: LoginReqParams(
                      password: code,
                      phonenumber: widget.phonenumber,
                    ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous devez saisir votre code secret."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Padding loginProgress() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Connection en cours...',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding loginSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Connection ruéssie',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          Icon(
            Ionicons.checkmark,
            color: Color(0xFF008000),
          ),
        ],
      ),
    );
  }
}
