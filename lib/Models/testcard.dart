class TestCard {
  String? testname;
  String? price;
  String? offerprice;
  bool? isaadedtocart;
  String? id;
  TestCard(
      {this.testname,
      this.price,
      this.offerprice,
      this.isaadedtocart = false,
      this.id});

  static List<TestCard> gettestcard() {
    return [
      TestCard(
          testname: "Thyroid Profile",
          price: "1400",
          offerprice: "1000",
          id: "1",
          isaadedtocart: false),
      TestCard(
          testname: "Iron Study Test",
          price: "1600",
          offerprice: "900",
          id: "2",
          isaadedtocart: false),
      TestCard(
          testname: "Sugar Test",
          price: "1400",
          offerprice: "800",
          id: "3",
          isaadedtocart: false),
      TestCard(
          testname: "Cholostrol Test",
          price: "600",
          offerprice: "300",
          id: "4",
          isaadedtocart: false),
      TestCard(
          testname: "HbA1c Test",
          price: "1900",
          offerprice: "1000",
          id: "5",
          isaadedtocart: false),
      TestCard(
          testname: "Hemoglobin",
          price: "1600",
          offerprice: "900",
          id: "6",
          isaadedtocart: false),
      TestCard(
          testname: "ESR",
          price: "2000",
          offerprice: "1400",
          id: "7",
          isaadedtocart: false),
      TestCard(
          testname: "Urine Test",
          price: "3000",
          offerprice: "900",
          id: "8",
          isaadedtocart: false),
      TestCard(
          testname: "Lipid Panel",
          price: "2000",
          offerprice: "1400",
          id: "9",
          isaadedtocart: false),
      TestCard(
          testname: "Blood test",
          price: "2600",
          offerprice: "900",
          id: "10",
          isaadedtocart: false),
      TestCard(
          testname: "Urine Test",
          price: "2000",
          offerprice: "1400",
          id: "11",
          isaadedtocart: false),
      TestCard(
          testname: "Tumor Test",
          price: "3600",
          offerprice: "900",
          id: "12",
          isaadedtocart: false),
    ];
  }
}
