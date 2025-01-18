import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/entities/user.dart';
import 'package:likya_app/presentation/home/bloc/user_display_cubit.dart';
import 'package:likya_app/presentation/home/bloc/user_display_state.dart';
import 'package:likya_app/presentation/setting/profil_update.dart';
import 'package:likya_app/utils/utils.dart';

class ProfilDetail extends StatefulWidget {
  const ProfilDetail({super.key});

  @override
  State<ProfilDetail> createState() => _ProfilDetailState();
}

class _ProfilDetailState extends State<ProfilDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => UserDisplayCubit()..displayUser(),
        child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
            builder: (context, state) {
          if (state is UserLoading) {
            return const CircularProgressIndicator();
          }
          if (state is UserLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      avatar(state.userEntity),
                      userName(state.userEntity),
                      SizedBox(height: 15),
                      userPhone(state.userEntity),
                      SizedBox(height: 15),
                      userEmail(state.userEntity),
                      SizedBox(height: 15),
                      useStatus(state.userEntity),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is LoadUserFailure) {
            return Text(state.errorMessage);
          }
          return Text('error');
        }),
      ),
      bottomSheet: BlocProvider(
        create: (context) => UserDisplayCubit()..displayUser(),
        child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
            builder: (context, state) {
          if (state is UserLoading) {
            return const CircularProgressIndicator();
          }
          if (state is UserLoaded) {
            return Container(
              color: Colors.white,
              width: 350,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: updateButton(state.userEntity),
            );
          }
          if (state is LoadUserFailure) {
            return Text(state.errorMessage);
          }
          return Text('error');
        }),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding avatar(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 30),
      child: Center(
        child: userAvatar(user.fullname, user.attributes["avatar"], 50, 32),
      ),
    );
  }

  Padding userName(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x26D1D5DB),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nom',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                user.fullname ?? 'Unknown',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding userPhone(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x26D1D5DB),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Téléphone',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                user.phonenumber,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding userEmail(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x26D1D5DB),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                user.email ?? user.attributes['email'] ?? 'Unknown',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding useStatus(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x26D1D5DB),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Etat',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                user.isActive ? 'Actif' : 'Inactif',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding updateButton(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => ProfilUpdate(
                userName: user.fullname,
                userEmail: user.email ?? user.attributes['email'],
                userAvatar: user.attributes["avatar"],
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: const Color(0xFF2FA9A2),
        ),
        child: Text(
          'Modifier le profil',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
