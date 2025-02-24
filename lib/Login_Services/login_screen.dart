import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqflite/shared_preference/shared_preference.dart';
import 'package:flutter_sqflite/to_do_list_services/Home.dart';
import 'package:flutter_sqflite/Login_Services/sqflite_service.dart';
import 'package:flutter_sqflite/Login_Services/user_login_model.dart';
import 'custom_text_form_field_.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<UserLoginModel>? userList;
  UserLoginModel? userLoginModel = UserLoginModel(1, "");
  int count = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.6,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 100,
                            right: 150,
                            child: ClipOval(
                              child: Container(
                                height: 400,
                                width: 400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 200,
                            left: 160,
                            child: ClipOval(
                              child: Container(
                                height: 300,
                                width: 300,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextFormFieldWidget(
                            controller: emailController,
                            borderColor: Colors.blue,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.blue,
                            enabledColor: Colors.blue,
                            hintText: "email",
                            enabled: true,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            iconColor: Colors.blue,
                            obscure: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(r'[ ]'),
                              ),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter email";
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value.trim())) {
                                return "Enter Valid email";
                              }
                              return null;
                            },
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.blue,
                            ),
                          ),CustomTextFormFieldWidget(
                            controller: passController,
                            borderColor: Colors.blue,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.blue,
                            enabledColor: Colors.blue,
                            hintText: "password",
                            enabled: true,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            iconColor: Colors.blue,
                            obscure: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(r'[ ]'),
                              ),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              } else if (value.length < 8) {
                                return "Enter Valid Password";
                              }
                              return null;
                            },
                            suffixIcon: const Icon(
                              Icons.password,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                                key: const Key('login_button'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () async {
                                  userLoginModel!.id = 0;
                                  // userLoginModel!.username =
                                  //     emailController.text;

                                  addUser(emailController.text!.toString(),passController.text.toString(),
                                      context);
                                  setState(() {});
                                },
                                child: isLoading == true
                                    ? Container(
                                        width: 25,
                                        height: 25,
                                        child: const CircularProgressIndicator(
                                          color: Colors.green,
                                        ))
                                    : const Text(
                                        "Login In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                          ),
                          // Container(
                          //   height: 200,
                          //   child: ListView.builder(
                          //     itemCount: userList!.length,shrinkWrap: true
                          //     ,itemBuilder: (context, index){
                          //       return ListTile(
                          //         title: Text("${userList![index].username}"),
                          //         leading: Text("${userList![index].id}"),
                          //       trailing: IconButton(onPressed: ()async{
                          //         delete(context,userList![index].id!);
                          //       }, icon: const Icon(Icons.delete))
                          //       );
                          //
                          //     }),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void updateListView() {
  //   final Future dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     Future<List<UserLoginModel>> userListFuture =
  //         databaseHelper.getUserList();
  //     userListFuture.then((userList) {
  //       setState(() {
  //         this.userList = userList;
  //         count = userList.length;
  //
  //       });
  //     });
  //   });
  // }

  // void delete(BuildContext context, int id) async {
  //   int result = await databaseHelper.deleteUser(id);
  //   if (result != 0) {
  //     const SnackBar(
  //       content: Text("User Deleted Successfully"),
  //     );
  //     updateListView();
  //   }
  // }

  void addUser(String email, String password, BuildContext context) async {
    isLoading = true;
    setState(() {});
    if (email != "" && password != "") {
      SharedPreferenceClass pref = SharedPreferenceClass();
      String prefEmail = await pref.getEmail() ?? "";
      String prefPassword = await pref.getPassword() ?? "";
      if (prefEmail == "" && prefPassword == "") {
        pref.saveEmail(email);
        pref.savePassword(password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  HomeView(email: email,)));
        const SnackBar(content: Text("Login Successfully"));
      } else {
        if (email == prefEmail && password == prefPassword) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeView(email: email,)));
          const SnackBar(content: Text("Login Successfully"));
        } else {
          pref.saveEmail(email);
          pref.savePassword(password);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>  HomeView(email: email,)));
          const SnackBar(content: Text("Login Successfully"));
        }
      }
      pref.saveIsLogin(true);
    }
    isLoading = false;
    setState(() {});
  }
}
