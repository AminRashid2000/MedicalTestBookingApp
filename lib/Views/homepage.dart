import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Models/testcard.dart';
import 'package:medical_app/Views/cart.dart';
import 'package:medical_app/Widgets/advcard.dart';
import 'package:medical_app/Widgets/testdetailscard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = false;
  List<QueryDocumentSnapshot> cartList = [];
  List<TestCard> testList = TestCard.gettestcard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Logo",
            style: TextStyle(fontSize: 40),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isloading = true;
                    fetchDatahome();
                    isloading = false;
                  });
                },
                icon: Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                icon: Icon(Icons.shopping_cart)),
          ],
        ),
        body: isloading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Lab tests",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.blue[900]),
                                    children: const [
                                  TextSpan(
                                    text: "View More",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: "  ->",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))
                                ])))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                          //  color: Colors.yellow,
                          height: 450,
                          width: 1000,
                          padding: const EdgeInsets.all(1),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 4,
                                    mainAxisExtent: 210,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 6),
                            itemCount: testList.length,
                            itemBuilder: (context, index) {
                              return TestDtCard(
                                price: testList[index].price,
                                offerprice: testList[index].offerprice,
                                testName: testList[index].testname,
                                id: testList[index].id,
                              );
                            },
                          )),
                    ),
                    const Row(
                      children: [
                        Text(
                          "Popular Packages",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const AdvCard()
                  ],
                ),
              ));
  }

  Future<List<QueryDocumentSnapshot>> getdata() async {
    // isoLading = true;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("cart").get();
    List<QueryDocumentSnapshot> doclist = snapshot.docs;

    return doclist;
  }

  void fetchDatahome() async {
    List<QueryDocumentSnapshot> result = await getdata();
    setState(() {
      cartList = result;

      testList.forEach((test) {
        test.isaadedtocart = cartList.any((doc) => doc["id"] == test.id);
      });
    });
  }
}
