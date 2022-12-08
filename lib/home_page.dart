import 'dart:convert' as convert;

import 'package:delacruz_assignment/add_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List receiver = <dynamic>[];
  Future<void> getData()async{
    final uri = Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10');
    final response=await http.get(uri);
    final jsonValue = convert.jsonDecode(response.body) as Map;
    final decodeValue = jsonValue['items'] as List;
    setState(() {
      receiver = decodeValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Information'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: getData,
        child: ListView.builder(
          itemCount: receiver.length,
          itemBuilder: (context,index){
          var item = receiver[index] as Map;
          var nameAtIndex = item['title'];

          return Card(
            
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTodoPage()));
      },
      child: const Icon(Icons.add),
      ),
    );
  }
}