import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_saja/screens/reset_password.dart';
import 'mainpage.dart';
import '/screens/signup.dart';

import '../const/colors.dart';
import '../controller/login_controller.dart';
import '../widgets/textformfiled_widget.dart';
//done

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
          key: controller.keyForm,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: size.width / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90)),
                    /*color:  Color(0xff0E5E5A)*/
                    color: Colors.blueGrey
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
              TextFormFiledWidget(
                hintText:  "Enter Email",
                icon: Icons.email,
                size: size,
                onChanged: (val){
                  controller.email.value = val;
                },
                validation: (val){
                  return controller.validationEmail(val);
                },
              ),
              Obx(
                      ()=> Container(
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 15
                    ),
                    child: TextFormField(

                      onChanged: (val){
                        controller.passWord.value = val;
                      },
                      validator: (val){
                        return controller.validationPassword(val!);
                      },
                      obscureText: controller.isShow.value,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                              controller.isShow.value
                                  ?Icons.visibility_off_sharp
                                  :Icons.visibility
                          ),
                          color: Colors.grey,
                          onPressed: (){
                            controller.stateShowPassword();
                          },
                        ),
                        prefixIcon: Icon(Icons.vpn_key,color: mainColor,),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                                color: Colors.transparent
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                                color: Colors.transparent
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                                color: Colors.transparent
                            )
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){

                          //ToDo Go To ForgetPassword Scrren
                          Get.to(()=>ResetPasswordScreen());
                        },
                        child: Text("Forget Password?",style: TextStyle(
                            color: Colors.black
                        ),)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async{

                  if(controller.keyForm.currentState!.validate()){
                    Get.snackbar("Logged in Successfully", "",
                        showProgressIndicator: true
                    ) ;
                    await controller.login(
                        email: controller.email.value,
                        password: controller.passWord.value
                    );

                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:
                  20, right: 20, top: size.width / 5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: size.width / 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ Colors.blueGrey, Colors.blueGrey],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                    ),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white ,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0,),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Don't Have Any Account? "),
                  TextButton(onPressed: (){

                    Get.off(()=>SignUpScreen());
                  }, child: Text(
                    "Register Now",
                    style: TextStyle(
                        color: Color(0xff000000)
                        , fontWeight: FontWeight.bold
                    ),
                  ))
                ],
              )
            ],
          ),
        )
    );
  }

}