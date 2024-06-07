import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/models/chat_message_response.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';



import '../core/api_call_status.dart';
import '../core/base_client.dart';
import '../util/app_config.dart';
import '../util/share_pref_helper.dart';

class NatebanzayChatController extends GetxController{
 final Rx<ApiCallStatus> _apiCallStatus = ApiCallStatus.holding.obs;
  ApiCallStatus get apiCallStatus=>_apiCallStatus.value;
  final BaseClient _baseClient = BaseClient();
     final RxList<ChatMessage> _messages = RxList.empty();
  List<ChatMessage> get messages => _messages.toList();
  final RxInt _chatId=RxInt(0);
  int get chatId=> _chatId.value;
   final ScrollController scrollController = ScrollController();



 void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
      0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


  Future<void> sendMessage(BuildContext context,int chatId,int senderId,int receiverId,String message) async {
    await _baseClient.safeApiCall(
      AppConfig.sendMessageUrl, // url
      RequestType.post,  
      
      data: FormData.fromMap({
         'chat_id':chatId,
        'sender_id':senderId,
        'receiver_id':receiverId,
        'message':message
      }),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) {
        _apiCallStatus.value = ApiCallStatus.success;
      ToastHelper.showSuccessToast(context, response.data['message']);
     
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        // BaseClient.handleApiError(apiException: error);

      },
    );
  }


  Future<void> getChat(int requesterId,int uploaderId) async {
    await _baseClient.safeApiCall(
      "${AppConfig.chatUrl}/", // url
      RequestType.get,  
      
      queryParameters: {
        'requester_id':requesterId,
        'uploader_id':uploaderId
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
            EasyLoading.show(status: "ခေတ္တစောင့်ဆိုင်းပေးပါ") ;

        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.success;
        _chatId.value=response.data['data']['id'];
        initPusher(response.data['data']['id']);
      getMessages(response.data['data']['id']);
       scrollToBottom(); 
     
      },

      onError: (error) {
        EasyLoading.dismiss();
        _apiCallStatus.value = ApiCallStatus.error;
        // BaseClient.handleApiError(apiException: error);

      },
    );
  }


  Future<void> getMessages(int chatId) async {
    await _baseClient.safeApiCall(
      "${AppConfig.messagesUrl}/$chatId", // url
      RequestType.get,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${MySharedPref.getToken()}",
      },

      onLoading: () {
        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) {
        _apiCallStatus.value = ApiCallStatus.success;

        ChatMessageResponse chatMessageResponse = ChatMessageResponse.fromJson(response.data);
        _messages.value = chatMessageResponse.data;
     
      },

      onError: (error) {
        _apiCallStatus.value = ApiCallStatus.error;
        BaseClient.handleApiError(apiException: error);

      },
    );
  }

  initPusher(int chatId)async{
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
try {
  await pusher.init(
    apiKey: "c086f9e951e5e4555449",
    cluster: "ap1",
    // onConnectionStateChange: onConnectionStateChange,
    // onError: onError,
    onSubscriptionSucceeded: onSubscriptionSucceeded,
    onEvent: onEvent,
    onSubscriptionError: onSubscriptionError,
    onDecryptionFailure: onDecryptionFailure,

    onAuthorizer: onAuthorizer
  );
  await pusher.subscribe(channelName:'private-chat$chatId');
  
  
  await pusher.connect();
} catch (e) {
  print("ERROR: $e");
}
  }

 dynamic onAuthorizer(
      String channelName, String socketId, dynamic options) async {
   
    var authUrl = "${AppConfig.baseUrl}/api/user/pusher/auth";
    var result = await http.post(
      Uri.parse(authUrl),
        headers: {
        'Accept': 'application/json',
          'Authorization': 'Bearer ${MySharedPref.getToken()}', // Use the correct token
        },
        body:{
           'socket_id': socketId,
          'channel_name': channelName,
        }
    );
    var res = jsonDecode(result.body);
    print("FF $res");
    return res;
  }


  void onError(String message, int code, Exception e) {
    log("Connection error: $message");
  }

    void onSubscriptionSucceeded(String channelName, dynamic data) {
      print("Data $data");
    log("Subscription succeeded: $channelName");
  }

void onEvent(PusherEvent event) {
    log("onEvent: $event");
    try {
      if (event.eventName == 'message.sent') { // Replace with your event name
        final data = json.decode(event.data);
        print(data['message']) ;
        final chatMessage = ChatMessage.fromJson(data);
        _messages.add(chatMessage);
        // Update UI to display the new message (likely using GetX)
      }
    } catch (e) {
      log("Error processing event data: $e");
    }
  }

  void onSubscriptionError(String message, dynamic e) {
    log("Subscription error: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("Decryption failure: $event, $reason");
  }

  void onMemberAdded(PusherMember member) {
    log("Member added: ${member.userId}");
  }

  void onMemberRemoved(PusherMember member) {
    log("Member removed: ${member.userId}");
  }

  void onSubscriptionCount(int count) {
    log("Subscription count: $count");
  }

@override
  void onInit() {
  //  initPusher();
    super.onInit();
  }

}