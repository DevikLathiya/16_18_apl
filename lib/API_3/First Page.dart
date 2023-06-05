import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {

  List data = [];
  List location=[];
  List origin=[];

   viewData() async{
    var url = Uri.parse("https://rickandmortyapi.com/api/character");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        final mainData = jsonDecode(response.body);
        data = mainData['results'];
        for (int i = 0; i<data.length; i++) {
            location.add(data[i]['location']['name']);
            origin.add(data[i]['origin']['name']);
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      print("Error :::"+e.toString());
    }
  }
  @override
  void initState() {
    viewData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      /*appBar: AppBar(
        title: const Text("The Rick and Morty API"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home2(),));
          }, icon: const Icon(Icons.refresh_rounded))
        ],
      ),*/
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 18.h,width: 100.w,alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/image1.png"))
                ),
                child: const Text("The Rick and Morty API",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
            Expanded(
              child: FutureBuilder(
                future: viewData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done)
                    {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(32, 35, 41,1),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15))
                        ),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(10), height: 18.h, width: 100.w,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(94, 94, 94, 1.0),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(height: 18.h,width: 40.w,
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan,
                                            image: DecorationImage(image: NetworkImage("${data[index]['image']}")),
                                            borderRadius: BorderRadius.circular(10)
                                        ),),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          (data[index]['name'].toString().length > 16) ?
                                          Text("${data[index]['name'].toString().substring(0,16)}...",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),) :
                                          Text("${data[index]['name']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),

                                          Row(
                                            children: [
                                              Container(height: 1.5.h,width: 3.w,margin: const EdgeInsets.only(right: 3),
                                                decoration: BoxDecoration(
                                                    color:(data[index]['status']=="Alive") ?  Colors.green : (data[index]['status']=="Dead") ? Colors.red  : Colors.grey.shade300,
                                                    borderRadius: BorderRadius.circular(50)),),
                                              Text("${data[index]['status']} - ${data[index]['species']}",style: const TextStyle(color: Colors.white),)
                                            ],
                                          ),
                                          SizedBox(height: 2.h,),
                                          Text("Last known location:",style: TextStyle(color: Colors.grey.shade300.withOpacity(0.9)),),
                                          (location[index].toString().length > 24) ? Text("${location[index].toString().substring(0,24)}...",style: const TextStyle(color: Colors.white),)
                                              :Text("${location[index]}",style: const TextStyle(color: Colors.white),),
                                          SizedBox(height: 2.h,),

                                          Text("Origin:",style: TextStyle(color: Colors.grey.shade300.withOpacity(0.9)),),
                                          (origin[index].toString().length > 24) ?Text("${origin[index].toString().substring(0,24)}...",style: const TextStyle(color: Colors.white),)
                                          : Text("${origin[index]}",style: const TextStyle(color: Colors.white),),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),);
                          },),
                      );
                    }
                  else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
