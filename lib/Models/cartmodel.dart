class Cartmodel {
  String? testname;
  String? price;
  String? offerprice;
  String? id;

  Cartmodel({
    required this.testname,
    required this.price,
    required this.offerprice,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'testname': testname,
      'price': price,
      'offerprice': offerprice,
      "id": id
    };
  }
}
