import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../main.dart';
import 'Home.dart';

class ProductPage extends StatelessWidget {
  Map product;
  ProductPage(this.product, {Key? key}) : super(key: key);
  List images = [];
  @override
  Widget build(BuildContext context) {
    images=product['images'];
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),alignment: Alignment.center,
              height: 50, width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10)),
              child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home3(),)),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text("${product['title']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pages(),)),
                      icon: const Icon(Icons.exit_to_app_rounded)),
                ],
              ),),
            Expanded(flex: 1,
                child: PageView.builder(itemCount:  images.length,
                  itemBuilder: (context, index) {
                  return Image(image: NetworkImage("${images[index]}"));
                },
                  scrollDirection: Axis.horizontal,
                )),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${product['title']}",style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10,),
                  RatingBarIndicator(
                    rating: double.parse(product['rating'].toString()),
                    itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber,),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),const SizedBox(height: 5),
                  Text("Brand : ${product['brand']}",style: const TextStyle(fontSize: 16)),
                  Text("Available Stock : ${product['stock']}",style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${product['discountPercentage']}% Off",style: const TextStyle(fontSize: 15)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("€ ${product['price']}",style: const TextStyle(fontSize: 15,)),
                      ),
                      //Text("₹12000",style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.pedal_bike,size: 20,),
                      Text(" Free Delivery",style: TextStyle(fontSize: 13)),
                    ],
                  ),

                  Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      child: Text("${product['description']}",style: const TextStyle(fontSize: 16),textAlign: TextAlign.center)),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
