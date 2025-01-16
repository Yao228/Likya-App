import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/text_base_button.dart';
import 'package:likya_app/common/widgets/wallet_item.dart';
import 'package:likya_app/data/models/add_wallet_req.dart';
import 'package:likya_app/domain/usecases/add_wallet.dart';
import 'package:likya_app/presentation/wallets/bloc/wallets_display_cubit.dart';
import 'package:likya_app/presentation/wallets/bloc/wallets_display_state.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vos wallets',
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
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            child: Column(
              children: [
                addWallet(),
                listWallet(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding addWallet() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ajouter un wallet",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return BlocListener<ButtonStateCubit, ButtonState>(
                    listener: (context, state) {
                      if (state is ButtonSuccessState) {
                        // Close dialog on success
                        Navigator.of(dialogContext).pop();
                      }
                      if (state is ButtonFailureState) {
                        // Show error message on failure
                        var snackBar =
                            SnackBar(content: Text(state.errorMessage));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: AlertDialog(
                      title: const Text(
                        "Ajouter un Wallet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        "Confirmer pour ajouter votre Wallet.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Close the dialog when "Fermer" is pressed
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text(
                            "Fermer",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextBaseButton(
                          onPressed: () async {
                            // Move context usage before async call
                            var userId = await LocalStorageService.getString(
                                LocalStorageService.userId);
                            // ignore: use_build_context_synchronously
                            context.read<ButtonStateCubit>().excute(
                                  usecase: sl<AddWalletUseCase>(),
                                  params: AddWalletReqParams(
                                    userId: userId.toString(),
                                  ),
                                );
                          },
                          title: "Confirmer",
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Icon(
              Ionicons.add_circle_outline,
              color: Color(0xFF03544F),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Padding listWallet() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) => WalletsDisplayCubit()..displayWallets(),
        child: BlocBuilder<WalletsDisplayCubit, WalletsDisplayState>(
            builder: (context, state) {
          if (state is WalletsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WalletsLoaded) {
            if (state.items.isEmpty) {
              // Display a message when the list is empty
              return const Center(
                child: Text(
                  'Pas de wallet disponible.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  var wallet = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: walletItem(
                      context,
                      wallet.balance,
                      wallet.walletNumber,
                      wallet.currency,
                      wallet.status,
                      false,
                    ),
                  );
                },
              ),
            );
          }
          if (state is LoadWalletsFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }
          return const Center(
            child: Text('Une erreur inattendue s\'est produite.'),
          );
        }),
      ),
    );
  }
}
