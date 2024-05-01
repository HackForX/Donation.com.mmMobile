import 'package:donation_com_mm_v2/views/drawer/drawer_view.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  DrawerView(),
        appBar: AppBar(title: const Text("Chat")),
        body: const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            ChatMessage(text: "Hello", isSender: false),
            ChatMessage(text: "Hello", isSender: true),
            ChatMessage(text: "Hi from api", isSender: true),
            ChatMessage(text: "Hello Hi", isSender: true),
            ChatMessage(text: "Hi", isSender: false),
          ]),
        )),
        bottomNavigationBar: SizedBox(
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
                      // ToastHelper.showSuccessToast(context, "Sending..");
                    },
                    icon: Image.asset(
                      "assets/images/send.png",
                      height: 22,
                      color: Colors.black,
                    ))
              ]),
            ],
          ),
        ));
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isSender,
  }) : super(key: key);

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
                isSender ? 'You' : 'Tecxplorer',
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
