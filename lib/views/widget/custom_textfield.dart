import 'package:poultry_pal_seller/const/const.dart';

Widget customTextField({label, hint, controller, isDec = false}) {
  return TextFormField(
    style: const TextStyle(color: Colors.white), // Use Colors.white for color
    maxLines: isDec ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      labelText: label, // Use labelText for the label
      labelStyle: const TextStyle(color: Colors.white), // Label text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white), // Use Colors.white
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white), // Use Colors.white
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey), // Use Colors.lightGrey
    ),
    controller: controller,
  );
}
