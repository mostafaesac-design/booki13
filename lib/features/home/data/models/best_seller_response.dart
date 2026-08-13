class BestSellerResponse {
  int? status;
  String? message;
  BestSellerData? data;

  BestSellerResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    final rawData = json['data'];
    data = rawData == null ? null : BestSellerData.fromJson(rawData);
  }
}

class BestSellerData {
  List<Product>? products;

  BestSellerData.fromJson(dynamic json) {
    final rawProducts = json is List ? json : json['products'];
    if (rawProducts is List) {
      products = [];
      for (final item in rawProducts) {
        if (item is Map<String, dynamic>) {
          products!.add(Product.fromJson(item));
        }
      }
    }
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  num? discount;
  num? priceAfterDiscount;
  int? stock;
  String? image;
  String? category;
  int? bestSeller;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.stock,
    this.image,
    this.category,
    this.bestSeller,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = _asInt(json['id'] ?? json['product_id'] ?? json['item_product_id']);
    name = (json['name'] ?? json['product_name'] ?? json['item_product_name'])
        ?.toString();
    description = (json['description'] ?? json['product_description'])
        ?.toString();
    price =
        (json['price'] ?? json['product_price'] ?? json['item_product_price'])
            ?.toString();
    discount = json['discount'];
    priceAfterDiscount =
        json['price_after_discount'] ??
        json['product_price_after_discount'] ??
        json['item_product_price_after_discount'];
    stock = _asInt(
      json['stock'] ?? json['product_stock'] ?? json['item_product_stock'],
    );
    image =
        (json['image'] ?? json['product_image'] ?? json['item_product_image'])
            ?.toString();
    category = (json['category'] ?? json['category_name'])?.toString();
    bestSeller = _asInt(json['best_seller']);
  }

  double get effectivePrice =>
      (priceAfterDiscount ?? num.tryParse(price ?? '') ?? 0).toDouble();

  static int? _asInt(dynamic value) =>
      value is int ? value : int.tryParse('$value');
}
