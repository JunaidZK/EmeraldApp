import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_date_time_picker.dart';
import 'package:emerald_beauty/components/app_dotted_upload.dart';
import 'package:emerald_beauty/components/app_drop_down_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/apply_for_leave/apply_for_leave_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ApplyForLeaveView extends StatelessWidget {
  const ApplyForLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApplyForLeaveProvider(),
      child: Consumer<ApplyForLeaveProvider>(builder: (context, value, child) {
        return Scaffold(
          appBar: appBar(
            context,
            appBarheight: 8.h,
            leftWidget: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const AppSvg(
                svgName: arrowBack,
                boxfit: BoxFit.none,
              ),
            ),
            title: "LEAVE REQUEST",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextSemiBold(
                    text: "Leave Type",
                    fontFamily: FontFamily.hermann,
                    fontSize: 15.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  AppDropDownTextfield(
                    placeholder: "Select",
                    suffixIcon: const AppSvg(svgName: dropDownIcon),
                    items: value.items,
                    value: value.selectedLeaveType, // Bind selected value
                    onChanged: (newValue) {
                      value.setSelectedLeaveType(newValue.toString());
                    },
                  ),
                  SizedBox(height: 0.5.h),
                  AppTextSemiBold(
                    text: "Subject",
                    fontFamily: FontFamily.hermann,
                    fontSize: 15.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  AppTextField(
                    textController: value.subjectController,
                    placeholder: "Enter Subject of Leave",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.5)),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextSemiBold(
                            text: "Start Date",
                            color: Theme.of(context).primaryColor,
                            fontFamily: FontFamily.raleway,
                            fontSize: 14.sp,
                          ),
                          AppDateTimePicker(
                            controller: value.startDateController,
                            labelText: "Select Start Date",
                            onTap: () => value.selectDate(
                                context, value.startDateController),
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )),
                      SizedBox(width: 2.5.w),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextSemiBold(
                            text: "End Date",
                            color: Theme.of(context).primaryColor,
                            fontFamily: FontFamily.raleway,
                            fontSize: 14.sp,
                          ),
                          AppDateTimePicker(
                            controller: value.endDateController,
                            labelText: "Select End Date",
                            onTap: () => value.selectDate(
                                context, value.endDateController),
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  SizedBox(height: 0.35.h),
                  AppTextSemiBold(
                    text: "Reason",
                    color: Theme.of(context).primaryColor,
                    fontFamily: FontFamily.raleway,
                    fontSize: 14.sp,
                  ),
                  AppTextField(
                    placeholder: "Enter Reason of Leave",
                    textController: value.reasonController,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.5)),
                  ),
                  SizedBox(height: 0.5.h),
                  AppTextSemiBold(
                    text: "Attachment",
                    color: Theme.of(context).primaryColor,
                    fontFamily: FontFamily.raleway,
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 0.5.h),
                  GestureDetector(
                    onTap: () async {
                      await value.pickAttachments();
                    },
                    child: AppDottedUpload(
                      text: "Upload Document",
                      innerPadding:
                          EdgeInsets.only(top: 1.h, bottom: 1.h, left: 2.w),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Column(
                    children: value.attachments.asMap().entries.map((entry) {
                      int index = entry.key;
                      String docs = entry.value;

                      return ListTile(
                        leading: Icon(Icons.insert_drive_file,
                            color: Theme.of(context).primaryColor),
                        title: Text(docs),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: redColor),
                          onPressed: () {
                            value.removeAttachment(index);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                App3DButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  borderColor: greenishBlack,
                  tap: () async {
                    await value.addLeave().then((val) {
                      Navigator.pop(context);
                    });
                  },
                  child: AppTextBold(
                    text: "SAVE",
                    color: whiteColor,
                    fontSize: 17.sp,
                    fontFamily: FontFamily.raleway,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
