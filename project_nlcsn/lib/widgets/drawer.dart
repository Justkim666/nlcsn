import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_nlcsn/constants.dart';
import 'package:project_nlcsn/widgets/profile.dart';

import '../screens/home_page.dart';
import '../screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createDrawerHeader(),
            const Divider(
              height: 10,
              color: Colors.grey,
            ),
            _createDrawerItem(
                icon: Icons.home,
                text: 'Home',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                )
            ),
            _createDrawerItem(
                icon: Icons.person,
                text: 'Acount',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Profile()),
                )
                // onTap: (){
                //   // context.read<PageIndexProvider>().navigateToIndex(3);
                // }
            ),
            _createDrawerItem(
                icon: Icons.call,
                text: 'Contact Us',
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => EmptyWishListScreen()),
                // )
                onTap: (){}
            ),
            _createDrawerItem(
                icon: FontAwesomeIcons.user,
                text: 'Sign In',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                )
            ),
            _createDrawerItem(
                icon: FontAwesomeIcons.signOut,
                text: 'Sign Out',
                onTap: (){
                  FirebaseAuth.instance.signOut().then((value) {
                    listOfCart.clear();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You quit")));
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerHeader() {
  return const DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/brand/side.jpg'),
                maxRadius: 80,
              )
            ]
            ),
          ),
        ],
      ),
  );
}

Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          //0xFF808080
          color: text == 'Sign Out' ? Colors.red : const Color(0xFF808080),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: text == 'Sign Out' ? Colors.red : const Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}