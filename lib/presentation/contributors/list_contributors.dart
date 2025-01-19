import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/widgets/contributor_item.dart';
import 'package:likya_app/presentation/contributors/bloc/contributions_display_state.dart';
import 'package:likya_app/presentation/contributors/bloc/contributors_display_cubit.dart';

class ListContributors extends StatefulWidget {
  final String collectId;

  const ListContributors({required this.collectId, super.key});

  @override
  State<ListContributors> createState() => _ListContributorsState();
}

class _ListContributorsState extends State<ListContributors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liste des contributeurs",
          style: const TextStyle(
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
                listContributors(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding listContributors() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) =>
            ContributorsDisplayCubit()..displayContributors(widget.collectId),
        child: BlocBuilder<ContributorsDisplayCubit, ContributorsDisplayState>(
            builder: (context, state) {
          if (state is ContributorsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ContributorsLoaded) {
            if (state.items.isEmpty) {
              // Display a message when the list is empty
              return const Center(
                child: Text(
                  'Pas de contributeur disponible.',
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
                  var contributor = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: contributorItem(
                      contributor.items,
                    ),
                  );
                },
              ),
            );
          }
          if (state is LoadContributorsFailure) {
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
