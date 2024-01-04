import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_model.dart';
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/db_helper.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

DBHelper? dbHelper = DBHelper();

class _ProductListState extends State<ProductList> {
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
 List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1722111529/display_1500/stock-photo-bunch-of-bananas-isolated-on-white-background-with-clipping-path-and-full-depth-of-field-1722111529.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2090063473/display_1500/stock-photo-cherry-isolated-sour-cherries-with-leaf-on-white-background-sour-cherri-on-white-full-depth-of-2090063473.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1550458292/display_1500/stock-photo-peach-isolate-peach-slice-peach-with-leaf-on-white-background-full-depth-of-field-with-clipping-1550458292.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2150285297/display_1500/stock-photo-apples-pear-banana-orange-kiwi-pineapple-collage-mix-fruit-marshmallow-dried-fruits-packaging-2150285297.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Product List')), actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getcounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              badgeAnimation: badges.BadgeAnimation.scale(),
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ]),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image(
                                    image: NetworkImage(productImage[index]),
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(productName[index].toString()),
                                        SizedBox(height: 10),
                                        Text(
                                          productUnit[index].toString() +
                                              " " +
                                              r"$" +
                                              productPrice[index].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              dbHelper!
                                                  .insert(Cart(
                                                      id: index,
                                                      productId:
                                                          index.toString(),
                                                      productName:
                                                          productName[index]
                                                              .toString(),
                                                      initialPrice:
                                                          productPrice[index],
                                                      productPrice:
                                                          productPrice[index],
                                                      quantity: 1,
                                                      unitTag:
                                                          productUnit[index]
                                                              .toString(),
                                                      image: productImage[index]
                                                          .toString()))
                                                  .then((value) {
                                                print(
                                                    'Product is added to cart');

                                                cart.addTotalPrice(double.parse(
                                                    productPrice[index]
                                                        .toString()));

                                                cart.addCounter();
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text('Add to cart',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ]),
                    ),
                  );
                }),
          )
        ]));
  }
}
