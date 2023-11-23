import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/controllers/products_controller.dart';
import 'package:poultry_pal_seller/views/products_screen/components/product_dropdown.dart';
import 'package:poultry_pal_seller/views/products_screen/components/product_images.dart';
import 'package:poultry_pal_seller/views/widget/custom_textfield.dart';
import 'package:poultry_pal_seller/views/widget/loading_indicator.dart';
import 'package:poultry_pal_seller/views/widget/normal_text.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: boldText(text: "Add Product", color: white, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: "Save", color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. Chicken",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product",
                    label: "Description",
                    isDec: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg. \$100",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg. 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                productDropDown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropDown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(color: white),
                boldText(text: "Chose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
                const Divider(color: white),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
