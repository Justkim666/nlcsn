import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_nlcsn/screens/signup.dart';

import '../componennts_login_signup/custom_form_button.dart';
import '../componennts_login_signup/custom_input_field.dart';
import '../componennts_login_signup/forget_page.dart';
import '../componennts_login_signup/page_heading.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.home, size: 40.0,)
                              )
                            ],
                          ),
                        ),
                        const PageHeading(title: 'Log-in',),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
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
                        const SizedBox(height: 18,),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                              TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupPage()));
                                  },
                                  child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
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
    if (_loginFormKey.currentState!.validate()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passWordController.text
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successfully')),
        );
        Navigator.pop(context);
      });
    }
  }
}