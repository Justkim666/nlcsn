import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_nlcsn/models/product_model.dart';
import '../constants.dart';
// import '../models/product.dart';
import '../services/font_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../managers/cart_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String total = '';
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CartManager cartManager = CartManager();

  @override
  void initState() {
    super.initState();
    if (listOfCart.isNotEmpty) {
      setTotal();
    }
  }

  void setTotal() {
    double totalVal = 0.0;
    for (var data in listOfCart) {
      totalVal = totalVal + double.parse(data.price!);
    }
    setState(() {
      total = 'Total: ${totalVal.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00000A),
        // Icon back
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color(0xFFFFFFFF), size: 20),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(
          'Cart Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: FontSizeService().fs_s18,
          ),
        ),
        elevation: 8,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // size total
              height: MediaQuery.of(context).size.height * 0.75,
              color: Colors.white,
              child: Padding(
                  padding:
                      // effect size
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  // check empty or not
                  child: listOfCart.isEmpty
                      ? const Center(
                          child: Text('No Products.'),
                        )
                      : ListView.builder(
                          itemCount: listOfCart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return productCard(listOfCart[index], index);
                          },
                        )),
            ),
            listOfCart.isEmpty
                ? const SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: const Color(0xFFEBEBEE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // total
                        Text(
                          '${total}\$',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSizeService().fs_s18,
                          ),
                        ),
                        // button checkout
                        ElevatedButton(
                          onPressed: currentUser != null
                              ? () {
                            cartManager.themLichSuMuaHang(cart: listOfCart, userId: currentUser!.uid, date: DateTime.now().toString(), total: total)
                              .then((value) {
                              listOfCart.clear();
                              Navigator.pop(context);
                              if (kDebugMode) {
                                print('Button clicked!');
                              }
                            });
                          } : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00000A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'Checkout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: FontSizeService().fs_s16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget productCard(ProductModel product, int index) {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: const Color(0xFFEBEBEE),
          elevation: 10,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                              child: Image.network(product.mainImage!)),
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
                              height: 8,
                            ),
                            Text(
                              'Colour : ${product.colour!}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: FontSizeService().fs_s12,
                              ),
                            ),
                            Text("Size: ${product.sizes!.first}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${product.price!}\$ ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizeService().fs_s14,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      listOfCart.removeAt(index);
                                      setState(() {
                                        if (listOfCart.isNotEmpty) {
                                          setTotal();
                                        } else {
                                          total = 'Total: 0.00\$';
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
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
        // await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomePage(product: product)));
        setState(() {});
      },
    );
  }
}
