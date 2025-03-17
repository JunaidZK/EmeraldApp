import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/model_class/profile/profile_management/leave_management.dart';
import 'package:flutter/material.dart';

class DetailLeavePage extends StatelessWidget {
  final LeaveData data;
  const DetailLeavePage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Color statusBgColor = data.leaveStatusText == "Pending"
        ? yellowColor.withOpacity(0.3)
        : data.leaveStatusText == "Approved"
            ? brightGreen.withOpacity(0.3)
            : redColor.withOpacity(0.3);
    Color statusTextColor = data.leaveStatusText == "Pending"
        ? yellowColor
        : data.leaveStatusText == "Approved"
            ? brightGreen
            : redColor;
    return Scaffold(
      appBar: appBar(context,
          appBarheight: height * 0.08,
          leftWidget: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: AppSvg(
                  svgName: arrowBack,
                  width: width * 0.001,
                  height: height * 0.0001,
                  boxfit: BoxFit.none)),
          title: "LEAVE MANAGEMENT"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRow("Leave Type", data.leaveTypeText, width, height),
                AppBox(
                    elevation: 0,
                    bgColor: statusBgColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.001),
                        child: AppTextMedium(
                            text: data.leaveStatusText,
                            fontFamily: FontFamily.raleway,
                            color: statusTextColor,
                            fontSize: (width * height) * 0.000035)))
              ],
            ),
            _buildRow(
                "Date", '${data.startDate} - ${data.endDate}', width, height),
            _buildRow("Subject", data.subject, width, height),
            _buildRow("Reason", data.reason, width, height),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, width, height) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextBold(
              text: title,
              color: primaryColor,
              fontFamily: FontFamily.raleway,
              fontSize: (width * height) * 0.000045),
          const SizedBox(height: 4),
          AppTextMedium(
              text: value,
              color: grayColor,
              fontFamily: FontFamily.raleway,
              fontSize: (width * height) * 0.000035),
        ],
      ),
    );
  }
}
