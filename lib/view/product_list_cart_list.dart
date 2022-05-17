

import 'package:flutter/material.dart';
import 'package:now_app_test/view/product_list.dart';

import 'cart_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(

          tabs: [
            Tab(
              text: "Product",
            ),
            Tab(
              text: "Cart",
            ),
          ],
        )),
        body: TabBarView(children: [
          Center(
            child: ProductDesign(),
          ),
          Center(
            child: CartItem(),
          ),
        ]),
      ),
    );
  }
}
