import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/addcart_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/home_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:ecommerce_app/viewproduct_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  List<dynamic> listOfAllProductData;
  int index;
  int cnt;

  ProductDetailScreen(this.listOfAllProductData, this.index, this.cnt);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool likeOnTap = false;
  String checkId = "";
  Razorpay? razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay=Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('payment Sucess')));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('payment fail please try again')));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }


  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight =
        totalHeight - statusbarHeight - kBottomNavigationBarHeight;
    return widget.cnt == 0
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ));
                    setState(() {
                      HomeScreen.cnt = 0;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 35,
                  ),
                  color: Colors.black),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "Product Detail",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: ListView(
                      children: [
                        Container(
                          // color: Colors.blue.withOpacity(0.4),
                          height: bodyHeight * 0.35,
                          width: totalWidth,
                          child: Card(
                            elevation: 8,
                            child: Image.network(
                                "https://dhaval1512.000webhostapp.com/ecommerce/${widget.listOfAllProductData[widget.index]['Product_image']}"),
                          ),
                        ),
                        SizedBox(
                          height: bodyHeight * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.listOfAllProductData[widget.index]['Product_name']}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Price: ${widget.listOfAllProductData[widget.index]['Product_price']}/-",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: bodyHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Details :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Drop a Like",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                ),
                                likeOnTap
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            likeOnTap = false;
                                          });
                                        },
                                        icon: Icon(
                                          CupertinoIcons.heart_fill,
                                          size: 20,
                                          color: Colors.pink,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            likeOnTap = true;
                                          });
                                        },
                                        icon: Icon(
                                          CupertinoIcons.heart,
                                          size: 20,
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: bodyHeight * 0.01,
                        ),
                        Container(
                          // color: Colors.green.withOpacity(0.5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                  ),
                                  SizedBox(
                                    width: totalWidth * 0.015,
                                  ),
                                  Container(
                                    // color: Colors.blue.withOpacity(0.5),
                                    width: totalWidth * 0.40,
                                    // color: Colors.blue.withOpacity(0.5),
                                    child: Text(
                                      "Name :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.orange.withOpacity(0.5),
                                    width: totalWidth * 0.46,
                                    child: Text(
                                      "${widget.listOfAllProductData[widget.index]['Product_name']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10,
                              ),
                              SizedBox(
                                height: bodyHeight * 0.01,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                  ),
                                  SizedBox(
                                    width: totalWidth * 0.015,
                                  ),
                                  Container(
                                    width: totalWidth * 0.40,
                                    child: Text(
                                      "Price :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: totalWidth * 0.46,
                                    child: Text(
                                      "${widget.listOfAllProductData[widget.index]['Product_price']}/-",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10,
                              ),
                              SizedBox(
                                height: bodyHeight * 0.01,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                  ),
                                  SizedBox(
                                    width: totalWidth * 0.015,
                                  ),
                                  Container(
                                    width: totalWidth * 0.4,
                                    child: Text(
                                      "Category :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: totalWidth * 0.46,
                                    child: Text(
                                      "${widget.listOfAllProductData[widget.index]['product_cat']}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: bodyHeight * 0.02,
                        ),
                        Text(
                          "Description :",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: bodyHeight * 0.01,
                        ),
                        Container(
                          width: totalWidth,
                          child: Text(
                            "${widget.listOfAllProductData[widget.index]['Product_des']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: bodyHeight * 0.09,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Row(
                      children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          EasyLoading.show(status: "Please wait...");
                          Map addcart = {
                            "userid":SplashScreen.prefs!.getString("userid"),
                            "product_added_to_cart_id": widget.listOfAllProductData[widget.index]['id'],
                            "product_added_to_cart_name": widget.listOfAllProductData[widget.index]['Product_name'],
                            "product_added_to_cart_cat": widget.listOfAllProductData[widget.index]['product_cat'],
                            "product_added_to_cart_price": widget.listOfAllProductData[widget.index]['Product_price'],
                            "product_added_to_cart_des": widget.listOfAllProductData[widget.index]['Product_des'],
                            "product_added_to_cart_image": widget.listOfAllProductData[widget.index]['Product_image'],
                          };
                          print(addcart);
                          var url = Uri.parse(
                              'https://dhaval1512.000webhostapp.com/ecommerce/addcart.php');
                          var response = await http.post(url, body: addcart);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          var apiDecode= jsonDecode(response.body);
                          AddCart addCart=AddCart.fromJson(apiDecode);
                          if(addCart.connected==1){
                            if(addCart.result==1){
                              EasyLoading.showSuccess("Added to cart");
                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                             //   return AddCartScreen();
                             // },));
                            }else if(addCart.result==2){
                              EasyLoading.showToast( "Product already exist in cart" ,duration: Duration(seconds: 2));
                            }
                          }

                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C21C1),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                     VerticalDivider(color: Colors.black,indent: 5,endIndent: 5,),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: ()async{
                                EasyLoading.showToast('Loading');
                                var options = {
                                  'key': 'rzp_test_bfjpkcyVGe1Wqy',
                                  'amount':int.parse( widget.listOfAllProductData[widget.index]['Product_price'])*100,
                                  'name': widget.listOfAllProductData[widget.index]['Product_name'],
                                  'description': widget.listOfAllProductData[widget.index]['Product_des'],
                                  'prefill': {
                                    'contact': '8888888888',
                                    'email': 'test@razorpay.com'
                                  }
                                };
                                try{
                                  razorpay!.open(options);
                                  EasyLoading.dismiss();
                                }catch(e){

                                  print(e);
                                }
                              },
                              child: Text("Buy now",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )
        : widget.cnt == 1
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                        setState(() {
                          HomeScreen.cnt = 0;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 35,
                      ),
                      color: Colors.black),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: Text(
                    "Product Detail",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ListView(
                          children: [
                            Container(
                              // color: Colors.blue.withOpacity(0.4),
                              height: bodyHeight * 0.35,
                              width: totalWidth,
                              child: Card(
                                elevation: 8,
                                child: Image.network(
                                    "https://dhaval1512.000webhostapp.com/ecommerce/${widget.listOfAllProductData[widget.index]['Product_image']}"),
                              ),
                            ),
                            SizedBox(
                              height: bodyHeight * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.listOfAllProductData[widget.index]['Product_name']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Price: ${widget.listOfAllProductData[widget.index]['Product_price']}/-",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: bodyHeight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Details :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Drop a Like",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                    likeOnTap
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                likeOnTap = false;
                                              });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.heart_fill,
                                              size: 20,
                                              color: Colors.pink,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                likeOnTap = true;
                                              });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.heart,
                                              size: 20,
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: bodyHeight * 0.01,
                            ),
                            Container(
                              // color: Colors.green.withOpacity(0.5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                      ),
                                      SizedBox(
                                        width: totalWidth * 0.015,
                                      ),
                                      Container(
                                        // color: Colors.blue.withOpacity(0.5),
                                        width: totalWidth * 0.40,
                                        // color: Colors.blue.withOpacity(0.5),
                                        child: Text(
                                          "Name :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.orange.withOpacity(0.5),
                                        width: totalWidth * 0.46,
                                        child: Text(
                                          "${widget.listOfAllProductData[widget.index]['Product_name']}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  SizedBox(
                                    height: bodyHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                      ),
                                      SizedBox(
                                        width: totalWidth * 0.015,
                                      ),
                                      Container(
                                        width: totalWidth * 0.40,
                                        child: Text(
                                          "Price :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: totalWidth * 0.46,
                                        child: Text(
                                          "${widget.listOfAllProductData[widget.index]['Product_price']}/-",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  SizedBox(
                                    height: bodyHeight * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                      ),
                                      SizedBox(
                                        width: totalWidth * 0.015,
                                      ),
                                      Container(
                                        width: totalWidth * 0.4,
                                        child: Text(
                                          "Category :",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: totalWidth * 0.46,
                                        child: Text(
                                          "${widget.listOfAllProductData[widget.index]['product_cat']}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: bodyHeight * 0.02,
                            ),
                            Text(
                              "Description :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: bodyHeight * 0.01,
                            ),
                            Container(
                              width: totalWidth,
                              child: Text(
                                "${widget.listOfAllProductData[widget.index]['Product_des']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold();
  }
}

class AddCart {
  int? connected;
  int? result;

  AddCart({this.connected, this.result});

  AddCart.fromJson(Map<String, dynamic> json) {
    connected = json['connected'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connected'] = this.connected;
    data['result'] = this.result;
    return data;
  }
}
