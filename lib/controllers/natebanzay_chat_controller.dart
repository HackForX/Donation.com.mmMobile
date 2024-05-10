import 'package:dio/dio.dart';
import 'package:donation_com_mm_v2/models/chat_message_response.dart';
import 'package:donation_com_mm_v2/models/notification_response.dart';
import 'package:donation_com_mm_v2/util/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



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


}