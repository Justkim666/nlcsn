class ProductModel {
  final String? id;
  final String? sku;
  final String? name;
  final String? brandName;
  final String? mainImage;
  final String? price;
  final int? quantity;
  final List<String>? sizes;
  final String? stockStatus;
  final String? colour;
  final String? description;

  ProductModel(
      {this.id,
        this.sku,
        this.name,
        this.brandName,
        this.mainImage,
        this.quantity,
        this.price,
        this.sizes,
        this.stockStatus,
        this.colour,
        this.description});

  ProductModel copyWith({
    String? id, String? sku, String? name, String? brandName, String? mainImage,
    String? price, int? quantity, List<String>? sizes, String? stockStatus,
    String? colour, String? description
  }){
    return ProductModel(
        id: id ?? this.id,
        sku: sku ?? this.sku,
        name: name ?? this.name,
        brandName: brandName ?? this.brandName,
        mainImage: mainImage ?? this.mainImage,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        stockStatus: stockStatus ?? this.stockStatus,
        colour: colour ?? this.colour,
        description: description ?? this.description
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? "",
      sku: json['sku'] ?? "",
      name: json['name'] ?? "",
      brandName: json['brandName'] ?? "",
      mainImage: json['mainImage'] ?? "",
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? "",
      sizes: json['sizes'].cast<String>() ?? [],
      stockStatus: json['stockStatus'] ?? "",
      colour: json['colour'] ?? "",
      description: json['description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    data['brandName'] = brandName;
    data['mainImage'] = mainImage;
    data['price'] = price;
    data['quantity'] = quantity;
    data['sizes'] = sizes;
    data['stockStatus'] = stockStatus;
    data['colour'] = colour;
    data['description'] = description;
    return data;
  }
}
