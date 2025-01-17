import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/transaction_req.dart';
import 'package:likya_app/domain/usecases/add_transaction.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';

class TransactionPage extends StatefulWidget {
  final String method;
  const TransactionPage({required this.method, super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool transactionSuccess = false;
  bool transactionLoading = false;
  bool transactionFaile = false;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final amount = TextEditingController();
  final comment = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    amount.dispose();
    comment.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Effectuer un ${transactionTitle(widget.method)}',
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
            if (state is ButtonSuccessState) {
              //success
            }
            if (state is ButtonFailureState) {
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
                      commentfild(),
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
            title: 'Valider',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // ignore: use_build_context_synchronously
                context.read<ButtonStateCubit>().excute(
                      usecase: sl<AddTransactionUseCase>(),
                      params: AddTransactionParams(
                        transactionReqParams: TransactionReqParams(
                          amount: int.parse(amount.text),
                          comment: comment.text,
                        ),
                        methodParam: widget.method,
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

  Padding commentfild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Votre commentaire',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: comment,
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
}
