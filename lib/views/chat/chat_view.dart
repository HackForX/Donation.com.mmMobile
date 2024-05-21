import 'package:donation_com_mm_v2/controllers/natebanzay_chat_controller.dart';
import 'package:donation_com_mm_v2/util/assets_path.dart';
import 'package:donation_com_mm_v2/util/share_pref_helper.dart';
import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetView<NatebanzayChatController> {
  ChatView({super.key}){
    controller.getChat(requesterId, uploaderId) ;
  }
final requesterId=Get.arguments['requester_id'];
final uploaderId=Get.arguments['uploader_id'];
final isRequester=Get.arguments['isRequester'];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      print("isRequester $isRequester",);

      print("RequesterId $requesterId",);
      print("Uploader $uploaderId",);
      print("Current ${MySharedPref.getUserId()}");

      return RefreshIndicator(
        onRefresh: () async{
          controller.getChat(requesterId, uploaderId) ;
        },
        child: Scaffold(
          drawer:  DrawerView(),
          appBar: AppBar(title: const Text("Chat")),
          body:  SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(children: controller.messages.map((message) =>       ChatMessage(text: message.message, isSender:message.senderId==MySharedPref.getUserId()?true:false),).toList()),
          )),
          bottomNavigationBar: Padding(
   padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ),
            child: SizedBox(
              height: 76,
              child: Column(
                children: [
                  const Divider(),
                  Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Send a message.....",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith()),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                       controller.sendMessage(context,controller.chatId, MySharedPref.getUserId()??1,isRequester?uploaderId:requesterId , _messageController.text);
                       _messageController.clear() ;
              //          WidgetsBinding.instance.addPostFrameCallback((_){
              //       controller.getChat(requesterId, uploaderId) ;
              //  });
                        },
                        icon: Image.asset(
                       IconPath.sendIcon,
                          height: 22,
                          color: Colors.black,
                        ))
                  ]),
                ],
              ),
            ),
          )),
      );
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSender ? 'You' : 'From',
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
