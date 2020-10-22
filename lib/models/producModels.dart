import 'dart:convert';

import 'package:yommie/provider/rest.dart';

class ProductModels {
  Future<List<Product>> productPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "product.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final jsonResponse = json.decode(response);
        List<Product> listProduct = [];
        for (var u in jsonResponse) {
          Product item = Product(u["product_id"], u["product_code"],
              u["product_name"], u["price_normal"], u["point"], u["photo"]);
          listProduct.add(item);
        }
        return listProduct;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class Product {
  Product(
    this.productId,
    this.productCode,
    this.productName,
    this.priceNormal,
    this.point,
    this.photo,
  );

  String productId;
  String productCode;
  String productName;
  String priceNormal;
  String point;
  String photo;
}
