// ignore: file_names
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
//import 'package:fastvai/Models/productsModel.dart';

import 'package:test_product/const.dart';
import 'package:test_product/model/productmodel.dart';

class ProductController extends GetxController {
  var productlist = <Product>[].obs;

  var isloading = true.obs;

  Future<dynamic> fetchProducts() async {
    isloading(true);

    var client = http.Client();

    var response = await client.get(Uri.parse(api.url));
    if (response.statusCode == 200) {
      var productList = productFromJson(response.body);

      if (productList != null) {
        productlist.clear();
        productlist.value = productList;
      }

      isloading(false);
    }
  }
}
