import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    required this.fontSize,
    this.title,
    this.firstText,
    this.secondText,
    this.firstTextColor,
    this.secondTextColor,
    this.firstTextFontWeight,
    this.secondTextFontWeight,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.maxLines,
    this.textOverflow,
    this.textAlign = TextAlign.center,
    this.fontFamily,
    this.fontStyle = FontStyle.normal,
    this.isItalic = false,
    this.capitalize = false,
    this.textStyle,
  }) : assert(
  (title != null) ^ (firstText != null && secondText != null),
  'Provide either a single title or both firstText and secondText for dual-tone.',
  );

  final FontWeight fontWeight;
  final Color? textColor;
  final double fontSize;
  final String? title;
  final String? firstText;
  final String? secondText;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final FontWeight? firstTextFontWeight;
  final FontWeight? secondTextFontWeight;
  final MainAxisAlignment mainAxisAlignment;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final String? fontFamily;
  final FontStyle fontStyle;
  final bool isItalic;
  final bool capitalize;
  final TextStyle? textStyle;

  String capitalizeText(String text) {
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
        ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
        : word)
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle = textStyle ??
        (fontFamily != null && fontFamily!.isNotEmpty
            ? TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          fontFamily: fontFamily,
        )
            : GoogleFonts.quicksand(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ));

    if (isItalic) {
      baseStyle = baseStyle.copyWith(fontStyle: FontStyle.italic);
    }

    Widget textWidget;

    if (title != null) {
      textWidget = Text(
        capitalize && title != null ? capitalizeText(title!) : title ?? '',
        overflow: textOverflow,
        maxLines: maxLines,
        textAlign: textAlign,
        style: baseStyle.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      );
    } else if (firstText != null && secondText != null) {
      textWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            capitalize && firstText != null
                ? capitalizeText(firstText!)
                : firstText!,
            style: baseStyle.copyWith(
              fontSize: fontSize,
              fontWeight: firstTextFontWeight ?? fontWeight,
              color: firstTextColor ?? textColor,
            ),
          ),
          Text(
            capitalize && secondText != null
                ? capitalizeText(secondText!)
                : secondText!,
            style: baseStyle.copyWith(
              fontSize: fontSize,
              fontWeight: secondTextFontWeight ?? fontWeight,
              color: secondTextColor ?? textColor,
            ),
          ),
        ],
      );
    } else {
      textWidget = const SizedBox.shrink();
    }

    return textWidget;
  }
}