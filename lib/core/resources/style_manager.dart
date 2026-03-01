import 'package:flutter/material.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  String fontFamily,
) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: fontFamily,
  );
}

// Bukra Styles
TextStyle getBukraLight({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color, FontConstants.bukra);
}

TextStyle getBukraRegular({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, FontConstants.bukra);
}

TextStyle getBukraMedium({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color, FontConstants.bukra);
}

TextStyle getBukraSemiBold({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color, FontConstants.bukra);
}

TextStyle getBukraBold({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color, FontConstants.bukra);
}

// Kaff Styles
TextStyle getKaffLight({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color, FontConstants.kaff);
}

TextStyle getKaffRegular({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color, FontConstants.kaff);
}

TextStyle getKaffMedium({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color, FontConstants.kaff);
}

TextStyle getKaffSemiBold({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color, FontConstants.kaff);
}

TextStyle getKaffBold({double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color, FontConstants.kaff);
}
