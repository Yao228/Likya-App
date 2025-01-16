import 'package:flutter/material.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/presentation/auth/pages/auth_screen.dart';
import 'package:likya_app/presentation/auth/pages/login/password_screen.dart';
import 'package:likya_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

@override
class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: () async {
          if (phone.text.isNotEmpty) {
            setState(() {
              _loading = true;
            });
            final phonenumber = '$dialCode${phone.text.trim()}';
            Map<String, dynamic>? result = await ApiService()
                .findPhonenumber(formatPhoneNumber(phonenumber));
            // ignore: avoid_print
            print(result);
            if (result != null && result['phonenumber'] != null) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PasswordScreen(
                    fullname: result['fullname'] ?? "Nom inconnu",
                    phonenumber: phonenumber,
                    avatar: result['avatar']),
              ));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Une erreur est survenue, veullez vérifier votre numéro."),
                ),
              );
            }
          } else {
            setState(() {
              _loading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Vous devez saisir le numéro de téléphone."),
              ),
            );
          }
          setState(() {
            _loading = false;
          });
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: _loading ? Colors.grey : const Color(0xFF2FA9A2),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: _loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'Se connecter',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
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
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          validator: (number) {
            if (number.number.isEmpty) {
              setState(() {
                _loading = false;
              });
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
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        'Connectez-vous',
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
        'Entre votre numéro de telephone',
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
