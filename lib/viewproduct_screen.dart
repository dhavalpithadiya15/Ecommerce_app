import 'dart:convert';
import 'package:ecommerce_app/productdetail_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:ecommerce_app/updateproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  ViewProductData? objViewProductData;
  bool isload = false;
  int loadcnt = 0;
  List listOfProductData = [];
  int cnt = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forApi();
  }

  @override
  Widget build(BuildContext context) {
    return loadcnt == 0
        ? Scaffold()
        : loadcnt == 1
            ? Scaffold(
                body: Container(
                  padding: EdgeInsets.all(5),
                  child: AnimationLimiter(
                    key: ValueKey(objViewProductData!.productdata!.length),
                    child: GridView.builder(
                      itemCount: objViewProductData!.productdata!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.9, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen(
                                    listOfProductData, index, cnt);
                              },
                            ));
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: Text("Edit Product ! "),
                                  actions: [
                                    Column(
                                      children: [
                                        Container(
                                          child: TextButton(
                                            onPressed: () async {
                                              EasyLoading.show(
                                                  status: "Please wait...");
                                              Map deleteProduct = {
                                                "id": listOfProductData[index]
                                                    ['id']
                                              };
                                              var url = Uri.parse(
                                                  'https://dhaval1512.000webhostapp.com/ecommerce/deleteproduct.php');
                                              var response = await http.post(
                                                  url,
                                                  body: deleteProduct);
                                              print(
                                                  'Response status: ${response.statusCode}');
                                              print(
                                                  'Response body: ${response.body}');
                                              var apiDecode =
                                                  jsonDecode(response.body);
                                              DeleteProduct myDeleteProduct =
                                                  DeleteProduct.fromJson(
                                                      apiDecode);
                                              Navigator.pop(context);
                                              if (myDeleteProduct.connection ==
                                                  1) {
                                                if (myDeleteProduct.result ==
                                                    1) {
                                                  setState(() {
                                                    forApi();
                                                    EasyLoading.dismiss(
                                                        animation: false);
                                                  });
                                                }
                                              }
                                            },
                                            child: Text(
                                              "Delete Product",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return UpdateProductScreen(
                                                    listOfProductData,
                                                    index,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Text(
                                              "Update Product",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: listOfProductData.length,
                            duration: Duration(milliseconds: 400),
                            delay: Duration(milliseconds: 300),
                            child: ScaleAnimation(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                         child: Image.network( "https://dhaval1512.000webhostapp.com/ecommerce/${listOfProductData[index]['Product_image']}"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "${listOfProductData[index]['Product_name']}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "\u{20B9}${int.parse(
                                                    listOfProductData[index]
                                                            ['Product_price']
                                                        .toString(),
                                                  )}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : loadcnt == 2
                ? Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Lottie.asset("lottie/notfound2.json"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "No product hase been found !",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : Scaffold();
  }

  Future<void> forApi() async {
    EasyLoading.show(status: "Please wait...");
    Map viewData = {"userId": SplashScreen.prefs!.getString("userid")};
    print(viewData['userid']);
    var url = Uri.parse(
        'https://dhaval1512.000webhostapp.com/ecommerce/viewproduct.php');
    var response = await http.post(url, body: viewData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var apiDecode = jsonDecode(response.body);
    Map mm = apiDecode;
    print("+++++${mm}");
    objViewProductData = ViewProductData.fromJson(apiDecode);
    EasyLoading.dismiss(animation: false);
    if (objViewProductData!.result == 0) {
      setState(() {
        loadcnt = 2;
      });
    } else if (objViewProductData!.result == 1) {
      setState(() {
        loadcnt = 1;
      });
    }
    listOfProductData = mm['productdata'];
    listOfProductData.sort((a, b) => (int.parse(a['Product_price']))
        .compareTo(int.parse(b['Product_price'])));
  }
}

class ViewProductData {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  ViewProductData({this.connection, this.result, this.productdata});

  ViewProductData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? productName;
  String? productCat;
  String? productPrice;
  String? productDes;
  String? productImage;
  String? userId;

  Productdata(
      {this.id,
      this.productName,
      this.productCat,
      this.productPrice,
      this.productDes,
      this.productImage,
      this.userId});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['Product_name'];
    productCat = json['product_cat'];
    productPrice = json['Product_price'];
    productDes = json['Product_des'];
    productImage = json['Product_image'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Product_name'] = this.productName;
    data['product_cat'] = this.productCat;
    data['Product_price'] = this.productPrice;
    data['Product_des'] = this.productDes;
    data['Product_image'] = this.productImage;
    data['UserId'] = this.userId;
    return data;
  }
}

class DeleteProduct {
  int? connection;
  int? result;

  DeleteProduct({this.connection, this.result});

  DeleteProduct.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
