import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/models/chat_message_response.dart';
import 'package:donation_com_mm_v2/models/notification_response.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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
        _apiCallStatus.value = ApiCallStatus.loading;
   
      },
      onSuccess: (response) {
        _apiCallStatus.value = ApiCallStatus.success;
        _chatId.value=response.data['data']['id'];
      getMessages(response.data['data']['id']);
     
      },

      onError: (error) {
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

//   initPusher()async{
//     PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
// try {
//   await pusher.init(
//     apiKey: "c086f9e951e5e4555449",
//     cluster: "ap1",
//     // onConnectionStateChange: onConnectionStateChange,
//     // onError: onError,
//     onSubscriptionSucceeded: onSubscriptionSucceeded,
//     onEvent: onEvent,
//     onSubscriptionError: onSubscriptionError,
//     onDecryptionFailure: onDecryptionFailure,
//     // onMemberAdded: onMemberAdded,
//     // onMemberRemoved: onMemberRemoved,
//     // authEndpoint: "<Your Authendpoint>",
//     // onAuthorizer: onAuthorizer
//   );
//   await pusher.subscribe(channelName: 'chat');
//   await pusher.connect();
// } catch (e) {
//   print("ERROR: $e");
// }
//   }

  //   void onConnectionStateChange(ConnectionStateChange state) {
  //   log("Connection state changed: ${state.currentState}");
  // }

  // void onError(String message, int code, Exception e) {
  //   log("Connection error: $message");
  // }

  //   void onSubscriptionSucceeded(String channelName, dynamic data) {
  //     print("Data ${data}");
  //   log("Subscription succeeded: $channelName");
  // }

  // void onEvent(PusherEvent event) {
  //   log("Received event: ${event.eventName}");
  //   try {
  //     if (event.eventName == 'pusher:subscription_succeeded') {
  //       print("Datadsfd ${event.data}");
  //       final data = json.decode(event.data);
  //       print("Event ${data}");
  //       final chatMessage = ChatMessage.fromJson(data);
  //       _messages.add(chatMessage);
  //     }
  //   } catch (e) {
  //     log("Error processing event data: $e");
  //   }
  // }


  // void onSubscriptionError(String message, dynamic e) {
  //   log("Subscription error: $message");
  // }

  // void onDecryptionFailure(String event, String reason) {
  //   log("Decryption failure: $event, $reason");
  // }

  // void onMemberAdded(PusherMember member) {
  //   log("Member added: ${member.userId}");
  // }

  // void onMemberRemoved(PusherMember member) {
  //   log("Member removed: ${member.userId}");
  // }

  // void onSubscriptionCount(int count) {
  //   log("Subscription count: $count");
  // }

@override
  void onInit() {
  //  initPusher();
    super.onInit();
  }

}