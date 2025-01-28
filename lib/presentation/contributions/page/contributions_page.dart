import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/widgets/contribution_item.dart';
import 'package:likya_app/presentation/contributions/bloc/contributions_display_cubit.dart';
import 'package:likya_app/presentation/contributions/bloc/contributions_display_state.dart';

class ContributionsPage extends StatefulWidget {
  final String collectId;

  const ContributionsPage({required this.collectId, super.key});

  @override
  State<ContributionsPage> createState() => _ContributionsPageState();
}

class _ContributionsPageState extends State<ContributionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des contributions',
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
                listContributions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding listContributions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) =>
            ContributionsDisplayCubit()..displayContributions(widget.collectId),
        child:
            BlocBuilder<ContributionsDisplayCubit, ContributionsDisplayState>(
                builder: (context, state) {
          if (state is ContributionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ContributionsLoaded) {
            if (state.items.isEmpty) {
              // Display a message when the list is empty
              return const Center(
                child: Text(
                  'Pas de contribution disponible.',
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
                  var contribution = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: contributionItem(
                        contribution.contributionId,
                        context,
                        Ionicons.chevron_forward_outline,
                        contribution.contributorName,
                        contribution.amount),
                  );
                },
              ),
            );
          }
          if (state is LoadContributionsFailure) {
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
