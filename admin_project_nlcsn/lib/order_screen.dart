import 'package:admin_project_nlcsn/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './managers/history_manager.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  final HistoryManger historyManger = HistoryManger();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });
        },
        child: const Icon(Icons.refresh),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Text('Orders'),
        ),
        backgroundColor: const Color(0xFF00000A),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: FutureBuilder(
        future: historyManger.getAllHistory(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"));
          }
          if(snapshot.hasData){
            final listHistory = snapshot.data;
            if(listHistory!.isEmpty){
              return const Center(child: Text("No Orders Found!"),);
            } else {
              return ListView(
              children: [
                for(final history in listHistory!) Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    decoration: const BoxDecoration(color: Colors.green),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Accept", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    decoration: const BoxDecoration(color: Colors.red),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                      historyManger.duyetHistory(history, 2)
                      .then((value) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Cancel an order successfully"), backgroundColor: Colors.orangeAccent,)
                        );
                      });
                    }

                    if(direction == DismissDirection.startToEnd){
                      historyManger.duyetHistory(history, 1)
                          .then((value){
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Order is being delivered"), backgroundColor: Colors.green,)
                        );
                      });
                    }
                  },
                  child: ExpansionTile(
                    title: Text(DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(history.dateTime))),
                      subtitle: Text(history.total),
                    children: [
                      // for(final product in history.products!) ListTile(
                      //   title: Text(product.name!),
                      //   subtitle: Text(product.sizes!.first),
                      //   onTap: ,
                      // )
                      for(final product in history.products!) Product(product: product)
                    ],
                  ),
                )
              ],
            );
            }
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
