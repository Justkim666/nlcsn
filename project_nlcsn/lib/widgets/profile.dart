import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_nlcsn/screens/history_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    final User? currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Container(
              color: Colors.white54,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const HomePage(),
                        //   ),
                        // );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        child: currentUser != null 
                            ? currentUser.photoURL != null
                              ? Image.network(currentUser.photoURL!)
                              : Image.asset("assets/images/avatar.jpg")
                            : Image.asset("assets/images/avatar.jpg"),
                      )
                    ],
                  ),
                  currentUser != null && currentUser.displayName != null
                      ? Text(currentUser.displayName!)
                      : Text("Ten: ??"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentUser != null ? Text(currentUser.email!) : Text("ban chua dang nhap")
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Expanded(
                        child: ListView(
                      children: [
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            leading: const Icon(
                              Icons.history,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Purchase History',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.black54,
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryPage()));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Card(
                            color: Colors.white70,
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              leading: const Icon(Icons.help_outline,
                                  color: Colors.black54),
                              title: const Text(
                                'Help & Support',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.privacy_tip_sharp,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.black54,
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
