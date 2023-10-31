import 'package:flutter/material.dart';

class MySearch extends StatelessWidget {
  const MySearch({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchColtroller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.grey[600],
          ),
          child: TextField(
            controller: searchColtroller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              prefixIcon: const Icon(Icons.search),
              fillColor: const Color(0xFFF2F4F5),
              hintStyle: TextStyle(color: Colors.grey[600]),
              hintText: "What would your like to buy?",
            ),
            autofocus: false,
          )),
    );
  }
}