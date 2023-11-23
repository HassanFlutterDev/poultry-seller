// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/services/store_services.dart';
import 'package:poultry_pal_seller/views/home_screen/line_chart.dart';
import 'package:poultry_pal_seller/views/products_screen/product_details.dart';
import 'package:poultry_pal_seller/views/widget/dashboard_button.dart';
import 'package:poultry_pal_seller/views/widget/loading_indicator.dart';
import 'package:poultry_pal_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sales = '0';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSales();
  }

  getSales() async {
    var data = await firestore
        .collection('vendors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sales')
        .get();
    setState(() {
      sales = data.docs.length.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: dashboard, color: purpleColor, size: 16.0),
      ),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        dashboardButton(context,
                            title: orders, count: "15", icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: rating, count: "60", icon: icStar),
                        dashboardButton(context,
                            title: totalSales, count: sales, icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    LineChartSample1(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['p_wishlist'] == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(
                                    () => ProductDetails(data: data[index]),
                                  );
                                },
                                leading: Image.network(data[index]['p_imgs'][0],
                                    width: 100, height: 100, fit: BoxFit.cover),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: normalText(
                                    text: "${data[index]['p_price']}",
                                    color: darkGrey),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
