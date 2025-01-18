import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/widgets/button/text_base_button.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  bool _codeValidationFailed = false;
  bool _validationProgress = false;
  bool _validationSuccess = false;

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
      /*if (code.length == 4) {
        _autoLogin(code);
      }*/
    });
  }

  /*void _autoLogin(String code) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Votre code secret',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                formTitle(),
                const SizedBox(height: 60),
                codeInput(),
                const SizedBox(height: 60),
                cancel(),
                const SizedBox(height: 15),
                if (_validationProgress) validationProgress(),
                if (_validationSuccess) validationSuccess(),
              ],
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

  Padding formTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Veuillez entrer votre code secret',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
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
                /*context.read<ButtonStateCubit>().excute(
                    usecase: sl<LoginUseCase>(),
                    params: LoginReqParams(
                      password: code,
                      phonenumber: widget.phonenumber,
                    ));*/
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

  Padding cancel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Annuler',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding validationProgress() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Validation en cours...',
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding validationSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Code validé',
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
