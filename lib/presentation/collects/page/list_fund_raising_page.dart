import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/common/widgets/collect_item.dart';
import 'package:likya_app/presentation/collects/bloc/collects_display_cubit.dart';
import 'package:likya_app/presentation/collects/bloc/collects_display_state.dart';

class ListFundRaisingPage extends StatefulWidget {
  const ListFundRaisingPage({super.key});

  @override
  State<ListFundRaisingPage> createState() => _ListFundRaisingPageState();
}

class _ListFundRaisingPageState extends State<ListFundRaisingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des cagnottes',
          style: TextStyle(
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
                searchForm(),
                listCollects(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding listCollects() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: BlocProvider(
        create: (context) => CollectsDisplayCubit()..displayCollects(),
        child: BlocBuilder<CollectsDisplayCubit, CollectsDisplayState>(
            builder: (context, state) {
          if (state is CollectsLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CollectsLoaded) {
            return Container(
              padding: const EdgeInsets.all(0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  var collect = state.items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: collectItem(
                      collect.id,
                      context,
                      Ionicons.archive_outline,
                      collect.title,
                      collect.description,
                      collect.targetAmount.toString(),
                      collect.startDate,
                      collect.endDate,
                      collect.status,
                      0.1,
                      '10%',
                    ),
                  );
                },
              ),
            );
          }
          if (state is LoadCollectsFailure) {
            return Text(state.errorMessage);
          }
          return const Text('Une erreur inattendue est survenue.');
        }),
      ),
    );
  }

  Padding searchForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        style: const TextStyle(fontSize: 18, color: Color(0xFF575757)),
        decoration: InputDecoration(
          suffixIcon:
              const Icon(Ionicons.search_outline, color: Color(0xFFCCCCCC)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF575757), width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
        ),
      ),
    );
  }
}
