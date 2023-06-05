import 'package:apl/API_4/Home.dart';
import 'package:apl/API_4/Product%20Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../API_1/Frist Page.dart';
import '../main.dart';

class HomeProduct extends StatelessWidget {
    List category;
   HomeProduct(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),padding: const EdgeInsets.all(5),
                height: 50,width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home3(),)),
                        icon: const Icon(Icons.arrow_back_ios)),
                    Text(category[0]["category"],style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pages(),)),
                        icon: const Icon(Icons.exit_to_app))
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(itemCount: category.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.off(ProductPage(category[index]));
                      },
                      child: Row(
                        children: [
                          Container(margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),width: 120,height: 100,
                              child:  Image(fit: BoxFit.fill,image: NetworkImage("${category[index]['thumbnail']}"))),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (category[index]['title'].toString().length >22) ?
                                Text("${category[index]['title'].toString().substring(0,22)}...",style: const TextStyle(fontSize: 18)) :
                                Text("${category[index]['title']}",style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 10,),
                                RatingBarIndicator(
                                  rating: double.parse(category[index]['rating'].toString()),
                                  itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text("${category[index]['discountPercentage']}% Off",style: TextStyle(fontSize: 15)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("€ ${category[index]['price']}",style: TextStyle(fontSize: 15,)),
                                    ),
                                    //Text("₹12000",style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.pedal_bike,size: 20,),
                                    Text(" Free Delivery",style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },),
              ),
            ],
          )
      )
    );
  }
}
/*BlocBuilder<ShopingAuth,ShopingState>(
            builder: (context, state) {
            if(state is ShopingLodingState)
            {
              return CircularProgressIndicator();
            }
            if(state is ShopingLoddedState)
              {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),padding: const EdgeInsets.all(5),
                      height: 50,width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home3(),)),
                              icon: const Icon(Icons.arrow_back_ios)),
                          IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeProduct(),)),
                              icon: const Icon(Icons.refresh_outlined))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(margin: const EdgeInsets.symmetric(vertical: 8),height: 100,
                                  child: const Image(image: NetworkImage("https://img.dxcdn.com/newprdimgs/20210319/5704160d20e69a16f03e95aee13e65e8.jpg"))),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mobile Reo - 10",style: TextStyle(fontSize: 18),),
                                    const SizedBox(height: 10,),
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Text("18% Off",style: TextStyle(fontSize: 15)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text("18000",style: TextStyle(fontSize: 15,)),
                                        ),
                                        Text("₹12000",style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.pedal_bike,size: 20,),
                                        Text(" Free Delivery",style: TextStyle(fontSize: 13)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },),
                    ),
                  ],
                );
              }
            return Text("Error");
          },)*/