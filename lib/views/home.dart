import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product-controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final ProductController productcontroller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productcontroller.fetchProducts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: const Text(
            "Product",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: Colors.black),
            )
          ],
        ),
//body
        body: Obx(() {
          if (productcontroller.isloading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 5 / 6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: productcontroller.productlist.length,
                  itemBuilder: (context, index) {
                    //calculation
                    var saleprice = double.parse(
                        (productcontroller.productlist[index].price -
                                ((productcontroller.productlist[index].price /
                                        100) *
                                    26))
                            .toStringAsFixed(2));
                    return GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                              title: "Product Details",
                              content: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    width: 300,
                                    child: product(
                                        productcontroller
                                            .productlist[index].title,
                                        productcontroller
                                            .productlist[index].image,
                                        productcontroller
                                            .productlist[index].price
                                            .toString(),
                                        saleprice.toString(),
                                        productcontroller
                                            .productlist[index].rating.rate
                                            .toString(),
                                        productcontroller
                                            .productlist[index].rating.count
                                            .toString(),
                                        productcontroller
                                            .productlist[index].category
                                            .toString()),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(productcontroller
                                      .productlist[index].description)
                                ],
                              ));
                        },
                        child: product(
                            productcontroller.productlist[index].title,
                            productcontroller.productlist[index].image,
                            productcontroller.productlist[index].price
                                .toString(),
                            saleprice.toString(),
                            productcontroller.productlist[index].rating.rate
                                .toString(),
                            productcontroller.productlist[index].rating.count
                                .toString(),
                            productcontroller.productlist[index].category
                                .toString()));
                  }),
            );
          }
        }));
  }
}

Widget product(String title, String image, String price, String saleprice,
    String rating, String count, String category) {
  return Card(
    child: Column(
      children: [
        Image.network(image, height: 100, width: double.maxFinite),
        Flexible(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 5, right: 5, bottom: 5),
          child: Center(
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ),
        )),
        //price
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BDT $price",
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text("  BDT $saleprice")
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                category,
                style: const TextStyle(),
              ),
              Text(
                " $rating★",
                style: const TextStyle(),
              ),
            ]),
        Text(
          "Count:$count",
          style: const TextStyle(),
        ),
      ],
    ),
  );
}
