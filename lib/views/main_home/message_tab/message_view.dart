import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_chat_view.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/message_tab/chat/chat_view.dart';
import 'package:emerald_beauty/views/main_home/message_tab/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessageView extends StatefulWidget {
  final Users user;
  final ScrollController controller;
  const MessageView(
      {this.user = Users.freelancer, required this.controller, super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late MessageProvider messageProvider;

  @override
  void initState() {
    super.initState();
    messageProvider = MessageProvider();
    messageProvider.listenToChats(ApiUrls.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => messageProvider,
      child: Consumer<MessageProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Loader();
          } else {
            return SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  appBar: appBar(context,
                      title: localization!.translate("MESSAGE"),
                      leftIcon: null,
                      appBarheight: 8.h),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(
                      children: [
                        AppSearchField(
                            cntrller: provider.searchController,
                            fillColor: whiteColor,
                            icon: const Icon(Icons.search, color: grayColor)),
                        SizedBox(height: 2.h),
                        Expanded(
                          child: provider.chats.isEmpty
                              ? Center(
                                  child: Text("No chats available",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: greenishBlack)))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: provider.chats.length,
                                  itemBuilder: (context, index) {
                                    var chat = provider.chats[index];
                                    debugPrint("Chat: $chat");
                                    String chatPerson =
                                        "${chat["firstName"] ?? ""} ${chat["lastName"] ?? ""}";

                                    return AppChatView(
                                      tapFunctionality: () {
                                        Navigator.push(
                                            context,
                                            AnimatedNavigation.bottomSlide(
                                                ChatView(
                                              employeeId: int.parse(
                                                  chat['otherUserId']),
                                            )));
                                      },
                                      chatPerson: chatPerson,
                                      userImage: chat["profilePic"],
                                      lastMessage: chat["lastMessage"] ?? "",
                                      messageTime: provider.formatTimestamp(
                                          chat["lastMessageTime"]),
                                      seen:
                                          false, // Customize based on your logic
                                      notSeen:
                                          0, // Customize based on unread count logic
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}
