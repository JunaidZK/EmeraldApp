class ApiUrls {
  static String baseUrl = "";

  static String? token;
  static int? userId;

  //MARK: - AUTH
  static const login = "/login";
  static const create = "/register";
  static const forgotPassword = "/forgot-password";
  static const verifyOtp = "/verify-otp";
  static const resendOtp = "/resend-otp";
  static const resetPassword = "/reset-password";
  static const me = "/me";
  static const register = "/register";

  //MARK: - UPLOADING
  static const s3uploadUrl = "/s3-presigned-url";

  //MARK: - CATEGORIES
  static const getCategories = "/get-categories";

  //MARK: - SERVICES
  static const getServices = "/services";

  //MARK: - BOOKINGS
  static const getBookings = "/bookings";
  static const updateBooking = "/update-booking-status";

  //MARK: - S3
  static const s3config = "/s3-presigned-url";

  //MARK: - HOME TAB
  static const bookingAnalytics = "/get-booking-analytics";
  static const bookingGraph = "/get-booking-stats";

  //MARK: - UserService
  static const userServicee = "/user-services";
  static const service = "/services";

  //MARK: - Reviews
  static const reviews = "/reviews";

  //MARK: - PROFILE TAB
  //MARK: - LEGAL INFO
  static const termNcondition = "/page-by-slug/terms-and-conditions";
  static const refundPolicy = "/page-by-slug/refunding-policy";
  static const privacyPolicy = "/page-by-slug/privacy-policy";

  //MARK: - CUSTOMER SUPPORT
  static const faq = "/faqs";
  static const contactInfo = "/socials";

  //MARK: - PROFILE MANAGEMENT
  static const getPaymentInfo = "/get-payment-information";
  static const paymentInfo = "/payment-informations";
  static const passwordChange = "/change-password";
  static const editProfile = "/update-profile";
  static const leave = "/leaves";

  //MARK: - NOTIFICATIONS
  static const notifications = "/notifications";
  static const unreadCount = "/get-unread-count";
  static const markAllRead = "/mark-all-read";
  static const markRead = "/mark-read";
}
