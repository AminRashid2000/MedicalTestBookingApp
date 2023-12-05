import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Models/cartmodel.dart';


class TestDtCard extends StatefulWidget {
  String? testName;
  String? price;
  String? offerprice;
  String? id;
  bool isaddedtocart = false;


  List<QueryDocumentSnapshot> data = [];

  TestDtCard({
    super.key,
    this.testName,
    this.price,
    this.offerprice,
    this.id,
    this.isaddedtocart = false
  });

  @override
  State<TestDtCard> createState() => _TestDtCardState();
}

class _TestDtCardState extends State<TestDtCard> {
  @override
  void initState() {
    // TODO: implement initState
    Future<List<QueryDocumentSnapshot>> getdata() async {
      //isoLading = true;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("cart").get();
      List<QueryDocumentSnapshot> doclist = snapshot.docs;
      widget.data = doclist;
      return doclist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      tophead(),
      Container(
        height: 150,
        width: 170,
        padding: const EdgeInsets.only(left: 5, right: 5),
        margin: const EdgeInsets.only(left: 1, right: 1),
        decoration: BoxDecoration(
          // color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          children: [
            //  tophead(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Includes 3 test",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
                ),
                Icon(
                  Icons.security_outlined,
                  color: Colors.black,
                )
              ],
            ),
            const Row(
              children: [
                Text(
                  "   Get results in 24 hours",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.offerprice!,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.price!,
                  style: TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    addDataToFirestore(
                      price: widget.price,
                      testname: widget.testName,
                      offerprice: widget.offerprice,
                      id: widget.id,
                    );

                    setState(() {
                     widget.isaddedtocart = true;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 120,
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: widget.isaddedtocart ? Colors.blue : Colors.grey),
                    child: Center(
                      child: Text(
                       widget.isaddedtocart ? "Added to Cart" : "Add to Cart",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey),
                  child: const Center(
                    child: Text(
                      "View details",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 3,
            )
          ],
        ),
      ),
    ]);
  }

  Widget tophead() {
    return Container(
      height: 50,
      width: 170,
      margin: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
          color: Color(0xFF001F3F),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Center(
        child: Text(
          widget.testName!,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> addDataToFirestore({
    String? testname,
    String? price,
    String? offerprice,
    String? id,
  }) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('cart');

    Cartmodel data = Cartmodel(
        testname: testname, price: price, offerprice: offerprice, id: id);

    Map<String, dynamic> dataMap = data.toMap();

    await collection.add(dataMap);

    print('Data added to Firestore successfully!');
  }
}
