import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/widgets/contributor_item.dart';
import 'package:likya_app/domain/entities/collect.dart';
import 'package:likya_app/presentation/collects/bloc/collect_display_cubit.dart';
import 'package:likya_app/presentation/collects/bloc/collect_display_state.dart';
import 'package:likya_app/presentation/collects/page/update_fund_raising_page.dart';
import 'package:likya_app/presentation/contributors/add_contributors.dart';
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
          create: (context) => CollectDisplayCubit()..displayCollect(),
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
                        collectContributorsTitle(),
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

  Padding collectContributorsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Liste des contributeurs.",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding collectContributors() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 180,
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'AMEDEKPEDZI Yao Mawunyo',
              " 5000.0",
            ),
            Divider(color: Colors.grey.shade200),
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'SENYO Komlan Brice',
              "15000.0",
            ),
            Divider(color: Colors.grey.shade200),
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'EKPO Wolanyo',
              "10000.0",
            ),
            Divider(color: Colors.grey.shade200),
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'AMOUZOU Kokou',
              "25000.0",
            ),
            Divider(color: Colors.grey.shade200),
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'AMOUZOU Kokou',
              "25000.0",
            ),
            Divider(color: Colors.grey.shade200),
            contributorItem(
              '1234',
              context,
              Ionicons.chevron_forward_outline,
              'AMOUZOU Kokou',
              "25000.0",
            ),
          ],
        ),
      ),
    );
  }

  Padding collectButtons(CollectEntity collect) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
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
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  "Mettre à jours",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                    Text(
                      "100 000 FCFA",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      collect.access ? 'Public' : 'Privé',
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
                ),
              ],
            ),
            SizedBox(height: 15),
            LinearPercentIndicator(
              width: 300,
              animation: true,
              lineHeight: 3,
              animationDuration: 1000,
              percent: 0.8,
              center: Text(
                "80.00%",
                style: TextStyle(fontSize: 2),
              ),
              barRadius: Radius.circular(4),
              backgroundColor: Color(0xFFF7FDFC),
              progressColor: Color(0xFF3FCB67),
            ),
          ],
        ),
      ),
    );
  }
}
