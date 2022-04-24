
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
                    color: Colors.blueGrey
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
                  controller.myUserName.value = val;
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
                  controller.myEmail.value = val;
                },
                validation: (val){
                  return controller.validationEmail(val);
                },
              ),
              TextFormFiledWidget(
                icon: Icons.phone,
                size: size,
                top: 15.0,
                hintText: 'Phone Number',
                onChanged: (val){
                  controller.myPhoneNumber.value = val;
                },
                validation: (val){
                  return controller.validationNumberPhone(val);
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
                        controller.myPassWord.value = val;
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
                    controller.register(
                        email: controller.myEmail.value,
                        password: controller.myPassWord.value,
                        name: controller.myUserName.value,
                        phone: controller.myPhoneNumber.value,
                        context: context
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: size.width / 5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [  Colors.blueGrey, Colors.blueGrey],
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