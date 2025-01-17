import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/domain/entities/user.dart';
import 'package:likya_app/presentation/home/bloc/user_display_cubit.dart';
import 'package:likya_app/presentation/home/bloc/user_display_state.dart';
import 'package:likya_app/presentation/setting/call_support.dart';
import 'package:likya_app/presentation/setting/invite_friend.dart';
import 'package:likya_app/presentation/setting/password_update.dart';
import 'package:likya_app/presentation/setting/profil_update.dart';
import 'package:likya_app/utils/utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
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
                      listItem(),
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
      backgroundColor: Colors.white,
    );
  }

  Padding avatar(UserEntity user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Center(
        child: Column(
          children: [
            userAvatar(user.fullname, user.attributes["avatar"], 50, 32),
            SizedBox(height: 15),
            Text(
              user.fullname ?? 'Unknown',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              user.phonenumber,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilUpdate(
                      userId: user.id,
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
          ],
        ),
      ),
    );
  }

  Padding listItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0x26D1D5DB),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InviteFriend()),
                );
              },
              icon: const Icon(
                Ionicons.person_add_outline,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Inviter un ami',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0x26D1D5DB),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CallSupport()),
                );
              },
              icon: const Icon(
                Ionicons.headset_outline,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Appeler le service client',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0x26D1D5DB),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Ionicons.add_outline,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Pharmacies à proximités',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0x26D1D5DB),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Ionicons.business_outline,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Hôpitaux à proximité',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0x26D1D5DB),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordUpdate()),
                );
              },
              icon: const Icon(
                Ionicons.lock_closed_outline,
                size: 28,
                color: Colors.black,
              ),
              label: const Text(
                'Code secret',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
