import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/collects_contributors_req.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/usecases/add_collects_contributors.dart';
import 'package:likya_app/presentation/collects/page/detail_fund_raising_page.dart';
import 'package:likya_app/service_locator.dart';

class AddContributors extends StatefulWidget {
  final dynamic collectID;
  final dynamic title;

  const AddContributors(
      {required this.collectID, required this.title, super.key});

  @override
  State<AddContributors> createState() => _AddContributorsState();
}

class _AddContributorsState extends State<AddContributors> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>>? contributors;
  List<Map<String, dynamic>> filteredContributors = [];
  final TextEditingController searchController = TextEditingController();

  bool _addCollectsContributorsSuccess = false;
  bool _addCollectsContributorsLoading = false;

  @override
  void initState() {
    super.initState();
    fetchContributors();
    searchController.addListener(_filterContributors);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchContributors() async {
    final fetchedContributors = await ApiService().getContributors();
    setState(() {
      contributors = fetchedContributors?.map((contributor) {
        return {...contributor, "isSelected": false};
      }).toList();
      filteredContributors = List.from(contributors!);
    });
  }

  void _filterContributors() {
    final query = searchController.text.toLowerCase();
    if (query.length > 2) {
      setState(() {
        filteredContributors = contributors!
            .where((contributor) =>
                contributor["name"].toString().toLowerCase().contains(query))
            .toList();
      });
    } else {
      setState(() {
        filteredContributors = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter un contributeur",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonLoadingState) {
              setState(() {
                _addCollectsContributorsSuccess = false;
                _addCollectsContributorsLoading = true;
              });
            }
            if (state is ButtonSuccessState) {
              setState(() {
                _addCollectsContributorsSuccess = true;
                _addCollectsContributorsLoading = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DetailFundRaisingPage(
                    collectID: widget.collectID,
                    title: widget.title,
                  ),
                ),
              );
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
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      contributorsField(),
                      const SizedBox(height: 20),
                      if (_addCollectsContributorsLoading)
                        addCollectsContributorsLoading(),
                      if (_addCollectsContributorsSuccess)
                        addCollectsContributorsSuccess(),
                      const SizedBox(height: 50),
                      submit(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding submit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Ajouter les contributeurs',
            onPressed: () async {
              if (contributors == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Aucun contributeur n'a été trouvé."),
                  ),
                );
                return;
              }

              final selectedContributorIds = contributors!
                  .where((contributor) => contributor["isSelected"] == true)
                  .map((contributor) => contributor["_id"])
                  .toList();

              if (selectedContributorIds.isNotEmpty) {
                context.read<ButtonStateCubit>().excute(
                      usecase: sl<AddCollectsContributorsUseCase>(),
                      params: CollectsContributorsReqParams(
                        contributors: selectedContributorIds,
                      ),
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Vous devez choisir au moins un contributeur"),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Padding contributorsField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recherche de contributeurs',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Barre de recherche
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Rechercher un contributeur',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                if (query.length > 3) {
                  filteredContributors = contributors!
                      .where((contributor) => contributor["name"]
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                } else {
                  filteredContributors = [];
                }
              });
            },
          ),
          const SizedBox(height: 10),
          // Affichage des noms sélectionnés
          if (contributors != null &&
              contributors!
                  .any((contributor) => contributor["isSelected"] == true))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contributeurs sélectionnés :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: contributors!
                      .where((contributor) => contributor["isSelected"] == true)
                      .map((contributor) => Chip(
                            label: Text(contributor["name"]),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                contributor["isSelected"] = false;
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          // Affichage conditionnel de la liste
          searchController.text.length <= 3
              ? const Text("Tapez plus de 3 caractères pour rechercher.")
              : filteredContributors.isEmpty
                  ? const Text("Aucun contributeur trouvé.")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredContributors.length,
                      itemBuilder: (context, index) {
                        final contributor = filteredContributors[index];
                        return CheckboxListTile(
                          title: Text(contributor["name"]),
                          value: contributor["isSelected"] ?? false,
                          onChanged: (isSelected) {
                            setState(
                              () {
                                contributor["isSelected"] = isSelected;
                                final originalIndex = contributors!.indexWhere(
                                    (c) => c["_id"] == contributor["_id"]);
                                if (originalIndex != -1) {
                                  contributors![originalIndex]["isSelected"] =
                                      isSelected;
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
        ],
      ),
    );
  }

  Padding addCollectsContributorsSuccess() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Contributeurs ajoutés avec succès',
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

  Padding addCollectsContributorsLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Contributeurs en cours d'ajout",
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
