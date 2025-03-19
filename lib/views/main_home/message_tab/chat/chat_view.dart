import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerald_beauty/components/app_chat_typo.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_reciever_message.dart';
import 'package:emerald_beauty/components/app_sender_message.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/message_tab/chat/chat_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatView extends StatefulWidget {
  final int employeeId;
  const ChatView({required this.employeeId, super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatProvider chatProvider;
  bool _showEmojiPicker = false;
  String? selectedFileUrl;
  @override
  void initState() {
    super.initState();
    chatProvider = ChatProvider();
    chatProvider.initChat(receiverId: widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => chatProvider,
      child: Consumer<ChatProvider>(builder: (context, value, child) {
        if (value.messageStream == null) {
          return const Loader();
        } else {
          return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                appBar: appBar(context,
                    title: null,
                    titleWidget: Row(children: [
                      GestureDetector(onTap: () => Navigator.pop(context), child: const AppSvg(svgName: arrowBack, boxfit: BoxFit.none)),
                      SizedBox(width: 2.w),
                      AppCircularImage(networkImage: value.userDetails?["profile_pic"] ?? "", imgHeight: 5.h),
                      SizedBox(width: 1.5.w),
                      AppTextBold(
                          text: "${value.userDetails?["first_name"] ?? ""} ${value.userDetails?["last_name"] ?? ""}",
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.hermann,
                          fontSize: 16.sp)
                    ]),
                    leftIcon: null,
                    leftWidget: null,
                    rightIcons: [Padding(padding: EdgeInsets.only(right: 1.w), child: const AppSvg(svgName: threeDots))]),
                body: Column(children: [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.h),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: value.messageStream,
                              builder: (context, snapshot) {
                                // Check if the connection is still waiting for data
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Loader(); // Or any loading widget
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: AppTextMedium(text: "Something went wrong!", color: Theme.of(context).primaryColor, fontFamily: FontFamily.raleway, fontSize: 14.sp));
                                }

                                // Check if we have data and if it's not empty
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(
                                      child: AppTextMedium(text: "No conversations yet.", color: Theme.of(context).primaryColor, fontFamily: FontFamily.raleway, fontSize: 14.sp));
                                }

                                var messages = snapshot.data!.docs;

                                return ListView.builder(
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      var msg = messages[messages.length - 1 - index];
                                      bool isSentByMe = msg['senderId'] == chatProvider.senderId;
                                      return Align(
                                          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 1.h),
                                              child: isSentByMe
                                                  ? AppSenderMessage(message: msg['message'], messageTime: chatProvider.formatTime(msg['timestamp']))
                                                  : AppReceiverMessage(message: msg['message'], messageTime: chatProvider.formatTime(msg['timestamp']))));
                                    });
                              }))),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AppChatTypo(
                      sendBtn: () {
                        if (selectedFileUrl != null) {
                          value.sendMessage(employeeId: widget.employeeId, fileUrl: selectedFileUrl);
                          setState(() => selectedFileUrl = null); // Reset after sending
                        } else {
                          value.sendMessage(employeeId: widget.employeeId);
                        }
                      },
                      fileTap: () async {
                        String? uploadedFileUrl = await pickAndUploadFile(); // Function to pick & upload file
                        if (uploadedFileUrl != null) {
                          value.sendMessage(employeeId: widget.employeeId, fileUrl: selectedFileUrl);

                          // setState(() => selectedFileUrl = uploadedFileUrl);
                        }
                      },
                      emojiTap: () => setState(() => _showEmojiPicker = !_showEmojiPicker),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  //     child: AppChatTypo(sendBtn: () => value.sendMessage(employeeId: widget.employeeId), emojiTap: () => setState(() => _showEmojiPicker = !_showEmojiPicker))),

                  _showEmojiPicker
                      ? SizedBox(height: 250, width: 100.w, child: EmojiPicker(onEmojiSelected: (category, emoji) => value.message.text += emoji.emoji))
                      : const SizedBox.shrink()
                ]),
                // bottomNavigationBar: Padding(
                //   padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom,
                //   ),
                //   child: AppChatTypo(sendBtn: () {
                //     value.sendMessage(employeeId: widget.employeeId);
                //   }, emojiTap: () {
                //     setState(() {
                //       _showEmojiPicker = !_showEmojiPicker;
                //     });
                //   }),
                // ),
              ));
        }
      }),
    );
  }

  Future<String?> pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      // Upload to Firebase Storage
      String fileName = result.files.single.name;
      Reference storageRef = FirebaseStorage.instance.ref().child('chat_files/$fileName');

      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    }
    return null;
  }
}
