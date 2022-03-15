import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/sign_up_controller.dart';
import '/screens/login.dart';
import '/widgets/textformfiled_widget.dart';

import '../const/colors.dart';

class SignUpScreen extends StatelessWidget {
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
          key:controller.keyForm,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: size.width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)),
                  color:  mainColor,
                  gradient: LinearGradient(
                    colors: [ mainColor,mainColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),
              TextFormFiledWidget(
                icon: Icons.person,
                size: size,
                hintText: 'Full Name',
                onChanged: (val){
                  controller.userName = val;
                },
                validation: (val){
                  return controller.validationUserName(val);
                },
              ),
              TextFormFiledWidget(
                icon: Icons.email,
                size: size,
                top: 15.0,
                hintText: 'Email',
                onChanged: (val){
                  controller.email = val;
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
                          onPressed: (){
                            controller.stateShowPassword();
                          },
                        ),
                        prefixIcon: Icon(Icons.vpn_key,color: mainColor,),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                                color: Colors.transparent
                            )
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
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
              GestureDetector(
                onTap: () {
                  if(controller.keyForm.currentState!.validate()){
                    print('Yes');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: size.width / 5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [  Color(0xffc5cda9),  Color(0xffdfefd2)],
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
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.white , fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0,),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Already Have Account? "),
                  TextButton(onPressed: (){
                    Get.off(()=>LoginScreen());
                  }, child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color(0xff000000) //ابغا اخليه بولد
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