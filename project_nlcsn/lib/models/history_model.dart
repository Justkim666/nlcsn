import 'product_model.dart';

class HistoryModel {
  final String userId;
  final String dateTime;
  final List<ProductModel>? products;
  final String total;
  final int state;

  HistoryModel({required this.userId, this.state = 0,required this.dateTime, required this.products, required this.total});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {

    final jsonProducts = json['products'] as List<dynamic>;

    return HistoryModel(
        userId : json['userId'],
        dateTime : json['dateTime'],
        products: jsonProducts.map((element) {
          final product = element as Map<String, dynamic>;
              return ProductModel.fromJson(product);
        }).toList(),
    state: json["state"],
    total : json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['dateTime'] = dateTime;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['state'] = state;
    data['total'] = total;
    return data;
  }
}

