import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_date_time_picker.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_swithcer.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/availability/availability_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailbilityView extends StatelessWidget {
  const AvailbilityView({super.key});

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
        title: "AVAILABILITY",
      ),
      body: ChangeNotifierProvider(
        create: (_) => AvailabilityProvider(),
        child: Consumer<AvailabilityProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.025),
                    AppTextBold(
                      text: "Set Your Availability",
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontFamily.raleway,
                      fontSize: (width * height) * 0.000055,
                    ),
                    SizedBox(height: height * 0.01),
                    //MARK: - MONDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.monday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('monday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Monday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.mondayStartController, 
                                labelText: "", 
                                onTap: () => value.monday ? value.selectTime(context, value.mondayStartController) : null,
                                enabled: value.monday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.mondayEndController, 
                                labelText: "", 
                                onTap: () => value.monday ? value.selectTime(context, value.mondayStartController) : null,
                                enabled: value.monday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - TUESDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.tuesday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('tuesday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Tuesday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.tuesdayStartController, 
                                labelText: "", 
                                onTap: () => value.tuesday ? value.selectTime(context, value.tuesdayStartController) : null,
                                enabled: value.tuesday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.tuesdayEndController, 
                                labelText: "", 
                                onTap: () => value.tuesday ? value.selectTime(context, value.tuesdayEndController) : null,
                                enabled: value.tuesday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - WEDNESDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.wednesday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('wednesday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Wednesday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.wednesdayStartController, 
                                labelText: "", 
                                onTap: () => value.wednesday ? value.selectTime(context, value.wednesdayEndController) : null,
                                enabled: value.wednesday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.wednesdayEndController, 
                                labelText: "", 
                                onTap: () => value.wednesday ? value.selectTime(context, value.wednesdayEndController) : null,
                                enabled: value.wednesday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - THURSDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.thursday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('thursday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Thursday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.thursdayStartController, 
                                labelText: "", 
                                onTap: () => value.thursday ? value.selectTime(context, value.thursdayStartController) : null,
                                enabled: value.thursday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.thursdayStartController, 
                                labelText: "", 
                                onTap: () => value.thursday ? value.selectTime(context, value.thursdayEndController) : null,
                                enabled: value.thursday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - FRIDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.friday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('friday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Friday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.fridayStartController, 
                                labelText: "", 
                                onTap: () => value.friday ? value.selectTime(context, value.fridayStartController) : null,
                                enabled: value.friday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.fridayEndController, 
                                labelText: "", 
                                onTap: () => value.friday ? value.selectTime(context, value.fridayEndController) : null,
                                enabled: value.friday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - SATURDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.saturday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('saturday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Saturday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.saturdayStartController, 
                                labelText: "", 
                                onTap: () => value.saturday ? value.selectTime(context, value.saturdayStartController) : null,
                                enabled: value.saturday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.saturdayEndController, 
                                labelText: "", 
                                onTap: () => value.saturday ? value.selectTime(context, value.saturdayEndController) : null,
                                enabled: value.saturday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - SUNDAY
                    Row(
                      children: [
                        AppSwithcer(
                          swithcerValue: value.sunday,
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua, 
                          valueChanged: (val) {
                            value.toggleAvailability('sunday');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Sunday",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "Start Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.sundayStartController, 
                                labelText: "", 
                                onTap: () => value.sunday ? value.selectTime(context, value.sundayStartController) : null,
                                enabled: value.sunday,
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextBold(
                                text: "End Time",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: (width * height) * 0.0000475,
                              ),
                              AppDateTimePicker(
                                controller: value.sundayEndController, 
                                labelText: "", 
                                onTap: () => value.sunday ? value.selectTime(context, value.sundayEndController) : null,
                                enabled: value.sunday,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025),
                    //MARK: - AWAY
                    AppTextSemiBold(
                      text: "Away Mode (Optional)",
                      fontSize: (width * height) * 0.00005,
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontFamily.raleway,
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        AppSwithcer(
                          activeColor: Theme.of(context).primaryColor,
                          borderColor: lightAqua,
                          swithcerValue: value.away, 
                          valueChanged: (val) {
                            value.toggleAvailability('away');
                          }
                        ),
                        SizedBox(width: width * 0.02),
                        AppTextSemiBold(
                          text: "Mark Away",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.raleway,
                          fontSize: (width * height) * 0.00005,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.075),
                    Center(
                      child: App3DButton(
                        backgroundColor: Theme.of(context).primaryColor, 
                        borderColor: greenishBlack,
                        child: AppTextBold(
                          text: "SAVE",
                          color: whiteColor,
                          fontFamily: FontFamily.hermann,
                          fontSize: (width * height) * 0.000045,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}