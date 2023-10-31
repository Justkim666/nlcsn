import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartManager {
  final productsCollection = FirebaseFirestore.instance.collection("History");
  final User user = FirebaseAuth.instance.currentUser!;

  Future<void> themLichSuMuaHang({required List<ProductModel> cart, required String userId, required String date, required String total}) async {
    final HistoryModel history = HistoryModel(
      userId: userId,
      dateTime: date,
      total: total,
      products: cart
    );

    await productsCollection.add(history.toJson());
  }

  Future<List<HistoryModel>> getAllHistory() async {
    List<HistoryModel> histories = [];
    final data = await productsCollection.where("userId", isEqualTo: user.uid).get();

    for(final document in data.docs){
      final result = document.data();
      // result["id"] = document.id;
      histories.add(HistoryModel.fromJson(result));
    }

    return histories;
  }

}