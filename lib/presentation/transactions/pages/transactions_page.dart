import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/widgets/transaction_item.dart';
import 'package:likya_app/presentation/transactions/bloc/transactions_display_cubit.dart';
import 'package:likya_app/presentation/transactions/bloc/transactions_display_state.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des transactions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                listTransactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding listTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) => TransactionsDisplayCubit()..displayTransactions(),
        child: BlocBuilder<TransactionsDisplayCubit, TransactionsDisplayState>(
            builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(child: LinearProgressIndicator());
          }
          if (state is TransactionsLoaded) {
            return state.items.isEmpty
                ? Center(
                    child: Text(
                      'Pas de transaction disponible.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : SizedBox(
                    height: 180,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        var transaction = state.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: transactionItem(
                            transaction.id,
                            context,
                            Ionicons.send,
                            transaction.description,
                            transaction.timestamp,
                            transaction.amount,
                          ),
                        );
                      },
                    ),
                  );
          }
          if (state is LoadTransactionsFailure) {
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
