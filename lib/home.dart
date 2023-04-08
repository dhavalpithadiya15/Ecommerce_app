import 'dart:convert';

import 'package:ecommerce_app/productdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forApi();
  }

  AllProductData? allProductData;
  List listOfAllProductData=[];
  int cnt=0;
  int loadCnt=0;
  @override
  Widget build(BuildContext context) {
    return loadCnt==0?Scaffold():loadCnt==1
        ? Scaffold(
            body: Container(
              padding: EdgeInsets.all(5),
              child: AnimationLimiter(
                key: ValueKey(allProductData!.productdata!.length),
                child: GridView.builder(
                  itemCount: allProductData!.productdata!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(listOfAllProductData, index,cnt);
                          },
                        ));
                      },
                      child: AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: listOfAllProductData.length,
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
                                      decoration: BoxDecoration(
// color: Colors.blue.withOpacity(0.5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://dhaval1512.000webhostapp.com/ecommerce/${listOfAllProductData[index]['Product_image']}"),
                                        ),
                                      ),
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
                                              "${listOfAllProductData[index]['Product_name']}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "\u{20B9}${listOfAllProductData[index]['Product_price']}",
                                              style: TextStyle(fontSize: 13),
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
          ):loadCnt==2?
         Scaffold(
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
    ):Scaffold();
  }

  Future<void> forApi() async {
    EasyLoading.show(status: "Please wait...");
    var url = Uri.parse(
        'https://dhaval1512.000webhostapp.com/ecommerce/alldataselect.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    EasyLoading.dismiss(animation: false);
    var apiDecode = jsonDecode(response.body);
    Map mm = apiDecode;
    allProductData = AllProductData.fromJson(apiDecode);
    if (allProductData!.result == 0) {
      setState(() {
        loadCnt = 2;
      });
    } else if (allProductData!.result == 1) {
      setState(() {
        loadCnt = 1;
      });
    }
    listOfAllProductData = mm['productdata'];
    listOfAllProductData.sort((a, b) {return int.parse(a['Product_price']).compareTo(int.parse(b['Product_price']));
    },);

  }
}

class AllProductData {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  AllProductData({this.connection, this.result, this.productdata});

  AllProductData.fromJson(Map<String, dynamic> json) {
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
