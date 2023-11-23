import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/services/store_services.dart';
import 'package:poultry_pal_seller/views/messages_screen/chat_screen.dart';
import 'package:poultry_pal_seller/views/widget/loading_indicator.dart';
import 'package:poultry_pal_seller/views/widget/normal_text.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to((const ChatScreen()));
                      },
                      leading: const CircleAvatar(
                        backgroundColor: purpleColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                        ),
                      ),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: fontGrey),
                      subtitle: normalText(
                          text: "${data[index]['last_msg']}", color: darkGrey),
                      trailing: normalText(text: time, color: darkGrey),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
