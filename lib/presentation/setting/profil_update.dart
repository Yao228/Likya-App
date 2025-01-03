import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/data/models/update_user_req.dart';
import 'package:likya_app/domain/usecases/update_user.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ProfilUpdate extends StatefulWidget {
  final dynamic userId;
  final dynamic userName;
  final dynamic userEmail;

  const ProfilUpdate(
      {required this.userId,
      required this.userName,
      required this.userEmail,
      super.key});

  @override
  State<ProfilUpdate> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends State<ProfilUpdate> {
  bool _userUpdateSuccess = false;

  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        _image = savedImage;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final name = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.userName ?? '';
    email.text = widget.userEmail ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    /*phone.dispose();*/
    _focusNode1.dispose();
    /*_focusNode2.dispose();*/
    _focusNode3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Modifier votre profil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  avatar(),
                  uploadFile(),
                  SizedBox(height: 15),
                  userName(),
                  SizedBox(height: 15),
                  userEmail(),
                  if (_userUpdateSuccess) updateUserSuccess(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              setState(() {
                _userUpdateSuccess = true;
              });
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ButtonStateCubit>().excute(
                        usecase: sl<UpdateUserUseCase>(),
                        params: UpdateUserReqParams(
                            fullname: name.text,
                            attributes: {
                              "email": email.text,
                              "avatar": _image
                            }),
                      );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: const Color(0xFF2FA9A2),
                ),
                child: Text(
                  'Mettre à jour',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding avatar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
      child: Center(
        // Added Center widget to center the avatar
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF03544F),
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? Text(
                      getInitials(widget.userName),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Righteous',
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Padding userName() {
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

  Padding userEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: email,
          focusNode: _focusNode3,
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
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Email invalide';
            }
            return null;
          },
        ),
      ]),
    );
  }

  Padding uploadFile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: _pickImage,
        child: Text(
          'Changer la photo de profil',
          style: TextStyle(
            color: Color(0xFFFD9E02),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Padding updateUserSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mise à jour du profil réussi',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF008000),
            ),
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
