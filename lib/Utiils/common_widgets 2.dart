import 'package:medcore/Utiils/colors.dart';
import 'package:medcore/Utiils/text_font_family.dart';
import 'package:flutter/material.dart';
import 'package:medcore/index.dart';
import 'package:get/get.dart';

romanText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.AVENIR_LT_PRO_ROMAN,
          fontSize: size,
          color: color),
    );

heavyText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.AVENIR_LT_PRO_HEAVY,
          fontSize: size,
          color: color),
    );

bookText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
          fontSize: size,
          color: color),
    );

mediumText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.AVENIR_LT_PRO_MEDIUM,
          fontSize: size,
          color: color),
    );

commonButton(onTap, text, buttonColor, textColor) => InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: Get.width - 10,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: heavyText(text, textColor, 18),
        ),
      ),
    );
Button(onTap, text, buttonColor, textColor) => InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 70,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: heavyText(text, textColor, 10),
        ),
      ),
    );

textField1(hintText, controller, keyBoardType, {error = false}) =>
    TextFormField(
      cursorColor: ColorResources.black,
      controller: controller,
      keyboardType: keyBoardType,
      style: TextStyle(
        color: ColorResources.black,
        fontSize: 16,
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey777,
          fontSize: 16,
          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
        ),
        filled: false,
        border: UnderlineInputBorder(
          borderSide: error == false
              ? const BorderSide(color: ColorResources.greyA0A, width: 1)
              : const BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: error == false
              ? const BorderSide(color: ColorResources.greyA0A, width: 1)
              : const BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: error == false
              ? const BorderSide(color: ColorResources.greyA0A, width: 1)
              : const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );

textField2(hintText, controller, keyBoardType) => TextFormField(
      maxLines: 5,
      controller: controller,
      cursorColor: ColorResources.black,
      keyboardType: keyBoardType,
      style: TextStyle(
        color: ColorResources.grey777,
        fontSize: 16,
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey777,
          fontSize: 16,
          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
        ),
        filled: true,
        fillColor: ColorResources.whiteF6F,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorResources.greyA0A.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

textField3(hintText, controller, keyBoardType, validator) => TextFormField(
      validator: validator,
      cursorColor: ColorResources.black,
      controller: controller,
      keyboardType: keyBoardType,
      style: TextStyle(
        color: ColorResources.black,
        fontSize: 16,
        fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey777,
          fontSize: 16,
          fontFamily: TextFontFamily.AVENIR_LT_PRO_BOOK,
        ),
        filled: true,
        fillColor: ColorResources.whiteF6F,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyA0A, width: 1),
        ),
      ),
    );

AppBar appBar(BuildContext context, color) {
  return AppBar(
    backgroundColor: color,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          child: const Icon(Icons.arrow_back, color: ColorResources.grey777),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10, top: 15),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(index.routeName);
          },
          child: Container(
            height: 40,
            width: 40,
            child:
                const Icon(Icons.home_outlined, color: ColorResources.grey777),
          ),
        ),
      ),
    ],
  );
}
