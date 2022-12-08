import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameVal = TextEditingController();
  TextEditingController mailVal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: const Text('Add Information'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
        children: [
          TextFormField(
            controller: nameVal,
            decoration: const InputDecoration(labelText: "Name"),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your name";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: mailVal,
            decoration: const InputDecoration(labelText: "Email Address"),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your Email Address";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child:
                ElevatedButton(onPressed: () {
                  if(formKey.currentState!.validate()){
                    postData();
                  }
                }, child: const Text('Submit')),
          )
        ],
      )),
    );
  }

  Future<void> postData() async {
    final name = nameVal.text;
    final mailName = mailVal.text;
    final body = {
      "title": name,
      "description": mailName,
      "is_completed": false
    };
    final uri = Uri.parse('https://api.nstack.in/v1/todos');
    final response = await http.post(uri, body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'}
    );
    print(response.statusCode);
  }
}
