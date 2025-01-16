import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/common/bloc/button/button_state_cubit.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/data/models/add_collect_req.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/usecases/add_collect.dart';
import 'package:likya_app/presentation/collects/page/list_fund_raising_page.dart';
import 'package:likya_app/service_locator.dart';

class CreateFundRaisingPage extends StatefulWidget {
  const CreateFundRaisingPage({super.key});

  @override
  State<CreateFundRaisingPage> createState() => _CreateFundRaisingPageState();
}

class _CreateFundRaisingPageState extends State<CreateFundRaisingPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  final title = TextEditingController();
  final targetAmount = TextEditingController();
  final description = TextEditingController();
  final dateStart = TextEditingController();
  final dateEnd = TextEditingController();

  List<Map<String, dynamic>>? categories;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await ApiService().getCategories();
      if (fetchedCategories is List<Map<String, dynamic>>) {
        setState(() {
          categories = fetchedCategories;
        });
      } else {
        throw TypeError();
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching categories: $e");
    }
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
    _focusNode4.dispose();
    _focusNode5.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('fr', ''),
    );

    if (pickedDate != null) {
      setState(() {
        dateStart.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('fr', ''),
    );

    if (pickedDate != null) {
      setState(() {
        dateEnd.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Créer une cagnotte',
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
                  builder: (context) => ListFundRaisingPage(),
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
                      datesfild(),
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
            title: 'Ajouter la cagnotte',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // ignore: use_build_context_synchronously
                context.read<ButtonStateCubit>().excute(
                    usecase: sl<AddCollectUseCase>(),
                    params: AddCollectReqParams(
                      title: title.text,
                      targetAmount: int.parse(targetAmount.text),
                      description: description.text,
                      categoryIds: [selectedCategoryId],
                      access: true,
                      startDate: dateStart.text,
                      endDate: dateEnd.text,
                    ));
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Tous les champs sont recquis."),
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
        const Text(
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

  Padding datesfild() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Assure un bon alignement vertical
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Début',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dateStart,
                  focusNode: _focusNode4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Choisir la date",
                    suffixIcon: Icon(Icons.calendar_today),
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
                  readOnly: true,
                  onTap: () => _selectStartDate(context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fin',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dateEnd,
                  focusNode: _focusNode5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Choisir la date",
                    suffixIcon: Icon(Icons.calendar_today),
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
                  readOnly: true,
                  onTap: () => _selectEndDate(context),
                ),
              ],
            ),
          ),
        ],
      ),
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
