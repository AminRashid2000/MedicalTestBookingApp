import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Views/homepage.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  List<QueryDocumentSnapshot> data = [];

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  DateTime? selectedDateTime;
  bool? isoLading = false;
  String? texttitle;
  Future<List<QueryDocumentSnapshot>> getdata() async {
    isoLading = true;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("cart").get();
    List<QueryDocumentSnapshot> doclist = snapshot.docs;
    return doclist;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "My Cart",
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      )),
      body: isoLading!
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.data.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Your cart is Empty",
                              style: TextStyle(
                                  color: Color(0xFF001F3F), fontSize: 30),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                // ignore: avoid_print
                                print("hiiiiiiiiiiiiiiiiiiii");
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFF001F3F), width: 5)),
                                height: 70,
                                width: 300,
                                child: const Center(
                                    child: Text(
                                  "Book Your Tests",
                                  style: TextStyle(
                                      color: Color(0xFF001F3F), fontSize: 30),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.data.length,
                        itemBuilder: (context, index) {
                          if (widget.data.isEmpty) {
                            return const Center(
                              child: Text("No data"),
                            );
                          }
                          if (widget.data.isNotEmpty) {
                            return Stack(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "Order review",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  tophead(index),
                                  cartCard(index),
                                  const SizedBox(height: 5),
                                  calender(),
                                  const SizedBox(height: 5),
                                  bill(index),
                                  const SizedBox(height: 5),
                                  acknowledgement(),
                                  const SizedBox(height: 5),
                                  // Schedulebutton(),
                                ]),
                              ),
                            ]);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    if (widget.data.isNotEmpty)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: schedulebutton(),
                      )
                  ]),
            ),
    );
  }

////////////////////widgets & Functions/////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  Widget tophead(index) {
    return Container(
      height: 50,
      width: 370,
      margin: const EdgeInsets.all(1),
      decoration: const BoxDecoration(
          color: Color(0xFF001F3F),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Center(
        child: Text(
          widget.data.elementAt(index)["testname"],
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget cartCard(index) {
    return Container(
      height: 150,
      width: 370,
      padding: const EdgeInsets.only(left: 5, right: 5),
      margin: const EdgeInsets.only(left: 1, right: 1),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.data.elementAt(index)["testname"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
              Text(
                "₹${widget.data.elementAt(index)["offerprice"]}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isoLading = true;
                  });
                  await removeDocumentFromFirestore(
                      collectionName: 'cart',
                      documentId: widget.data.elementAt(index).id);

                  widget.data.remove((index));

                  setState(() {
                    fetchData();

                    isoLading = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: (20)),
                  height: 39,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(width: 3, color: const Color(0xFF001F3F))),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.delete_forever_outlined),
                      ),
                      Text(
                        "   Remove",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: (20)),
                  height: 39,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 3, color: const Color(0xFF001F3F)),
                  ),
                  child: const Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.file_upload),
                    ),
                    Text(
                      "   Upload Prescription (optional)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15),
                    )
                  ])),
            ],
          ),
        ],
      ),
    );
  }

  Widget calender() {
    return Container(
      height: 100,
      width: 370,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Column(
        children: [
          const Icon(Icons.calendar_month_outlined),
          if (selectedDateTime != null)
            Center(
              child: Text('Selected Date: ${selectedDateTime?.toLocal()}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Container(
                child: const Text(
                  "Pick Any Date",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )),
        ],
      ),
    );
  }

  Widget bill(index) {
    return Container(
      height: 200,
      width: 370,
      padding: const EdgeInsets.all(40),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("M.R.P Total"),
              Text("₹${widget.data.elementAt(index)["price"]}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Discount"), Text("400")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Amount to be paid"),
              Text(
                "₹${widget.data.elementAt(index)["offerprice"]}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Text("Total savings"),
          //     Text(
          //       "    ₹ 400",
          //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget acknowledgement() {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(30),
      width: 370,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      child: const Column(
        children: [
          Row(
            children: [
              Text(
                "Hard copy of reports",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Text(
              "Reports will be delivered within 3-4 working days.Hardcopy charges are not refundable once the reports have been dispached"),
        ],
      ),
    );
  }

  Widget schedulebutton() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 70,
      width: 320,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Color(0xFF001F3F)),
      child: Center(
        child: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Succesfully booked your test'),
                      content: Container(
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF001F3F)),
                              child: const Center(
                                child: Icon(
                                  Icons.edit_calendar_outlined,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Lab tests have been scheduled Succesfully,you will receive a mail for the same",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                                'Selected Date: ${selectedDateTime?.toLocal()}')
                            // Text(
                            //     'Selected Date: ${selectedDateTime?.toLocal()}')
                          ],
                        ),
                      ),
                      // content: Text(
                      //     'Selected Date and Time: $selectedDateTime'),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Close the AlertDialog
                              },
                              child: const Text('OK'),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                },
                                child: const Text(
                                  "Back To Home",
                                  style: TextStyle(
                                      color: Color(0xFF001F3F),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ))
                          ],
                        ),
                      ]);
                });
          },
          child: const Text(
            "Schedule",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = combinedDateTime;
          texttitle = selectedDateTime?.toLocal().toIso8601String();
        });
      }
    }
  }

  Future<void> removeDocumentFromFirestore(
      {required String collectionName, required String documentId}) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('cart');

    DocumentReference documentReference = collection.doc(documentId);

    await documentReference.delete();
    // setState(() {
    //  widget.isaddedtocart = false;
    // });

    print('Document removed from Firestore successfully!');
  }

  void fetchData() async {
    List<QueryDocumentSnapshot> result = await getdata();
    setState(() {
      widget.data = result;
      isoLading = false;
    });
  }
}
