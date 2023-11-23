// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poultry_pal_seller/const/const.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class OrdersController extends GetxController {
  var orders = [];
  var place = true.obs;
  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  updateSales({amount}) async {
    String id = Uuid().v1();
    firestore
        .collection('vendors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('sales')
        .doc(id)
        .set({
      'time': DateTime.now(),
      'amount': amount.toString(),
      'id': id,
    });
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(ordersCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
