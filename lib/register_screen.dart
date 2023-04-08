import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode fieldOne = FocusNode();
  FocusNode fieldTwo = FocusNode();
  FocusNode fieldThree = FocusNode();
  FocusNode fieldFour = FocusNode();
  final ImagePicker picker = ImagePicker();
  String imagePath = "";
  bool imageLoad = false;
  bool seePassword = true;
  String phoneRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = totalHeight - statusbarHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    // color: Colors.blue.withOpacity(0.5),
                    width: double.infinity,
                    child: Text(
                      "D-Shop",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color(0xff0C21C1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.08,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.025,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "If you already have account register",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                "You can ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return LoginScreen();
                                    },
                                  ));
                                },
                                child: Text(
                                  "Login here !",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0C21C1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  Container(
                    child: Stack(
                      children: [
                        imageLoad
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(File(imagePath)),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage("images/profile.png"),
                              ),
                        Positioned(
                          bottom: 0,
                          right: -26,
                          child: RawMaterialButton(
                            onPressed: () {
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
                                                          source: ImageSource
                                                              .camera);
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
                            elevation: 2.0,
                            fillColor: Color(0xFFF5F6F9),
                            child: Icon(Icons.camera_alt_outlined,
                                color: Colors.black),
                            padding: EdgeInsets.all(1),
                            shape: CircleBorder(),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        hintText: "Enter your name",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill empty field";
                        } else if (!RegExp('[a-zA-z]').hasMatch(value)) {
                          return "Please enter valid text";
                        }
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldTwo);
                      },
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Phone number",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      focusNode: fieldTwo,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: numberController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        hintText: "Enter your phone number",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill empty field";
                        } else if (!RegExp(phoneRegex).hasMatch(value)) {
                          return "Enter valid phone number";
                        }
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldThree);
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      focusNode: fieldThree,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        hintText: "Enter your email address",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill empty field";
                        } else if (!EmailValidator.validate(value)) {
                          return "Please enter valid email";
                        }
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldFour);
                      },
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Create password",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      obscureText: seePassword,
                      focusNode: fieldFour,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (seePassword) {
                                seePassword = false;
                              } else if (!seePassword) {
                                seePassword = true;
                              }
                            });
                          },
                          icon: seePassword
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please fill empty field";
                        } else if (value.length <= 7) {
                          return "Must contain 8 letter";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: bodyHeight * 0.05,
                  ),
                  InkWell(
                    onTap: () async {
                      if (imagePath.isEmpty &&
                          formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select Image"),
                          ),
                        );
                      } else if (formKey.currentState!.validate()) {
                        EasyLoading.show(status: "Please wait...");
                        List<int> byteArrayImage =
                            File(imagePath).readAsBytesSync();
                        String encodeImage = base64Encode(byteArrayImage);
                        Map registerData = {
                          "mapName": nameController.text,
                          "mapNumber": numberController.text,
                          "mapEmail": emailController.text,
                          "mapPassword": passwordController.text,
                          "mapImage": encodeImage,
                        };

                        var url = Uri.parse(
                            'https://dhaval1512.000webhostapp.com/ecommerce/ecommercefile.php');
                        var response = await http.post(url, body: registerData);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var decodingApi = jsonDecode(response.body);
                        RegisterData objRegisterData =
                            RegisterData.fromJson(decodingApi);
                        EasyLoading.dismiss(animation: false);
                        if (objRegisterData.connected == 1) {
                          if (objRegisterData.result == 1) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  actions: [
                                    Lottie.asset("lottie/registersucess.json",
                                        repeat: false)
                                  ],
                                );
                              },
                            );
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ));
                            });
                          } else if (objRegisterData.result == 2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User already exist"),
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
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterData {
  int? connected;
  int? result;

  RegisterData({this.connected, this.result});

  RegisterData.fromJson(Map<String, dynamic> json) {
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
