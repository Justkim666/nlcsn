import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../managers/cart_manager.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    CartManager cartManager = CartManager();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){setState(() {

        });},
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Text("History"),
        ),
        backgroundColor: const Color(0xFF00000A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: cartManager.getAllHistory(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("something went wrong"),);
            }

            if(snapshot.hasData){
              final data = snapshot.data;

              return ListView(
                children: [

                  for(final history in data!) ExpansionTile(
                    title: Text("Date ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(history.dateTime))}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        history.state == 0
                            ? const Text(" is waiting for approval", style: TextStyle(color: Colors.amber),)
                            : history.state == 1 ? const Text("Order is being delivered",style: TextStyle(color: Colors.green))
                              : const Text("Be rejected", style: TextStyle(color: Colors.red)),
                        Text("TOTAL: ${history.total}")
                      ],
                    ),
                    backgroundColor: Colors.grey.shade200,
                    collapsedBackgroundColor: Colors.white,
                    children: [
                      for(final prod in history.products!) Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text("name: ${prod.name}"),
                          subtitle: Text("Size: ${prod.sizes!.first}"),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
