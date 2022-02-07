import 'package:flutter/material.dart';

class ReuseWidgets {
  static Widget textfield(
      {required final TextEditingController controller,
      required final String hinttext,
      required final TextInputType textinput,
      bool obsecure = false,
      required BuildContext context}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        border:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        focusedBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        enabledBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textinput,
      obscureText: obsecure,
    );
  }
}
