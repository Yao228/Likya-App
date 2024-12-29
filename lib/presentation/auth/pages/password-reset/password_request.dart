import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/password_req_params.dart';
import 'package:likya_app/domain/usecases/password_request.dart';
import 'package:likya_app/presentation/auth/pages/password-reset/verify_phone_screen.dart';
import 'package:likya_app/service_locator.dart';

class PasswordRequest extends StatefulWidget {
  const PasswordRequest({super.key});

  @override
  State<PasswordRequest> createState() => _PasswordRequestState();
}

class _PasswordRequestState extends State<PasswordRequest> {
  var dialCode = "";
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final phone = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    phone.dispose();
    _focusNode1.dispose();
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
                final phonenumber = '$dialCode${phone.text.trim()}';
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        VerifyPhoneScreen(phonenumber: phonenumber),
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
                  vertical: 50,
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
                      phoneField(),
                      const SizedBox(height: 100),
                      resetButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Padding resetButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Envoyer la demande',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final phonenumber = '$dialCode${phone.text.trim()}';
                // ignore: use_build_context_synchronously
                context.read<ButtonStateCubit>().excute(
                    usecase: sl<PasswordRequestUseCase>(),
                    params: PasswordReqParams(phonenumber: phonenumber));
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

  Padding phoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Numéro de téléphone',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        InternationalPhoneNumberInput(
          height: 50,
          controller: phone,
          initCountry: CountryCodeModel(
              name: "Ivory Coast", dial_code: "+225", code: "CI"),
          betweenPadding: 10,
          onInputChanged: (phone) {
            dialCode = phone.dial_code;
          },
          //loadFromJson: loadFromJson,
          dialogConfig: DialogConfig(
            backgroundColor: const Color(0xFF1B1C24),
            searchBoxBackgroundColor: const Color(0xFF1B1C24),
            searchBoxIconColor: const Color(0xFFFAFAFA),
            countryItemHeight: 55,
            topBarColor: const Color(0xFF1B1C24),
            selectedItemColor: const Color(0xFF1B1C24),
            selectedIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                "assets/check.png",
                width: 20,
                fit: BoxFit.fitWidth,
              ),
            ),
            textStyle: TextStyle(
                color: const Color(0xFFFAFAFA).withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500),
            searchBoxTextStyle: TextStyle(
                color: const Color(0xFFFAFAFA).withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500),
            titleStyle: const TextStyle(
                color: Color(0xFFFAFAFA),
                fontSize: 18,
                fontWeight: FontWeight.w500),
            searchBoxHintStyle: TextStyle(
                color: const Color(0xFFFAFAFA).withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          countryConfig: CountryConfig(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xFF3f4046)),
                borderRadius: BorderRadius.circular(5),
              ),
              noFlag: true,
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          validator: (number) {
            if (number.number.isEmpty) {
              return "requis";
            }
            return null;
          },
          phoneConfig: PhoneConfig(
            focusedColor: const Color(0xFF1B1C24),
            enabledColor: const Color(0xFF1B1C24),
            errorColor: const Color(0xFFFF5733),
            labelStyle: null,
            labelText: null,
            floatingLabelStyle: null,
            focusNode: _focusNode1,
            radius: 5,
            hintText: null,
            borderWidth: 1,
            backgroundColor: Colors.transparent,
            decoration: null,
            popUpErrorText: true,
            autoFocus: false,
            showCursor: false,
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            errorTextMaxLength: 2,
            errorPadding: const EdgeInsets.only(top: 14),
            errorStyle: const TextStyle(
                color: Color(0xFFFF5733), fontSize: 12, height: 1),
            textStyle: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
            hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ]),
    );
  }

  Padding formTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Code sécret oublié ?',
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        'Demander une réinitialisation de nouveau code sécret.',
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
