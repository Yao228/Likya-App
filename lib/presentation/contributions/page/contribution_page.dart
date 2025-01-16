import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:likya_app/domain/entities/contribution.dart';
import 'package:likya_app/presentation/contributions/bloc/contribution_display_cubit.dart';
import 'package:likya_app/presentation/contributions/bloc/contribution_display_state.dart';

class ContributionPage extends StatefulWidget {
  final String contributorName;
  final String contributionId;

  const ContributionPage(
      {required this.contributorName, required this.contributionId, super.key});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails de la contribution',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              ContributionDisplayCubit()..displayContribution(widget.contributionId),
          child:
              BlocBuilder<ContributionDisplayCubit, ContributionDisplayState>(
            builder: (context, state) {
              if (state is ContributionLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ContributionLoaded) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        _contributor(state.contributiontEntity),
                        Divider(color: Color(0xFF99CCCC)),
                        _amount(state.contributiontEntity),
                        Divider(color: Color(0xFF99CCCC)),
                        _keepAnonymous(state.contributiontEntity),
                        Divider(color: Color(0xFF99CCCC)),
                        _comment(state.contributiontEntity),
                        Divider(color: Color(0xFF99CCCC)),
                        _contributedAt(state.contributiontEntity)
                      ],
                    ),
                  ),
                );
              }
              if (state is LoadContributionFailure) {
                return Text(state.errorMessage);
              }
              return Text('Error');
            },
          ),
        ),
      ),
    );
  }

  Padding _contributor(ContributionEntity contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Contributeur",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            contribution.contributor,
            style: TextStyle(
              color: Color(0xFF03544F),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding _amount(ContributionEntity contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Contribution",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            NumberFormat.currency(
                    locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0)
                .format(contribution.amount),
            style: TextStyle(
              color: Color(0xFF03544F),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding _keepAnonymous(ContributionEntity contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Anonymat",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            contribution.keepAnonymous ? "Oui" : "Non",
            style: TextStyle(
              color: Color(0xFF03544F),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding _comment(ContributionEntity contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Commentaire",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            contribution.comment,
            style: TextStyle(
              color: Color(0xFF03544F),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding _contributedAt(ContributionEntity contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Date",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            DateFormat('dd/MM/yy')
                .format(DateTime.parse(contribution.contributedAt)),
            style: TextStyle(
              color: Color(0xFF03544F),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
