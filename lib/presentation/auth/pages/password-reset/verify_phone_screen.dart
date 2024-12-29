import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/verifyotp_req_params.dart';
import 'package:likya_app/domain/usecases/verify_otp.dart';
import 'package:likya_app/presentation/auth/pages/password-reset/password_reset.dart';
import 'package:likya_app/service_locator.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({required this.phonenumber, super.key});
  final String phonenumber;

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

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
              String code = controllers.map((c) => c.text).join();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PasswordReset(
                    phonenumber: widget.phonenumber,
                    codeOtp: code,
                  ),
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
                    codeInput(),
                    const SizedBox(height: 50),
                    submitButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Confirmer',
            onPressed: () {
              String code = controllers.map((c) => c.text).join();
              if (code.isNotEmpty) {
                context.read<ButtonStateCubit>().excute(
                      usecase: sl<VerifyOtpUseCase>(),
                      params: VerifyotpReqParams(
                        phonenumber: widget.phonenumber,
                        otpCode: code,
                      ),
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous devez saisir votre code OTP"),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  /*Padding resendCode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => TextStateCubit(),
        child: BlocListener<TextStateCubit, TextState>(
          listener: (context, state) {
            if (state is TextSuccessState) {
              _verifyFailed = false;
              _sendSuccess = true;
            }
            if (state is TextLoadingState) {
              _verifyFailed = false;
              _sendProgress = true;
            }
            if (state is TextFailureState) {
              _sendFailed = true;
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Builder(
            builder: (context) {
              return TextBaseButton(
                title: 'Renvoyer le code',
                onPressed: () {
                  context.read<TextStateCubit>().excute(
                        usecase: sl<ResendOtpUsecase>(),
                        params: ResendotpReqParams(
                          phonenumber: widget.phonenumber,
                        ),
                      );
                },
              );
            },
          ),
        ),
      ),
    );
  }*/

  Padding codeInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                counterText: '',
              ),
              autofocus: true,
              maxLength: 1,
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
    );
  }

  Padding formTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Confirmez votre numéro',
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
        'Entrez le code de confirmation qui vous a été envoyé par SMS',
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
