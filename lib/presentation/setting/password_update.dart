import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/update_password_req.dart';
import 'package:likya_app/domain/usecases/update_password.dart';
import 'package:likya_app/service_locator.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({super.key});

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  bool updatePasswordLoading = false;
  bool updatePasswordSuccess = false;
  bool updatePasswordFaild = false;

  final _formKey = GlobalKey<FormState>();
  /*final List<TextEditingController> oldCodeControllers =
      List.generate(4, (_) => TextEditingController());*/
  final List<TextEditingController> codeControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> confirmControllers =
      List.generate(4, (_) => TextEditingController());
  /*final List<FocusNode> oldCodeFocusNodes =
      List.generate(4, (_) => FocusNode());*/
  final List<FocusNode> codeFocusNodes = List.generate(4, (_) => FocusNode());
  final List<FocusNode> confirmFocusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    /*for (var controller in oldCodeControllers) {
      controller.dispose();
    }*/
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var controller in confirmControllers) {
      controller.dispose();
    }
    /*for (var focusNode in oldCodeFocusNodes) {
      focusNode.dispose();
    }*/
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
      appBar: AppBar(
        title: const Text(
          'Modifier votre code',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonLoadingState) {
                updatePasswordSuccess = false;
                updatePasswordFaild = false;
                updatePasswordLoading = true;
              }
              if (state is ButtonSuccessState) {
                setState(() {
                  updatePasswordLoading = false;
                  updatePasswordFaild = false;
                  updatePasswordSuccess = true;
                });
              }
              if (state is ButtonFailureState) {
                setState(() {
                  updatePasswordLoading = false;
                  updatePasswordSuccess = false;
                  updatePasswordFaild = true;
                });
                var snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        formTitle(),
                        const SizedBox(height: 10),
                        formDesc(),
                        /*const SizedBox(height: 10),
                    oldCodeLabel(),
                    const SizedBox(height: 10),
                    oldCodeInput(),*/
                        const SizedBox(height: 15),
                        codeLabel(),
                        const SizedBox(height: 10),
                        codeInput(),
                        const SizedBox(height: 20),
                        confirmCodeLabel(),
                        const SizedBox(height: 10),
                        confirmCodeInput(),
                        const SizedBox(height: 10),
                        if (updatePasswordLoading) _updatePasswordLoading(),
                        if (updatePasswordSuccess) _updatePasswordSuccess(),
                        if (updatePasswordFaild) _updatePasswordFaild(),
                        const SizedBox(height: 100),
                        sumbit()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding sumbit() {
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
                    usecase: sl<UpdatePasswordUseCase>(),
                    params: UpdatePasswordReqParams(
                      newPassword: code,
                      confirmPassword: confirmCode,
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

  /* Padding oldCodeInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: 70,
            child: TextFormField(
              controller: oldCodeControllers[index],
              focusNode: oldCodeFocusNodes[index],
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) =>
                  onFieldChanged(value, index, oldCodeFocusNodes),
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
  }*/

  /*Padding oldCodeLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Code secret actuel',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
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

  Padding codeLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Nouveau code secret',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
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

  Padding formTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Modifier votre code secret',
        style: TextStyle(
          fontSize: 22,
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
        'Changer en toute sécurité votre code secret.',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _updatePasswordLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Mise à jour du code secret en cours...',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.yellowAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _updatePasswordSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Code secret mis à jour avec succès',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.lightGreen,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _updatePasswordFaild() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Mise à jour du code secret échoué.',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.redAccent,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
