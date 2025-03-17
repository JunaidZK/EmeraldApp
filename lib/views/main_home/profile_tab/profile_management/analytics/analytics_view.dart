import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(
        context,
        appBarheight: height * 0.08,
        leftWidget: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: AppSvg(
            svgName: arrowBack,
            width: width * 0.001,
            height: height * 0.0001,
            boxfit: BoxFit.none,
          ),
        ),
        title: "ANALYTICS",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AppTextBold(
              text: "SCREEN UNDER PROCESS",
              color: Theme.of(context).primaryColor,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}