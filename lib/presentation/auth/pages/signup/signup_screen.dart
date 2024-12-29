import 'package:flutter/material.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:likya_app/presentation/auth/pages/signup/code_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

@override
class _SignupScreenState extends State<SignupScreen> {
  var dialCode = "";
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final firstname = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    firstname.dispose();
    phone.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final phonenumber = '$dialCode${phone.text.trim()}';
      final fullname = '${name.text.trim()} ${firstname.text.trim()}';
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            CodeScreen(phonenumber: phonenumber, fullname: fullname),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 40,
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
                const SizedBox(height: 10),
                namefild(),
                const SizedBox(height: 15),
                firstNamefild(),
                const SizedBox(height: 15),
                phoneField(),
                const SizedBox(height: 100),
                signUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding signUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: const Color(0xFF2FA9A2),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: const Text(
          'Continuer',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  Padding namefild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Nom',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: name,
          focusNode: _focusNode1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Requis';
            }
            return null;
          },
        ),
      ]),
    );
  }

  Padding firstNamefild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Prénoms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: firstname,
          focusNode: _focusNode2,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Requis';
            }
            return null;
          },
        ),
      ]),
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
            focusNode: _focusNode3,
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
      padding: EdgeInsets.symmetric(horizontal: 90),
      child: Text(
        'Inscription',
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
        'Pour commencer, Veuillez renseigner votre nom, prénoms et n° de téléphone',
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
