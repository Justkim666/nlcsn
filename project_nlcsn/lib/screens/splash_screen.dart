import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../services/font_size.dart';
import '../services/request_service.dart';
import 'home_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    getDataFromDatabase();
  }

  getDataFromDatabase() async {
    var data = await RequestService.getRequest(
        "https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json");

    if (data['success'] == false) {
      if (kDebugMode) {
        print('Error');
      }
    } else {
      var dataOne = data['data'];
      for (Map data in dataOne) {
        Product product = Product.fromSnapShot(data);
        listOfData.add(product);
      }
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const HomePage(),
          ),
              (route) => false, //if you want to disable back feature set to false
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/welcome.jpg'),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Kim's Store",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 27,
                        )),
                  ),
                ),
                const SizedBox(height: 140,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}