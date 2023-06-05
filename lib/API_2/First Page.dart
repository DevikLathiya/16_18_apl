import 'dart:convert';
import 'dart:ffi';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  final TextEditingController _from = TextEditingController();
  final TextEditingController _to = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  String rate="";
  bool temp = false,tp=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency App"),backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 60,alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orangeAccent),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(offset: Offset(1, 4),color: Colors.grey.shade300,blurRadius: 5),
                  BoxShadow(offset: Offset(-1, -2),color: Colors.grey.shade300,blurRadius: 5),
                ]
              ),
              child: TextField(controller: _from,
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      _from.text = currency.code;
                      setState(() {});
                    },
                  );
                },
                decoration:  const InputDecoration(border: InputBorder.none,
                    hintText: "From",
                    prefixIcon: Icon(Icons.toggle_off_rounded),)),
            ),

            Container(height: 60,alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(offset: Offset(1, 4),color: Colors.grey.shade300,blurRadius: 5),
                    BoxShadow(offset: Offset(-1, -2),color: Colors.grey.shade300,blurRadius: 5),
                  ]
              ),
              child: TextField(controller: _to,
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      _to.text = currency.code;
                      setState(() {});
                    },
                  );
                },
                decoration: const InputDecoration(border: InputBorder.none,
                    hintText: "To",
                    prefixIcon: Icon(Icons.toggle_on)),),
            ),

            Container(height: 60,alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(offset: const Offset(1, 4),color: Colors.grey.shade300,blurRadius: 5),
                    BoxShadow(offset: const Offset(-1, -2),color: Colors.grey.shade300,blurRadius: 5),
                  ]
              ),
              child: TextField(controller: _amount,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(border: InputBorder.none,
                hintText: "Amount",
                prefixIcon: Icon(Icons.currency_bitcoin_rounded)),),
            ),

            InkWell(onTap: () async{
              String from = _from.text , to = _to.text , amount = _amount.text;
              if (from.isNotEmpty || to.isNotEmpty || amount.isNotEmpty) {
                try {
                    var url = Uri.parse("https://deviksite.000webhostapp.com/API%202/Currency.php");
                    var response = await http.post(url,body: {"from" : from, "to" : to, "amount" : amount});

                    if (response.statusCode == 200)
                    {
                      tp =true;
                      Map m = jsonDecode(response.body);
                      if(m['success'] == true)
                      {
                        print(response.body);
                        Map f = m['info'];
                        rate = m['result'].toString();
                      }
                      temp=true;
                      setState(() {});
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something Wrong")));
                    }
                } on Exception catch (e) { print(e);}
              }
              else
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Filed Required ")));
              }},
              child: Container(margin: const EdgeInsets.only(top: 40),alignment: Alignment.center,
                width: 280,height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.8),width: 2),
                  borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [Colors.amber.shade400,Colors.orangeAccent,Colors.orange],),
                    boxShadow: [
                      BoxShadow(offset: const Offset(1, 4),color: Colors.grey.shade300,blurRadius: 5),
                      BoxShadow(offset: const Offset(-1, -2),color: Colors.grey.shade300,blurRadius: 5),
                    ]
                ),
                child: const Text("Exchange",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
              ),),

            (tp) ? (temp) ? Container(height: 100,width: 300,alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 50,left: 10,right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orangeAccent,width: 2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(offset: const Offset(1, 4),color: Colors.grey.shade300,blurRadius: 8),
                    BoxShadow(offset: const Offset(-1, -2),color: Colors.grey.shade300,blurRadius: 8),
                  ]
              ),
              child: Text("Rate :  $rate",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500)),
            ) : CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
/*<?php

$curl = curl_init();

curl_setopt_array($curl, [
	CURLOPT_URL => "https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=AUD&to=CAD&amount=1",
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_ENCODING => "",
	CURLOPT_MAXREDIRS => 10,
	CURLOPT_TIMEOUT => 30,
	CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	CURLOPT_CUSTOMREQUEST => "GET",
	CURLOPT_HTTPHEADER => [
		"X-RapidAPI-Host: currency-converter5.p.rapidapi.com",
		"X-RapidAPI-Key: SIGN-UP-FOR-KEY"
	],
]);

$response = curl_exec($curl);
$err = curl_error($curl);

curl_close($curl);

if ($err) {
	echo "cURL Error #:" . $err;
} else {
	echo $response;
}*/