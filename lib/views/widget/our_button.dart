import 'package:poultry_pal_seller/const/const.dart';
import 'package:poultry_pal_seller/views/widget/normal_text.dart';

Widget ourButton(
    {required String title,
    Color color = purpleColor,
    required Function() onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress, // Pass the onPress function here
    child: normalText(text: title, size: 16.0),
  );
}
