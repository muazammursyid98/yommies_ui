import 'package:flutter/material.dart';

class LayoutUI {
  List getLayout(context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    bool useMobileLayout = shortestSide < 600;
    Orientation orientation = MediaQuery.of(context).orientation;
    return [useMobileLayout, orientation];
    //* useMobileLayout = true - mobile , false - tablet,
    //* orientation = true - orientation , false - landscape
  }
}