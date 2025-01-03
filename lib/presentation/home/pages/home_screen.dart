import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/logout/logout_display_cubit.dart';
import 'package:likya_app/common/bloc/logout/logout_display_state.dart';
import 'package:likya_app/common/widgets/button/logout_base_button.dart';
import 'package:likya_app/common/widgets/transaction_item.dart';
import 'package:likya_app/common/widgets/carousel_item.dart';
import 'package:likya_app/domain/entities/user.dart';
import 'package:likya_app/domain/usecases/logout.dart';
import 'package:likya_app/presentation/auth/pages/auth_screen.dart';
import 'package:likya_app/presentation/collects/page/create_fund_raising_page.dart';
import 'package:likya_app/presentation/collects/page/list_fund_raising_page.dart';
import 'package:likya_app/presentation/home/bloc/user_display_cubit.dart';
import 'package:likya_app/presentation/home/bloc/user_display_state.dart';
import 'package:likya_app/presentation/setting/call_support.dart';
import 'package:likya_app/presentation/setting/invite_friend.dart';
import 'package:likya_app/presentation/setting/password_update.dart';
import 'package:likya_app/presentation/setting/profil_detail.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';
import 'package:likya_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPriceHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0.7,
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Paramètres",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
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
                        MaterialPageRoute(builder: (context) => ProfilDetail()),
                      );
                    },
                    icon: const Icon(
                      Ionicons.person_outline,
                      size: 28,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Profil',
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
                        MaterialPageRoute(
                            builder: (context) => PasswordUpdate()),
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
                SizedBox(
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) => LogoutStateCubit(),
                    child: BlocListener<LogoutStateCubit, LogoutState>(
                      listener: (context, state) {
                        if (state is LogoutSuccessState) {
                          LocalStorageService.deleteKey(
                              LocalStorageService.token);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AuthPage(),
                            ),
                          );
                        }
                        if (state is LogoutFailureState) {
                          var snackBar =
                              SnackBar(content: Text(state.errorMessage));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Builder(
                        builder: (context) {
                          return LogoutBaseButton(
                            iconName: Ionicons.log_out_outline,
                            title: 'Se déconnecter',
                            onPressed: () async {
                              context.read<LogoutStateCubit>().excute(
                                    usecase: sl<LogoutUseCase>(),
                                  );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: topHome(),
        automaticallyImplyLeading: false, // Hides the drawer icon
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            child: Column(
              children: [
                homeBanner(),
                const SizedBox(height: 20),
                homeButtons(),
                const SizedBox(height: 5),
                homeSlide(),
                const SizedBox(height: 10),
                homeList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding topHome() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => UserDisplayCubit()..displayUser(),
        child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
            builder: (context, state) {
          if (state is UserLoading) {
            return const CircularProgressIndicator();
          }
          if (state is UserLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _fullname(state.userEntity),
                    _status(state.userEntity),
                  ],
                ),
                _avatar(
                  state.userEntity,
                  () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              ],
            );
          }
          if (state is LoadUserFailure) {
            return Text(state.errorMessage);
          }
          return Text('error');
        }),
      ),
    );
  }

  Widget _fullname(UserEntity user) {
    return Text(
      user.fullname ?? 'Unknown',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Righteous',
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _status(UserEntity user) {
    return Text(
      user.isActive ? 'Actif' : 'Inactif',
      style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFFADB3BC)),
    );
  }

  Widget _avatar(UserEntity user, VoidCallback onAvatarTap) {
    return GestureDetector(
      onTap: onAvatarTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF03544F),
            child: Text(
              getInitials(user.fullname ?? 'Unknown'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'Righteous',
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Ionicons.list_outline,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding homeBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 319,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/homebanner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Solde',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isPriceHidden ? '******' : '1 850 225',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        _isPriceHidden ? '' : 'f',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isPriceHidden = !_isPriceHidden;
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                        ),
                        child: Icon(
                          _isPriceHidden ? Ionicons.eye : Ionicons.eye_off,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Positioned(
            bottom: -25,
            child: InkWell(
              onTap: showModal,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Ionicons.qr_code_outline,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding homeButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.sync_outline,
                    size: 32,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Transfert",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.share_outline,
                    size: 32,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10), // Space between image and text
                const Text(
                  "Paiement",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.paper_plane_outline,
                    size: 32,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10), // Space between image and text
                const Text(
                  "Likya me",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.options_outline,
                    size: 32,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10), // Space between image and text
                const Text(
                  "Services",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding homeSlide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mes likya",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListFundRaisingPage()),
                  );
                },
                child: Text(
                  "Afficher tous",
                  style: TextStyle(
                    color: Color(0xFF03544F),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 75,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                carouselItem('10/50 Assistent', '2000'),
                carouselItem('10/50 Assistent', '500'),
                carouselItem('10/50 Assistent', '5500'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding homeList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dernières transactions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Afficher tous",
                  style: TextStyle(
                    color: Color(0xFF03544F),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  transactionItem(
                    Ionicons.cart,
                    "Achat en Pharmacie",
                    "Lundi 6 Décembre à 20:13",
                    "12 250 F",
                  ),
                  const Divider(color: Color(0xFFADB3BC), thickness: 1),
                  transactionItem(
                    Ionicons.send,
                    "Envois à Mairus",
                    "Lundi 6 Décembre à 13:53",
                    "-7 000 F",
                  ),
                  const Divider(color: Color(0xFFADB3BC), thickness: 1),
                  transactionItem(
                    Ionicons.download_sharp,
                    "Dépot",
                    "Mardi 7 Décembre à 12:20",
                    "3 000 F",
                  ),
                  const Divider(color: Color(0xFFADB3BC), thickness: 1),
                  transactionItem(
                    Ionicons.download_sharp,
                    "Dépot",
                    "Mardi 7 Décembre à 12:20",
                    "3 000 F",
                  ),
                  const Divider(color: Color(0xFFADB3BC), thickness: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext sheetContext) {
        return SizedBox(
          width: 375,
          height: 400, // Set your desired height
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: ListView(
              children: [
                Text(
                  'Que voulez-vous faire ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xE5D1D5DB),
                      width: 1,
                    ),
                  ),
                  height: 87,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateFundRaisingPage()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.funnel_outline,
                          size: 40,
                          color: Color(0xFF2FA9A2),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Créer une cagnotte',
                                style: TextStyle(
                                  color: Color(0xFF2FA9A2),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Créer une cagnotte et commencer une collecte.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xE5D1D5DB),
                      width: 1,
                    ),
                  ),
                  height: 87,
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.add_circle_outline,
                        size: 40,
                        color: Color(0xFF2FA9A2),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ajouter',
                              style: TextStyle(
                                color: Color(0xFF2FA9A2),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Déposer de l\'argent sur votre compte Likya pour toutes vos prochaines transactions.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xE5D1D5DB),
                      width: 1,
                    ),
                  ),
                  height: 87,
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.arrow_redo_outline,
                        size: 40,
                        color: Color(0xFF2FA9A2),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Envoyer',
                              style: TextStyle(
                                color: Color(0xFF2FA9A2),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Transférer de l\'argent à vos proches pour toutes leurs dépenses liées à la santé.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
