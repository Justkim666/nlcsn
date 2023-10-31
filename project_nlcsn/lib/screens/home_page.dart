import 'package:flutter/material.dart';
import 'package:project_nlcsn/models/product_model.dart';
import 'package:project_nlcsn/screens/product_page.dart';
import 'package:project_nlcsn/widgets/drawer.dart';
import 'package:project_nlcsn/widgets/popular_menu.dart';
import 'package:project_nlcsn/widgets/search.dart';
import 'package:project_nlcsn/widgets/top_promo_slider.dart';

import '../constants.dart';
import '../services/font_size.dart';
import 'cart_page.dart';
import '../managers/products_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leadingWidth: ,
        backgroundColor: const Color(0xFF00000A),
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                icon: Icon(Icons.shopping_cart,
                    color: listOfCart.isEmpty
                        ? const Color(0xFFFFFFFF)
                        : Colors.amber,
                    size: 20),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartPage()));
                  setState(() {});
                }
                ),
            const SizedBox(
              width: 8,
            ),
            //numbers icon in cart
            listOfCart.isEmpty
                ? const SizedBox()
                : Text('${listOfCart.length} items',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizeService().fs_s14,
                    )),
          ]),
        ),
        elevation: 10,
      ),
      // body: listProductCard(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const MySearch(),
            Expanded(child: listProductCard()),
          ],
        ),
      ),
    );
  }

  Widget listProductCard(){
    final productManager = ProductManager();
    return FutureBuilder(
      future: productManager.getAllProduct(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return productCard(data[index]);
          //   },
          // );
          return ListView(
            children: [
              const TopPromoSlider(),
              const PopularMenu(),
              for(final product in data) productCard(product),
            ],
          );
        }
        if(!snapshot.hasData){
          return const Text("Products not found!");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget productCard(ProductModel product) {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: const Color(0xFFEBEBEE),
          elevation: 10,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //img, text, description, price
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        padding: const EdgeInsets.all(8),
                        // Border width
                        //decoration: BoxDecoration(color: Color(0xFF00000A), borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(48), // Image radius
                              child: Image.network(product.mainImage!)
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 180.0,
                        height: 150.0,
                        // color: Colors.red,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeService().fs_s16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Colour : ${product.colour!}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSizeService().fs_s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              product.quantity! > 0 ? 'Quantity : ${product.quantity}' : "unavailable",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSizeService().fs_s12,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              '${product.price}\$',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeService().fs_s14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(product: product)));
        setState(() {});
      },
    );
  }
}
