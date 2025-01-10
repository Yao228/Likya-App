import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/update_collect_req.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/usecases/update_collect.dart';
import 'package:likya_app/presentation/collects/page/detail_fund_raising_page.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/utils.dart';

class UpdateFundRaisingPage extends StatefulWidget {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final String description;
  final String status;

  const UpdateFundRaisingPage(
      {required this.id,
      required this.title,
      required this.amount,
      required this.categoryId,
      required this.description,
      required this.status,
      super.key});

  @override
  State<UpdateFundRaisingPage> createState() => _UpdateFundRaisingPageState();
}

class _UpdateFundRaisingPageState extends State<UpdateFundRaisingPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final title = TextEditingController();
  final targetAmount = TextEditingController();
  final description = TextEditingController();

  List<Map<String, dynamic>>? categories;
  String? selectedCategoryId;

  bool _collectStatus = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    title.text = widget.title;
    targetAmount.text = widget.amount.toStringAsFixed(0);
    description.text = widget.description;
    selectedCategoryId = widget.categoryId;

    if (collectStatus(widget.status) == "Validée") {
      setState(() {
        _collectStatus = true;
      });
    }
  }

  Future<void> fetchCategories() async {
    final fetchedCategories = await ApiService().getCategories();
    setState(() {
      categories = fetchedCategories as List<Map<String, dynamic>>?;
    });
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    targetAmount.dispose();
    description.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
                    collectID: widget.id,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titlefild(),
                      const SizedBox(height: 10),
                      amountfild(),
                      const SizedBox(height: 10),
                      categoriesField(),
                      const SizedBox(height: 10),
                      descriptionfild(),
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
            title: _collectStatus ? 'Cagnotte activée' : 'Modifier la cagnotte',
            onPressed: () async {
              if (!_collectStatus) {
                if (_formKey.currentState!.validate()) {
                  // ignore: use_build_context_synchronously
                  context.read<ButtonStateCubit>().excute(
                      usecase: sl<UpdateCollectUseCase>(),
                      params: UpdateCollectReqParams(
                        targetAmount: int.parse(targetAmount.text),
                        title: title.text,
                        categoryIds: [selectedCategoryId],
                        description: description.text,
                      ));
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Tous les champs sont recquis.$_collectStatus"),
                    ),
                  );
                }
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "Cette cagnotte est validée et ne peut plus être modifiée."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Padding titlefild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Titre de la cagnotte',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: title,
          focusNode: _focusNode1,
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
          controller: targetAmount,
          focusNode: _focusNode2,
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

  Padding descriptionfild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          controller: description,
          focusNode: _focusNode3,
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

  Padding categoriesField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catégorie',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          categories == null
              ? CircularProgressIndicator()
              : DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    //labelText: 'Select a category',
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
                  hint: Text("Choisir une catégorie"),
                  items: categories!.map((category) {
                    return DropdownMenuItem<String>(
                      value: category["_id"],
                      child: Text(category["name"]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                ),
        ],
      ),
    );
  }
}
