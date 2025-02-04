import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/deposit_req.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/usecases/add_deposit.dart';
import 'package:likya_app/presentation/deposit/detail_deposit_page.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';

class AddDepositPage extends StatefulWidget {
  final String gateway;
  final double percent;

  const AddDepositPage({
    required this.gateway,
    required this.percent,
    super.key,
  });

  @override
  State<AddDepositPage> createState() => _AddDepositPageState();
}

class _AddDepositPageState extends State<AddDepositPage> {
  bool _transactionSuccess = false;
  bool _transactionLoading = false;
  double charge = 0.0;
  double totalAmount = 0.0;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();

  final amount = TextEditingController();

  void calculateCharge() {
    setState(() {
      int getAmount = int.tryParse(amount.text) ?? 0;
      charge = getFrais(widget.percent, getAmount);
      totalAmount = getTotal(widget.percent, getAmount);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    amount.dispose();
    _focusNode1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonLoadingState) {
              setState(() {
                _transactionSuccess = false;
                _transactionLoading = true;
              });
            }

            if (state is ButtonSuccessState) {
              setState(() {
                _transactionSuccess = true;
                _transactionLoading = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DetailDepositPage(),
                ),
              );
            }
            if (state is ButtonFailureState) {
              setState(() {
                _transactionSuccess = false;
                _transactionLoading = false;
              });
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      amountfild(),
                      const SizedBox(height: 20),
                      chargeDeposit(),
                      const SizedBox(height: 10),
                      totalDeposit(),
                      const SizedBox(height: 10),
                      line(),
                      const SizedBox(height: 10),
                      paymentMethod(),
                      const SizedBox(height: 10),
                      if (_transactionLoading) transactionLoading(),
                      if (_transactionSuccess) transactionSuccess(),
                      const SizedBox(height: 20),
                      submit(context),
                    ],
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

  Padding submit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Suivant',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String? walletId = await ApiService().getWalletId();
                // ignore: use_build_context_synchronously
                context.read<ButtonStateCubit>().excute(
                      usecase: sl<AddDepositUseCase>(),
                      params: AddDepositParams(
                        depositReqParams: DepositReqParams(
                          walletId: walletId,
                          amount: totalAmount,
                          reason: "Dépôt Likya",
                          description: "Dépôt effectué par un patient",
                        ),
                        depositParam: widget.gateway,
                      ),
                    );
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Tous les champs sont recquis."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Padding amountfild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Montant',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: amount,
          focusNode: _focusNode1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
          onChanged: (value) {
            calculateCharge();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vous devez saisir un montant';
            }
            return null;
          },
        ),
      ]),
    );
  }

  Padding chargeDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Frais',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "${charge.toString()} FCFA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding totalDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Totalà payer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "${totalAmount.toString()} FCFA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
    );
  }

  Padding paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Moyen de payement',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gatewayName(widget.gateway),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.percent}% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xE5D1D5DB),
                    width: 1,
                  ),
                ),
                child: Image.asset("assets/images/${widget.gateway}.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding transactionSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Continuer pour terminer la recharge de vontre compte',
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

  Padding transactionLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Le charge de votre de votre compte en cours!",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF008000),
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
            Ionicons.ellipsis_horizontal_outline,
            color: Color(0xFF008000),
          ),
        ],
      ),
    );
  }
}
