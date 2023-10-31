
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import '../componennts_login_signup/custom_form_button.dart';
import '../componennts_login_signup/custom_input_field.dart';
import '../componennts_login_signup/page_heading.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  // File? _profileImage;

  final _signupFormKey = GlobalKey<FormState>();

  // Future _pickProfileImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //
  //     final imageTemporary = File(image.path);
  //     setState(() => _profileImage = imageTemporary);
  //   } on PlatformException catch (e) {
  //     debugPrint('Failed to pick image error: $e');
  //   }
  // }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: size.height * 0.1,
                      ),
                      const PageHeading(title: 'Sign-up',),
                      const SizedBox(height: 40,),
                      const SizedBox(height: 16,),
                      CustomInputField(
                          labelText: 'Name',
                          controller: nameController,
                          hintText: 'Your name',
                          isDense: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Name field is required!';
                            }
                            return null;
                          }
                      ),
                      const SizedBox(height: 16,),
                      CustomInputField(
                          labelText: 'Email',
                          controller: emailController,
                          hintText: 'Your email id',
                          isDense: true,
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
                        isDense: true,
                        obscureText: true,
                        validator: (textValue) {
                          if(textValue == null || textValue.isEmpty) {
                            return 'Password is required!';
                          }
                          return null;
                        },
                        suffixIcon: true,
                      ),
                      const SizedBox(height: 22,),
                      CustomFormButton(innerText: 'Signup', onPressed: _handleSignupUser,),
                      const SizedBox(height: 18,),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context)
                              },
                              child: const Text('Log-in', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 220,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignupUser() async {
    // signup user
    if (_signupFormKey.currentState!.validate()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passWordController.text
      ).then((value){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create account successfully')),
        );
        value.user!.updateDisplayName(nameController.text);
        Navigator.pop(context);
      });
    }
  }
}