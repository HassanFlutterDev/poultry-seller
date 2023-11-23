import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/controllers/products_controller.dart';
import 'package:poultry_pal_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';

Widget productDropDown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return DropdownButtonHideUnderline(
    child: Obx(
      () => DropdownButton(
          hint: normalText(text: "$hint", color: fontGrey),
          value: dropvalue.value == '' ? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem(
              value: e,
              child: e.toString().text.make(),
            );
          }).toList(),
          onChanged: (newvalue) {
            if (hint == "Category") {
              controller.subcategoryvalue.value = '';
              controller.populateSubcategoryList(newvalue.toString());
            }
            dropvalue.value = newvalue.toString();
          }),
    ),
  )
      .box
      .white
      .roundedSM
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .make();
}
