import 'package:flutter/material.dart';

class AvailabilityProvider extends ChangeNotifier{
  bool _mondaySwitcher = true;
  bool _tuesdaySwitcher = true;
  bool _wednesdaySwitcher = true;
  bool _thursdaySwitcher = true;
  bool _fridaySwitcher = true;
  bool _saturdaySwitcher = false;
  bool _sundaySwitcher = false;
  bool _awaySwitcher = false;

  final mondayStartController = TextEditingController();
  final tuesdayStartController = TextEditingController();
  final wednesdayStartController = TextEditingController();
  final thursdayStartController = TextEditingController();
  final fridayStartController = TextEditingController();
  final saturdayStartController = TextEditingController();
  final sundayStartController = TextEditingController();

  final mondayEndController = TextEditingController();
  final tuesdayEndController = TextEditingController();
  final wednesdayEndController = TextEditingController();
  final thursdayEndController = TextEditingController();
  final fridayEndController = TextEditingController();
  final saturdayEndController = TextEditingController();
  final sundayEndController = TextEditingController();

  Future<void> selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
      notifyListeners(); // Notify listeners if you want to react to the change in other parts
    }
  }  

  bool get monday => _mondaySwitcher;
  bool get tuesday => _tuesdaySwitcher;
  bool get wednesday => _wednesdaySwitcher;
  bool get thursday => _thursdaySwitcher;
  bool get friday => _fridaySwitcher;
  bool get saturday => _saturdaySwitcher;
  bool get sunday => _sundaySwitcher;
  bool get away => _awaySwitcher;

   void toggleAvailability(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        _mondaySwitcher = !_mondaySwitcher;
        break;
      case 'tuesday':
        _tuesdaySwitcher = !_tuesdaySwitcher;
        break;
      case 'wednesday':
        _wednesdaySwitcher = !_wednesdaySwitcher;
        break;
      case 'thursday':
        _thursdaySwitcher = !_thursdaySwitcher;
        break;
      case 'friday':
        _fridaySwitcher = !_fridaySwitcher;
        break;
      case 'saturday':
        _saturdaySwitcher = !_saturdaySwitcher;
        break;
      case 'sunday':
        _sundaySwitcher = !_sundaySwitcher;
        break;
      case 'away':
        _awaySwitcher = !_awaySwitcher;
        break;
      default:
        throw ArgumentError("Invalid day: $day");
    }
    notifyListeners();
  }
}