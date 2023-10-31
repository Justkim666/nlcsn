import 'product_model.dart';

class HistoryModel {
  final String userId;
  final String dateTime;
  final List<ProductModel>? products;
  final String total;
  final int state;
  final String id;

  HistoryModel({required this.userId, required this.id ,this.state = 0,required this.dateTime, required this.products, required this.total});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {

    final jsonProducts = json['products'] as List<dynamic>;

    return HistoryModel(
      id: json["id"],
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

  HistoryModel copyWith({
    String? userId, String? total, String? id,
    int? state, List<ProductModel>? products, String? dateTime
}){
    return HistoryModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        dateTime: dateTime ?? this.dateTime,
        products: products ?? this.products,
        state: state ?? this.state,
        total: total ?? this.total
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
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

