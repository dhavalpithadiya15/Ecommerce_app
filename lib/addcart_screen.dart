import 'dart:convert';

import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class AddCartScreen extends StatefulWidget {
  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  ViewProductAddedCart? viewProductAddedCart;
  bool isLoad = false;
  int loadCnt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forApi();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return loadCnt == 0
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : loadCnt == 1
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      setState(() {
                        HomeScreen.cnt = 0;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    "Cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          // color: Colors.blue.withOpacity(0.5),
                          ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        // color: Colors.red.withOpacity(0.5),
                        child: Lottie.asset("lottie/empty_cart.json"),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "Your cart is Empty !",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              child: Text(
                                textAlign: TextAlign.center,
                                "Looks like you have not added anything to your cart.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        // color: Colors.pink.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              )
            : loadCnt == 2
                ? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              HomeScreen.cnt = 0;
                            },
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      title: Text(
                        "Cart",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewProductAddedCart!
                                .addedcartproductdata!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // color: Colors.blue.withOpacity(0.5),
                                height: bodyHeight * 0.25,
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            height: bodyHeight * 0.2,
                                            width: totalWidth * 0.3,
                                            decoration: BoxDecoration(
                                              backgroundBlendMode:
                                                  BlendMode.clear,
                                              color: Colors.yellow,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://dhaval1512.000webhostapp.com/ecommerce/${viewProductAddedCart!.addedcartproductdata![index].productImage}")),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: bodyHeight * 0.22,
                                              // color: Colors.blue.withOpacity(0.5),
                                              width: totalWidth * 0.62,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      "${viewProductAddedCart!.addedcartproductdata![index].productName}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${viewProductAddedCart!.addedcartproductdata![index].productCat}",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: bodyHeight * 0.01,
                                                  ),
                                                  Text(
                                                    "Price :${viewProductAddedCart!.addedcartproductdata![index].productPrice}/-",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  )
                : Scaffold();
  }

  Future<void> forApi() async {
    EasyLoading.show(status: "Please Wait...");
    Map viewAddedCartData = {"userId": SplashScreen.prefs!.getString("userid")};
    var url = Uri.parse(
        'https://dhaval1512.000webhostapp.com/ecommerce/addedcartproductdata.php');
    var response = await http.post(url, body: viewAddedCartData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var apiDecode = jsonDecode(response.body);
    viewProductAddedCart = ViewProductAddedCart.fromJson(apiDecode);
    EasyLoading.dismiss(animation: false);

    if (viewProductAddedCart!.result == 1) {
      setState(() {
        loadCnt = 2;
      });
    }
    if (viewProductAddedCart!.result == 0) {
      setState(() {
        loadCnt = 1;
      });
    }
  }
}

class ViewProductAddedCart {
  int? connection;
  int? result;
  List<Addedcartproductdata>? addedcartproductdata;

  ViewProductAddedCart(
      {this.connection, this.result, this.addedcartproductdata});

  ViewProductAddedCart.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['addedcartproductdata'] != null) {
      addedcartproductdata = <Addedcartproductdata>[];
      json['addedcartproductdata'].forEach((v) {
        addedcartproductdata!.add(new Addedcartproductdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.addedcartproductdata != null) {
      data['addedcartproductdata'] =
          this.addedcartproductdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addedcartproductdata {
  String? id;
  String? productId;
  String? productName;
  String? productPrice;
  String? productCat;
  String? productDes;
  String? productImage;
  String? userid;

  Addedcartproductdata(
      {this.id,
      this.productId,
      this.productName,
      this.productPrice,
      this.productCat,
      this.productDes,
      this.productImage,
      this.userid});

  Addedcartproductdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productCat = json['product_cat'];
    productDes = json['product_des'];
    productImage = json['product_image'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_cat'] = this.productCat;
    data['product_des'] = this.productDes;
    data['product_image'] = this.productImage;
    data['userid'] = this.userid;
    return data;
  }
}
