import 'package:apl/API_4/Product%20Page.dart';
import 'package:apl/API_4/get/get_bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../main.dart';
import 'Home_Product.dart';

class Home3 extends StatefulWidget {
   Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  List<String> images = [
    "https://web-station.it/wp-content/uploads/2019/10/e-commerce-definizione-cos-e.jpg",
    "https://www.icopify.com/wp-content/uploads/2020/03/Ecommerce.jpg",
    "https://web-station.it/wp-content/uploads/2019/10/e-commerce-definizione-cos-e.jpg",
    "https://www.icopify.com/wp-content/uploads/2020/03/Ecommerce.jpg",
    "https://web-station.it/wp-content/uploads/2019/10/e-commerce-definizione-cos-e.jpg"
  ];

   List icon=["images/smartphones.png","images/desktop.png","images/perfume.png","images/food.png","images/skincare.png","images/house-decoration.png"];
   List iconName=["Smartphones","Desktop","fragrances","Groceries","SkinCare","Decoration"];
   Map data={};
   List product = [],pass=[];
   List decoration = [],laptops = [],fragrances = [],skincare = [], groceries = [],smartphones = [];

   getData(){
     final bloc = BlocProvider.of<GetBloc>(context);
     data = bloc.list;
     product = data['products'];
     print(product);

     for(int i= 0;i<product.length;i++)
       {
        if(product[i]['category']=="smartphones") { smartphones.add(product[i]);}
         else if(product[i]['category']=="laptops") { laptops.add(product[i]);}
         else if(product[i]['category']=="fragrances") {  fragrances.add(product[i]);}
         else if(product[i]['category']=="skincare") {  skincare.add(product[i]); }
         else if(product[i]['category']=="groceries") {  groceries.add(product[i]); }
         else if(product[i]['category']=="home-decoration") {  decoration.add(product[i]); }
       }
   }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              children:  [
                Container(
                  margin: const EdgeInsets.all(10),padding: const EdgeInsets.all(5),
                  height: 50,width: double.infinity,alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Pages(),)),
                          icon: const Icon(Icons.arrow_back_ios)),
                      const Text("Shopping Site",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home3(),)),
                          icon: const Icon(Icons.refresh_outlined,size: 25,))
                    ],
                  )
                ),

                Expanded(flex: 1,
                  child: ListView.builder(
                    itemCount: icon.length,scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5),alignment: Alignment.center,width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 5,spreadRadius: 1, offset: const Offset(0, 0),),]
                        ),
                        child: InkWell(
                          onTap: () {
                            if(index==0) { pass.clear(); pass = smartphones;}
                            else if (index==1) { pass.clear(); pass = laptops;}
                            else if (index==2) { pass.clear(); pass = fragrances;}
                            else if (index==3) { pass.clear(); pass = groceries;}
                            else if (index==4) { pass.clear(); pass = skincare;}
                            else if (index==5) { pass.clear(); pass = decoration;}

                            Get.off(HomeProduct(pass));
                          },
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 40,child: Image(fit: BoxFit.fill,image: AssetImage(icon[index]))),
                              Text(iconName[index])
                            ],
                          ),
                        ),
                      );
                    },),
                ),

                Container(margin:const EdgeInsets.fromLTRB(10,10,10,10),
                    height:200,width:double.infinity,
                    decoration:BoxDecoration(color:Colors.white, borderRadius:BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(color: Colors.grey,offset: Offset(0, 0),blurRadius: 2,spreadRadius: 1),]),
                    child:ClipRRect(
                      borderRadius:BorderRadius.circular(10),
                      child:AspectRatio( aspectRatio:16/9,
                        child:Carousel(
                            dotSize:4, dotSpacing:15,
                            dotColor:Colors.lightBlueAccent, indicatorBgPadding:5,
                            dotBgColor:Colors.transparent, dotVerticalPadding:5,
                            dotPosition:DotPosition.bottomCenter,
                            images:images.map((e)=>Image(fit:BoxFit.cover,image: NetworkImage(e))).toList()
                        ),),
                    )
                ),

                Expanded(flex: 5,
                    child: GridView.builder(itemCount: product.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProductPage(product[index]);
                            },));
                          },
                          child: Card(
                              child: Column(
                                children: [
                                  Container(margin: const EdgeInsets.symmetric(vertical: 8),height: 100,
                                      child:Image(fit: BoxFit.fill,image: NetworkImage(product[index]['thumbnail'].toString()))),
                                  (product[index]['title'].toString().length > 20) ? Text(product[index]['title'].toString().substring(0,20)) :Text(product[index]['title']),
                                  Text("₹ ${product[index]['price']}"),
                                ],
                              )
                          ),
                        );
                      },

                    ))
              ],
            ),
          )),
    );
  }
}