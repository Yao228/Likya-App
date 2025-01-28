import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/text_base_button.dart';
import 'package:likya_app/common/widgets/contribution_item.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/entities/collect.dart';
import 'package:likya_app/domain/usecases/collect_access.dart';
import 'package:likya_app/presentation/collects/bloc/collect_display_cubit.dart';
import 'package:likya_app/presentation/collects/bloc/collect_display_state.dart';
import 'package:likya_app/presentation/collects/page/update_fund_raising_page.dart';
import 'package:likya_app/presentation/contributions/bloc/contributions_display_cubit.dart';
import 'package:likya_app/presentation/contributions/bloc/contributions_display_state.dart';
import 'package:likya_app/presentation/contributions/page/add_contribution_page.dart';
import 'package:likya_app/presentation/contributions/page/contributions_page.dart';
import 'package:likya_app/presentation/contributors/add_contributors.dart';
import 'package:likya_app/presentation/contributors/list_contributors.dart';
import 'package:likya_app/presentation/setting/invite_friend.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailFundRaisingPage extends StatefulWidget {
  const DetailFundRaisingPage(
      {required this.collectID, required this.title, super.key});
  final String collectID;
  final String title;

  @override
  State<DetailFundRaisingPage> createState() => _DetailFundRaisingPageState();
}

class _DetailFundRaisingPageState extends State<DetailFundRaisingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              CollectDisplayCubit()..displayCollect(widget.collectID),
          child: BlocBuilder<CollectDisplayCubit, CollectDisplayState>(
            builder: (context, state) {
              if (state is CollectLoading) {
                return const CircularProgressIndicator();
              }
              if (state is CollectLoaded) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        collectBox(state.collectEntity),
                        collectButtons(state.collectEntity),
                        const SizedBox(height: 10),
                        collectDesc(state.collectEntity),
                        const SizedBox(height: 20),
                        collectContributorsTitle(state.collectEntity),
                        const SizedBox(height: 15),
                        collectContributors(),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              }
              if (state is LoadCollectFailure) {
                return Text(state.errorMessage);
              }
              return Text('Error');
            },
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddContributors(
                  collectID: widget.collectID,
                  title: widget.title,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Color(0xFF2FA9A2),
          ),
          child: Text(
            'Ajouter un contributeur',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding collectProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: LinearPercentIndicator(
        width: 310,
        animation: true,
        lineHeight: 10,
        animationDuration: 1000,
        percent: 0.8,
        center: Text(
          "80.00%",
          style: TextStyle(fontSize: 8),
        ),
        barRadius: Radius.circular(4),
        backgroundColor: Color(0xFFFFAAAF),
        progressColor: Color(0xFF3FCB67),
      ),
    );
  }

  Padding collectDesc(CollectEntity collect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          collect.description,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding collectContributorsTitle(CollectEntity collect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Les contributions",
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
                  builder: (context) =>
                      ContributionsPage(collectId: collect.id),
                ),
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
    );
  }

  Padding collectContributors() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) =>
            ContributionsDisplayCubit()..displayContributions(widget.collectID),
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

  Padding collectButtons(CollectEntity collect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: FutureBuilder<bool>(
        future: checkCollectOwner(collect.userDict['_id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            bool isOwner = snapshot.data ?? false;
            if (isOwner) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ListContributors(
                              collectId: collect.id,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Icon(
                              Ionicons.people_outline,
                              size: 28,
                              color: Color(0xFF2FA9A2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Contributeurs",
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
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => InviteFriend(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Icon(
                              Ionicons.arrow_redo_outline,
                              size: 28,
                              color: Color(0xFF2FA9A2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Inviter",
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
                      onPressed: () {
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
                                  var snackBar = SnackBar(
                                      content: Text(state.errorMessage));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: AlertDialog(
                                title: const Text(
                                  "Changer l'accès",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  "Confirmer pour changer l'accès à votre cagnotte.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
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
                                      bool access = collect.access;
                                      context.read<ButtonStateCubit>().excute(
                                            usecase: sl<CollectAccessUseCase>(),
                                            params: !access,
                                          );
                                      //Navigator.of(context).pop();
                                    },
                                    title: "Confirmer",
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Ionicons.warning_outline,
                              size: 28,
                              color: Color(0xFF2FA9A2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Accès",
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateFundRaisingPage(
                              id: collect.id,
                              title: collect.title,
                              amount: collect.targetAmount,
                              categoryId: collect.categories[0]["_id"],
                              description: collect.description,
                              status: collect.status,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Icon(
                              Ionicons.open_outline,
                              size: 28,
                              color: Color(0xFF2FA9A2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Modifier",
                            style: TextStyle(
                              color: Color(0xFF2FA9A2),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
            } else {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => AddContributionPage(
                              collectId: collect.id,
                              title: collect.title,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Icon(
                              Ionicons.add_outline,
                              size: 28,
                              color: Color(0xFF2FA9A2),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Contribuer",
                            style: TextStyle(
                              color: Color(0xFF2FA9A2),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
            }
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Padding collectBox(CollectEntity collect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF19A9A1), Color(0xFF00BB98)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              collectStatus(collect.status),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: statusColor(collect.status),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Volume',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0)
                          .format(collect.targetAmount),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collecté',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<double>(
                      future: ApiService().fetchAndSumAmounts(collect.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(
                            NumberFormat.currency(
                              locale: 'fr_FR',
                              symbol: 'FCFA',
                              decimalDigits: 0,
                            ).format(snapshot.data),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return Text('Pas de données disponibles');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Validité',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd/MM/yy')
                              .format(DateTime.parse(collect.startDate)),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 2),
                        Text('-'),
                        SizedBox(width: 2),
                        Text(
                          DateFormat('dd/MM/yy')
                              .format(DateTime.parse(collect.endDate)),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                BlocProvider(
                  create: (context) => ButtonStateCubit(),
                  child: BlocListener<ButtonStateCubit, ButtonState>(
                    listener: (context, state) {
                      if (state is ButtonSuccessState) {
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              collect.access ? 'Publique' : 'Privée',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 2),
                            const Icon(
                              Ionicons.eye_off_outline,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        );
                      }
                      if (state is ButtonFailureState) {
                        var snackBar =
                            SnackBar(content: Text(state.errorMessage));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          collect.access ? 'Publique' : 'Privée',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          collect.access
                              ? Ionicons.eye_outline
                              : Ionicons.eye_off_outline,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            FutureBuilder<double>(
              future:
                  ApiService().collectPercent(collect.id, collect.targetAmount),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return LinearPercentIndicator(
                    width: 300,
                    animation: true,
                    lineHeight: 3,
                    animationDuration: 1000,
                    percent: snapshot.data ?? 0.0,
                    barRadius: Radius.circular(4),
                    backgroundColor: Color(0xFFF7FDFC),
                    progressColor: Color(0xFF3FCB67),
                  );
                } else {
                  return Text('Pas de données disponibles');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
