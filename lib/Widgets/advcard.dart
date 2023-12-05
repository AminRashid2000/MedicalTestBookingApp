import 'package:flutter/material.dart';

class AdvCard extends StatelessWidget {
  const AdvCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        width: 300,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 30,
              child: Container(
                height: 70,
                width: 70,
                decoration:
                    const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.medical_services,
                    size: 40,
                    color: Color(0xFF001F3F),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 30,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  height: 40,
                  width: 90,
                  color: Colors.green[500],
                  child: const Row(
                    children: [
                      Icon(
                        Icons.health_and_safety_outlined,
                        size: 20,
                      ),
                      Text(
                        "Safe",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                )),
            const Positioned(
              top: 80,
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Body checkUp",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "includes 92 tests",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "* Blood Glucose Fasting",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "*Liver Function Test",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "includes 92 tests",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "₹ 2000",
                      style:
                         TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                height: 30,
                width: 120,
                margin:const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child:const Center(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
