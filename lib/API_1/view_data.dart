// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Frist Page.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List l = [];
  bool temp = false;

  @override
  void initState() {
    super.initState();
    get_data();
  }

  get_data() async {
    var url = Uri.parse('https://deviksite.000webhostapp.com/API%201/view_contact.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map m = jsonDecode(response.body);
      l = m['Data'];
      temp = true;
      print(l);
      setState(() { });
    }
  }

  delete_Data(String id , img) async {
     try
     {
      var urll = Uri.parse('https://deviksite.000webhostapp.com/API%201/delete_contact.php');
      var response = await http.post(urll,body: {"id" : id,'image': img});
      var res = jsonDecode(response.body);

      if(res['result']=='done'){ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Record Deleted'),));}
      else {  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong'),));}
      get_data();
     } 
     catch (e) { print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("View API Data"),actions: [IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return Home();},)), icon: Icon(Icons.add_circle_outline_sharp))],
      ),
      body: (temp)
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    selectedTileColor: Colors.cyan.shade200,
                    tileColor: Colors.cyan.shade100,
                    title: Text("${l[index]['name']}"),
                    subtitle: Text("${l[index]['contact']}"),
                    leading: CircleAvatar(backgroundImage: NetworkImage("https://deviksite.000webhostapp.com/API%201/${l[index]['image']}")),
                    trailing: Wrap(
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return Home(l[index]);
                          },));
                        },icon: const Icon(Icons.edit,color: Colors.black,)),
                        IconButton(onPressed: () {
                            delete_Data(l[index]['id'],l[index]['image']);
                        },icon: const Icon(Icons.delete,color: Colors.black,)),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
