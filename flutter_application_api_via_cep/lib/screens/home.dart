import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_api_via_cep/components/form_cep.dart';
import 'package:http/http.dart' as http;
import '../models/cep.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Cep? _cepData;

  // Novo controller para o campo de entrada

  Future<void> searchCep(String cep) async {
    // Montando a URL da API
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    setState(() {
      _cepData = Cep.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('VIA CEP')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FormCep(
              onSearch: (cep) {
                searchCep(cep);
              },
            ),
            if (_cepData != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CEP: ${_cepData!.cep}'),
                    Text('Logradouro: ${_cepData!.logradouro}'),
                    Text('Bairro: ${_cepData!.bairro}'),
                    Text('Cidade: ${_cepData!.localidade}'),
                    Text('UF: ${_cepData!.uf}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
