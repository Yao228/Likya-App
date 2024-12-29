import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/password_reset.dart';
import 'package:likya_app/domain/usecases/password_reset.dart';
import 'package:likya_app/presentation/auth/pages/login/login_screen.dart';
import 'package:likya_app/service_locator.dart';

class PasswordReset extends StatefulWidget {
  final String phonenumber;
  final String codeOtp;

  const PasswordReset(
      {required this.phonenumber, required this.codeOtp, super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> codeControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> confirmControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> codeFocusNodes = List.generate(4, (_) => FocusNode());
  final List<FocusNode> confirmFocusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var controller in confirmControllers) {
      controller.dispose();
    }
    for (var focusNode in codeFocusNodes) {
      focusNode.dispose();
    }
    for (var focusNode in confirmFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void onFieldChanged(String value, int index, List<FocusNode> focusNodes) {
    if (value.isNotEmpty && index < focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 60,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    signupImage(),
                    const SizedBox(height: 20),
                    formTitle(),
                    const SizedBox(height: 10),
                    formDesc(),
                    const SizedBox(height: 15),
                    codeLabel(),
                    const SizedBox(height: 10),
                    codeInput(),
                    const SizedBox(height: 20),
                    confirmCodeLabel(),
                    const SizedBox(height: 10),
                    confirmCodeInput(),
                    const SizedBox(height: 100),
                    signUp(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding signUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Modifier votre code secret',
            onPressed: () async {
              String code = codeControllers.map((c) => c.text).join();
              String confirmCode = confirmControllers.map((c) => c.text).join();
              if (code == confirmCode && code.isNotEmpty) {
                // ignore: use_build_context_synchronously
                context.read<ButtonStateCubit>().excute(
                    usecase: sl<PasswordResetUseCase>(),
                    params: PasswordResetParams(
                      newPassword: code,
                      confirmPassword: confirmCode,
                      codeOtp: widget.codeOtp,
                      phonenumber: widget.phonenumber,
                    ));
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Les codes ne correspondent pas."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Padding codeInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 70,
            child: TextFormField(
              controller: codeControllers[index],
              focusNode: codeFocusNodes[index],
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) =>
                  onFieldChanged(value, index, codeFocusNodes),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                counterText: '',
              ),
              maxLength: 1,
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  Padding confirmCodeInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 70,
            child: TextFormField(
              controller: confirmControllers[index],
              focusNode: confirmFocusNodes[index],
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) =>
                  onFieldChanged(value, index, confirmFocusNodes),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                counterText: '',
              ),
              maxLength: 1,
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  Padding confirmCodeLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Confirmez code secret',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding codeLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Code secret',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding formTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Votre nouveau code',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding formDesc() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Choisissez votre nouveau code secret.',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding signupImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90),
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
