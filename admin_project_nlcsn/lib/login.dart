


import 'package:admin_project_nlcsn/order_screen.dart';
import 'package:admin_project_nlcsn/pageheading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'custom_form_button.dart';
import 'custom_input_field.dart';

import './managers/login_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final LoginManger loginManger = LoginManger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Log-In',),
                        const SizedBox(height: 40,),
                        CustomInputField(
                            labelText: 'Email',
                            controller: emailController,
                            hintText: 'Your email id',
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if(!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 16,),
                        CustomInputField(
                          labelText: 'Password',
                          controller: passWordController,
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginUser() async {
    // login user
    // if (_loginFormKey.currentState!.validate()) {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: emailController.text,
    //       password: passWordController.text
    //   ).then((value) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Dang nhap thanh cong')),
    //     );
    //     Navigator.pop(context);
    //   });
    // }
    if(_loginFormKey.currentState!.validate()){
      final success = await loginManger.loginWithEmailPassWord(email: emailController.text, pass: passWordController.text);

      if(success){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Order() ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dang nhap khong thanh cong")));
      }



    }
  }
}