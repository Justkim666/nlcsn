import 'package:flutter/material.dart';

// import '../constants.dart';
// import '../models/product.dart';
import '../constants.dart';
import '../services/font_size.dart';
import '../models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final User? currentUser = FirebaseAuth.instance.currentUser;
  List<String> keyList = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          leadingWidth: 60,
          backgroundColor: const Color(0xFF00000A),
          // icon back
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF), size: 20),
              onPressed: () {
                Navigator.pop(context);
              }),
          titleSpacing: 0.0,
          // horizontal 20%
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // ...
                  IconButton(
                      icon: const Icon(Icons.more_horiz,
                          color: Color(0xFFFFFFFF), size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ]),
          ),
          elevation: 8,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // img 30% screen
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.white,
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.product.mainImage!,
                      fit: BoxFit.contain,
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.white,
                  child: Container(
                    // radius
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        color: Color(0xFFF2F2F7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              // name
                              child: Text(
                                //product name
                                widget.product.name!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSizeService().fs_s20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            // In Stock
                            Padding(
                              padding: const EdgeInsets.only(left: 270),
                              child: Text(
                                widget.product.stockStatus!,
                                style: TextStyle(
                                  color: const Color(0xFFa86432),
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontSizeService().fs_s15,
                                ),
                              ),
                            ),
                            // brand - SKU
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Brand : ${widget.product.brandName!}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                                Text(
                                  'SKU : ${widget.product.sku}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            //price - Colour
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.product.price!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSizeService().fs_s18,
                                  ),
                                ),
                                Text(
                                  'Colour : ${widget.product.colour!.toUpperCase()}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            //description
                            SizedBox(
                              height: 150,
                              child: Text(widget.product.description!,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontSizeService().fs_s14,
                                    // letterSpacing: 3,
                                    //wordSpacing: 3,
                                  )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // size
                                Text(
                                  'Select Size:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: FontSizeService().fs_s18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // select size => goto
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: selectSize(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                // Add to the Cart
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    // go to list of cart
                                    onPressed: (widget.product.quantity == 0 || keyList.isEmpty || currentUser == null) ? null : () {
                                      listOfCart.add(widget.product.copyWith(
                                          sizes: [widget.product.sizes![int.parse(keyList.first)]]
                                      ));
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF00000A),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Add to the Cart  ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: FontSizeService().fs_s16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }

  // create 4 chipDesign (size = 4) 8-9-10-11
  List<Widget> selectSize() {
    List<Widget> data = [];
    int index = 0;
    for (var d in widget.product.sizes!) {
      // go to chipDesign widget and create
      data.add(chipDesign(d, index.toString()));
      index++;
    }
    return data;
  }

  // press ? chosen => remove => black <>
  void selectChip(String key) {
    if (keyList.contains(key)) {
      keyList.remove(key);
    } else {
      keyList.clear();
      keyList.add(key);
    }
    setState(() {});
  }

  Widget chipDesign(String label, String key) {
    return Container(
      decoration: BoxDecoration(
        // display chosen => yellow, not chosen yet => black
        color: keyList.contains(key)
            ? const Color(0xFFF9D105)
            : const Color(0xFF00000A),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      // press ? chosen or not => selectChip check
      child: InkWell(
        onTap: () {
          selectChip(key);
        },
        // padding + edit text (chosen or not)
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Center(
            child: Text(
              label.toString(),
              style: TextStyle(
                color: keyList.contains(key) ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}