import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_dotted_upload.dart';
import 'package:emerald_beauty/components/app_drop_down_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/expertise/add_new_expertise/add_new_expertise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewExpertiseView extends StatelessWidget {
  const AddNewExpertiseView({super.key});

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
        title: "ADD EXPERTISE",
      ),
      body: ChangeNotifierProvider(
        create: (_) => AddNewExpertiseProvider(),
        child: Consumer<AddNewExpertiseProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextBold(
                    text: "Area of Expertise",
                    color: Theme.of(context).primaryColor,
                    fontFamily: FontFamily.raleway,
                    fontSize: (width * height) * 0.000045,
                  ),
                  AppDropDownTextfield(
                    items: [
                      DropdownMenuItem(
                        value: "Men's Haircutting",
                        child: AppTextBold(
                          text: "Men's Haircutting",
                          fontFamily: FontFamily.hermann,
                          fontSize: (width * height) * 0.000035,
                        )
                      ),
                      DropdownMenuItem(
                        value: "Female's Haircutting",
                        child: AppTextBold(
                          text: "Female's Haircutting",
                          fontFamily: FontFamily.hermann,
                          fontSize: (width * height) * 0.000035,
                        )
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.025),
                  AppTextMedium(
                    text: "Hair Cutting",
                    fontFamily: FontFamily.hermann,
                    fontSize: (width * height) * 0.00005,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: height * 0.025),
                  Row(
                    children: [
                      AppTextMedium(
                        text: "Required Document : ",
                        fontFamily: FontFamily.hermann,
                        fontSize: (width * height) * 0.000045,
                        color: Theme.of(context).primaryColor,
                      ),
                      AppTextSemiBold(
                        text: "Certificate",
                        fontFamily: FontFamily.hermann,
                        fontSize: (width * height) * 0.000045,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  AppDottedUpload(
                    text: "Upload Document",
                    innerPadding: EdgeInsets.only(left: width * 0.025 , top: height * 0.005, bottom: height * 0.005),
                  ),
                  SizedBox(height: height * 0.05),
                  AppTextSemiBold(
                    text: "Upload your Past Work",
                    fontFamily: FontFamily.hermann,
                    fontSize: (width * height) * 0.000045,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: height * 0.025),
                  AppDottedUpload(
                    text: "Upload Images & Videos",
                    innerPadding: EdgeInsets.only(left: width * 0.025 , top: height * 0.005, bottom: height * 0.005),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: height * 0.05, left: width * 0.15, right: width * 0.15),
        child: App3DButton(
          backgroundColor: Theme.of(context).primaryColor, 
          borderColor: greenishBlack,
          tap: () {

          },
          child: AppTextBold(
            text: "Submit",
            color: whiteColor,
            fontFamily: FontFamily.raleway,
            fontSize: (width * height) * 0.00005,
          ),
        ),
      ),
    );
  }
}