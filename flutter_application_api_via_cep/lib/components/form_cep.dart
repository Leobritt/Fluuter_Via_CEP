import 'package:flutter/material.dart';
import 'package:flutter_application_api_via_cep/components/button.dart';

class FormCep extends StatefulWidget {
  const FormCep({super.key, required this.onSearch});

  final Function onSearch;

  @override
  State<FormCep> createState() => _FormCepState();
}

class _FormCepState extends State<FormCep> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController _searchController = TextEditingController();

    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              keyboardType: TextInputType.number,
              controller: _searchController,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Button(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.onSearch(_searchController.text);
                  }
                },
                text: 'Search')
          ],
        ));
  }
}
