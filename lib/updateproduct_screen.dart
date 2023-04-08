import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_app/home_screen.dart';
import 'package:ecommerce_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateProductScreen extends StatefulWidget {
  List<dynamic> listOfProductData;
  int index;

  UpdateProductScreen(this.listOfProductData, this.index);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productName.text = widget.listOfProductData[widget.index]['Product_name'];
    productPrice.text = widget.listOfProductData[widget.index]['Product_price'];
    productDes.text = widget.listOfProductData[widget.index]['Product_des'];
    productName.text = widget.listOfProductData[widget.index]['Product_name'];
    selectedItem = widget.listOfProductData[widget.index]['product_cat'];
  }

  final ImagePicker picker = ImagePicker();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDes = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String imagePath = "";
  bool imageLoad = false;

  List categoryItem = [
    "Electric",
    "Clothing",
    "Footwear",
    "Books",
    "Fashion accessories",
  ];
  String selectedItem = "";

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Update Product",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageLoad
                    ? DottedBorder(
                        strokeWidth: 2,
                        dashPattern: [5],
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Center(
                                    child: Text(
                                      "Choose your image",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final XFile? photo =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  imagePath = photo!.path;
                                                  imageLoad = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final XFile? image =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  imagePath = image!.path;
                                                  imageLoad = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.image_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              "Gallery",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  File(imagePath),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : DottedBorder(
                        strokeWidth: 2,
                        dashPattern: [5],
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Center(
                                    child: Text(
                                      "Choose your image",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final XFile? photo =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {
                                                  imagePath = photo!.path;
                                                  imageLoad = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              "Camera",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                final XFile? image =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  imagePath = image!.path;
                                                  imageLoad = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.image_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Text(
                                              "Gallery",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://dhaval1512.000webhostapp.com/ecommerce/${widget.listOfProductData[widget.index]['Product_image']}"))),
                          ),
                        ),
                      ),
                SizedBox(
                  height: bodyHeight * 0.04,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Product name :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 0.02,
                ),
                TextFormField(
                  controller: productName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Enter product name",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill empty field";
                    }
                  },
                ),
                SizedBox(
                  height: bodyHeight * 0.04,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Select category of product :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                DropdownButtonFormField2(
                  value: selectedItem,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  hint: Text("Select category"),
                  items: categoryItem.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedItem = value.toString();
                    print("*******${selectedItem}");
                  },
                  onSaved: (newValue) {
                    selectedItem = newValue.toString();
                    print("====${selectedItem}");
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select category.';
                    }
                  },
                ),
                SizedBox(
                  height: bodyHeight * 0.04,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Product price :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 0.02,
                ),
                TextFormField(
                  controller: productPrice,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Enter price of product",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: bodyHeight * 0.04,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Product description :",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: bodyHeight * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: productDes,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Write something here...",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill empty field";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: bodyHeight * 0.02,
                ),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      List<int> bytearray = File(imagePath).readAsBytesSync();
                      String imagepathe = base64Encode(bytearray);
                      Map updateData = {
                        "update_product_id":
                            widget.listOfProductData[widget.index]['id'],
                        "update_product_name": productName.text,
                        "update_product_cat": selectedItem,
                        "update_product_price": productPrice.text,
                        "update_product_des": productDes.text,
                        "old_image": widget.listOfProductData[widget.index]['Product_image'],
                        "updated_img": imagepathe,
                      };
                      print("===${updateData}");
                      var url = Uri.parse(
                          'https://dhaval1512.000webhostapp.com/ecommerce/update.php');
                      var response = await http.post(url, body: updateData);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      var apiDecode = jsonDecode(response.body);
                      UpdateResponse ur = UpdateResponse.fromJson(apiDecode);
                      if (ur.connection == 1) {
                        if (ur.result == 1) {
                          setState(() {
                            HomeScreen.cnt==2;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {return HomeScreen();},
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xff0C21C1),
                    ),
                    child: Text(
                      "Update Product",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateResponse {
  int? connection;
  int? result;

  UpdateResponse({this.connection, this.result});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
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
