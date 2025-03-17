import 'package:emerald_beauty/api_classes/profile/profile_management/leave_management.dart';
import 'package:emerald_beauty/api_classes/uploading/file_picker.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class ApplyForLeaveProvider extends ChangeNotifier {
  LeaveManagement leaveApi = LeaveManagement();
  FilePickerService filePicker = FilePickerService();

  final subjectController = TextEditingController();
  final leaveTypeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final reasonController = TextEditingController();
  List<String> attachments = [];

  String? selectedLeaveType; // To store selected leave type

  List<DropdownMenuItem<String>> get items {
    return LeaveTypes.values.map((type) {
      return DropdownMenuItem(
        value: type.name, // Use .name to get string representation
        child: AppTextMedium(
          text: type.name,
          fontFamily: FontFamily.raleway,
          color: primaryColor,
        ),
      );
    }).toList();
  }

  void setSelectedLeaveType(String? value) {
    selectedLeaveType = value;
    notifyListeners();
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      notifyListeners();
    }
  }

  Future<void> pickAttachments() async {
    String documents = await filePicker.addFile();
    attachments.add(documents);
    notifyListeners();
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
    notifyListeners();
  }

  Future<void> addLeave() async {
    if (selectedLeaveType == null || selectedLeaveType!.isEmpty) {
      showToast("Please select a leave type");
      return;
    }
    if (subjectController.text.isEmpty) {
      showToast("Please enter a subject");
      return;
    }
    if (startDateController.text.isEmpty) {
      showToast("Please select a start date");
      return;
    }
    if (endDateController.text.isEmpty) {
      showToast("Please select an end date");
      return;
    }
    if (reasonController.text.isEmpty) {
      showToast("Please enter a reason");
      return;
    }

    if (attachments.isEmpty) {
      showToast("Please attach a document");
      return;
    }

    String message = await leaveApi.applyForLeave(
      startDate: startDateController.text,
      endDate: endDateController.text,
      reason: reasonController.text,
      subject: subjectController.text,
      leaveType: selectedLeaveType!,
      attachments: attachments, // Pass the attachments list
    );

    showToast(message);
  }
}
