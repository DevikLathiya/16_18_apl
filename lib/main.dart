import 'package:apl/API_4/Home.dart';
import 'package:apl/API_4/get/get_bloc.dart';
import 'package:apl/API_4/get/get_event.dart';
import 'package:apl/API_4/get/get_state.dart';
import 'package:apl/API_4/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'API_1/Frist Page.dart';
import 'API_2/First Page.dart';
import 'API_3/First Page.dart';
import 'API_4/Shop_cubit/shop_cubit.dart';

void main()  {
  // ProductRepository productRepository = ProductRepository();
  // productRepository.fetchProduct();
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(ResponsiveSizer(
    builder: (context, orientation, screenType) {
      return  MultiBlocProvider(
        providers: [
          BlocProvider<GetBloc>(create: (context) => GetBloc()),
          BlocProvider<ShopingAuth>(create: (context) => ShopingAuth()),
        ],
        child: const GetMaterialApp(
          home: Pages(),
          debugShowCheckedModeBanner: false,
        ),
      );
    },
  ));
}

// 1 Home  -- crud operation
// 2 Home1  --Currency Exchange
// 3 Home2  -- Rick & Morty Api
// 3 Home3  -- Shopping site

class Pages extends StatelessWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("API CALL"),
        ),
        body: Column(
          children:  [
            Container(margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),)),
                title: const Text("Crud Operation"),
                leading: const Icon(Icons.api_rounded),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            Container(margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home1(),)),
                title: const Text("Currency Exchange"),
                leading: const Icon(Icons.api_rounded),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            Container(margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home2(),)),
                title: const Text("Rick & Morty API"),
                leading: const Icon(Icons.api_rounded),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),

           /* Container(margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.cyan.shade200,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home3(),)),
                title: const Text("E-Commerce"),
                leading: const Icon(Icons.api_rounded),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
              )
            ),*/

            Container(margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                borderRadius: BorderRadius.circular(15)
              ),
              child: BlocBuilder<GetBloc,GetState>(builder: (context, state) {
                if(state is GetLoading)
                  {
                    return CircularProgressIndicator();
                  }

                return ListTile(
                  onTap: () {
                    BlocProvider.of<GetBloc>(context).add(GetData());
                  },
                  title: const Text("E-Commerce"),
                  leading: const Icon(Icons.api_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}
