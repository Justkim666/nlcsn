import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularMenu extends StatelessWidget {
  const PopularMenu({super.key});



  @override
  Widget build(BuildContext context) {

    double width = 55.0, height = 55.0;
    double customFontSize = 13;
    String defaultFontFamily = 'Roboto-Light.ttf';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,  color: Color(0xFFEBEBEE)),
                child: ClipOval(
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Image(image: AssetImage('assets/brand/nike.png'),),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                "Nike",
                style: TextStyle(
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFEBEBEE)),
                child: ClipOval(
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Image(image: AssetImage('assets/brand/puma.webp'),),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                "Puma",
                style: TextStyle(
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFEBEBEE)),
                child: ClipOval(
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Image(image: AssetImage('assets/brand/adidas.png'),),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                "Adidas",
                style: TextStyle(
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFEBEBEE)),
                child: ClipOval(
                  child: RawMaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Image(image: AssetImage('assets/brand/fila.png'),),
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                "Fila",
                style: TextStyle(
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              )
            ],
          )
        ],
      ),
    );
  }
}