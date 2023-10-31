import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductManager {
  final productsCollection = FirebaseFirestore.instance.collection("products");

  Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> listProduct = [];
    final data = await productsCollection.get();

    for(final document in data.docs){
        final result = document.data();
        result["id"] = document.id;
        listProduct.add(ProductModel.fromJson(result));
    }

    return listProduct;
  }

}