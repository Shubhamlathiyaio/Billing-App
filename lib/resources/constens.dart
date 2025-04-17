import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

const double LARGE = 2;
const double MEDIUM = 1.3;
const double SMALL = 1.0;
const double LINEWIDTH = 1;
const double PADDING = 3;
const double A4RATIO = 1.414;

Color? primaryColor = Colors.blueGrey[900];
const Color secondaryColor = Colors.blueGrey;
const Color borderColor = Colors.black;
const Color backgroundColor = Colors.white;
const Color appBarTextColor = Colors.white;
const Color onDarkBg = Colors.white;
Color? instedOfBlack = Colors.blueGrey[900];
const PdfColor compalyColor = PdfColor.fromInt(0x0000f7);
const PdfColor invoiRed = PdfColor.fromInt(0xff314a);

const double containerPadding = 10.0;
const double containerBorderRadius = 8.0;
const double tilePadding = 6.0;
const double sectionSpacing = 12.0;

const String FILE_STORAGE_PATH = '/storage/emulated/0/Download';



late final font;