import 'package:emerald_beauty/api_classes/auth/me.dart';
import 'package:emerald_beauty/api_classes/bookings/get_bookings.dart';
import 'package:emerald_beauty/api_classes/notifications/notifications.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/booking/booking_response.dart';
import 'package:emerald_beauty/model_class/user/user_info/user_info.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_view.dart';
import 'package:emerald_beauty/views/main_home/home_tab/home_tab_view.dart';
import 'package:emerald_beauty/views/main_home/message_tab/message_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_view.dart';
import 'package:flutter/material.dart';

class MainHomeProvider extends ChangeNotifier {
  Me fetchUser = Me();

  late TabController tabController;
  late PageController pageController;
  final Users user;
  final RequestFrom request;
  int currentPage = 0;
  bool openHistoryTab = false;
  ProfileResponse? userProfile;
  BookingResponse? bookings;
  List<Booking> appointmentsHistory = [];
  GetBookings bookingHistory = GetBookings();
  Notifcations notificationApi = Notifcations();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late List<Widget Function(ScrollController)> pages;
  int unreadCount = 0;

  MainHomeProvider(TickerProvider tickerProvider, this.user, this.request) {
    tabController = TabController(length: 4, vsync: tickerProvider);

    pageController = PageController();

    pages = [
      (scrollController) => HomeTabView(user: user, controller: scrollController),
      (scrollController) => BookingTabView(user: user, controller: scrollController, historyOpen: openHistoryTab),
      (scrollController) => MessageView(user: user, controller: scrollController),
      (scrollController) => ProfileView(user: user, controller: scrollController, requestFrom: request)
    ];

    tabController.addListener(() {
      if (tabController.index != currentPage) {
        setPage(tabController.index);
      }
    });
  }

  void setPage(int index, {bool openHistory = false}) {
    currentPage = index;

    if (index == 1) {
      openHistoryTab = openHistory;
    } else {
      openHistoryTab = false;
    }

    tabController.animateTo(index);
    pageController.jumpToPage(index);
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    try {
      userProfile = await fetchUser.fetchUserProfile();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching user profile: $e");
    } finally {}
  }

  Future<void> getAllBookings() async {
    bookings = await bookingHistory.getBookings();
    notifyListeners();
  }

  void getHistoryBookings() async {
    appointmentsHistory = bookings!.data.data.where((booking) => booking.status == 40).toList();
    notifyListeners();
  }

  Future<void> getUnreadNotifications() async {
    unreadCount = await notificationApi.notificationsCounts();
    notifyListeners();
  }

  Future<void> markReadNotifications() async {
    await notificationApi.markAllReadNotifications();
  }

  bool isActiveTab(int index) => currentPage == index;

  void toggleLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}
