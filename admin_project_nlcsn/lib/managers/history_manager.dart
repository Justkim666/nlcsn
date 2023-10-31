import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/history_model.dart';

class HistoryManger {

  final historyCollection = FirebaseFirestore.instance.collection("History");


  Future<List<HistoryModel>> getAllHistory() async {
    List<HistoryModel> histories = [];
    final data = await historyCollection.where("state", isEqualTo: 0).get();

    for(final document in data.docs){
      final result = document.data();
      result["id"] = document.id;
      histories.add(HistoryModel.fromJson(result));
    }

    return histories;
  }
  Future<void> duyetHistory(HistoryModel history, int i) async {

    historyCollection.doc(history.id).update(
      history.copyWith(state: i).toJson()
    );
  }

}
