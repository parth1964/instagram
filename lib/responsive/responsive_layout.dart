import 'package:flutter/material.dart';
import 'package:instagram/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webscreenLayout;
  final Widget mobilescreenlayout;

  const ResponsiveLayout(
      {Key? key,
      required this.webscreenLayout,
      required this.mobilescreenlayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > webScreensize) {
          return webscreenLayout;
        } else {
          return mobilescreenlayout;
        }
      }),
    );
  }
}
