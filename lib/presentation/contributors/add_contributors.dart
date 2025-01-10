import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/collects_contributors_req.dart';
import 'package:likya_app/domain/usecases/add_collects_contributors.dart';
import 'package:likya_app/presentation/collects/page/detail_fund_raising_page.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _askPermissions();
    fetchContributors();
    searchController.addListener(_filterContributors);
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      fetchContributors(); // Fetch contributors only after permissions are granted
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isFetchingContributors = false;

  Future<void> fetchContributors() async {
    if (_isFetchingContributors) return; // Prevent re-entrance
    setState(() {
      _isFetchingContributors = true;
    });

    try {
      List<Contact> fetchedContributors = await FastContacts.getAllContacts();
      setState(() {
        contributors =
            fetchedContributors.map<Map<String, dynamic>>((contributor) {
          return {"contact": contributor, "isSelected": false};
        }).toList();
        filteredContributors = List<Map<String, dynamic>>.from(contributors!);
      });
    } catch (e) {
      // Handle the error gracefully
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch contacts: $e')),
      );
    } finally {
      setState(() {
        _isFetchingContributors = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterContributors() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredContributors = List<Map<String, dynamic>>.from(contributors!);
      });
      return;
    }

    setState(() {
      filteredContributors = contributors!.where((contributor) {
        final contact = contributor["contact"];
        final displayName =
            contact?.structuredName?.displayName?.toLowerCase() ?? '';
        final phoneNumber = contact?.phones?.isNotEmpty == true
            ? contact.phones[0].number.toLowerCase()
            : '';

        return displayName.contains(query) || phoneNumber.contains(query);
      }).toList();
    });
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
            if (state is ButtonSuccessState) {
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
            child: _isFetchingContributors
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
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

              final selectedContributorPhones = contributors!
                  .where((contributor) => contributor["isSelected"] == true)
                  .expand((contributor) => contributor["contact"]
                      .phones
                      .map((phone) => phone.number))
                  .toList();

              if (selectedContributorPhones.isNotEmpty) {
                context.read<ButtonStateCubit>().excute(
                      usecase: sl<AddCollectsContributorsUseCase>(),
                      params: CollectsContributorsReqParams(
                        contributors: selectedContributorPhones,
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recherche de contacts',
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
              hintText: 'Rechercher un contact',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              setState(() {
                if (query.length > 3) {
                  filteredContributors = contributors!
                      .where((contributor) =>
                          contributor["contact"]
                              .structuredName
                              .displayName
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          contributor["contact"].phones.any((phone) => phone
                              .number
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())))
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
                      .map((contributor) {
                    final contact = contributor["contact"];
                    final displayName =
                        contact?.structuredName?.displayName ?? "Nom inconnu";
                    return Chip(
                      label: Text(
                          displayName), // Display the selected contact's displayName
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          contributor["isSelected"] = false;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          // Affichage conditionnel de la liste
          filteredContributors.isEmpty
              ? const Text("Aucun contact trouvé.")
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredContributors.length,
                  itemBuilder: (context, index) {
                    final contributor = filteredContributors[index];
                    final contact = contributor["contact"];

                    // Extract displayName and phone number safely
                    final displayName =
                        contact?.structuredName?.displayName ?? "Nom inconnu";
                    final phoneNumber = contact?.phones?.isNotEmpty == true
                        ? contact.phones[0].number
                        : "Numéro inconnu";

                    return CheckboxListTile(
                      title: Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        phoneNumber,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      value: contributor["isSelected"] ?? false,
                      onChanged: (isSelected) {
                        setState(
                          () {
                            contributor["isSelected"] = isSelected;
                            final originalIndex = contributors!.indexWhere(
                                (c) => c["contact"].id == contact.id);
                            if (originalIndex != -1) {
                              contributors![originalIndex]["isSelected"] =
                                  isSelected;
                            }
                          },
                        );
                      },
                      secondary: CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFF99CCCC),
                        child: Text(
                          getInitials(displayName),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Righteous',
                          ),
                        ),
                      ),
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
