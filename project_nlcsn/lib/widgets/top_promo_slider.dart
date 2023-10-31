import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopPromoSlider extends StatelessWidget {
  const TopPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {

    List<Widget> itemsSlider = [
      const Image(image: AssetImage('assets/discount/img1.jpg'), width: double.infinity, height: 140, fit: BoxFit.fill,),
      const Image(image: AssetImage('assets/discount/img2.jpg'),  width: double.infinity, height: 140,  fit: BoxFit.fill),
      const Image(image: AssetImage('assets/discount/img4.jpg'),  width: double.infinity, height: 140,  fit: BoxFit.fill),
      const Image(image: AssetImage('assets/discount/img3.webp'),  width: double.infinity, height: 140,  fit: BoxFit.fill),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        color: const Color(0xFFFFFFFF),
          height: 180.0,
          width: double.infinity,
          child: CarouselSlider(
              items: itemsSlider,
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              )
          )
      ),
    );
  }
}