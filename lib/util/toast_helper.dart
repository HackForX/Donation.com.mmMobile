import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';

class ToastHelper {
  static void showErrorToast(BuildContext context, String message) {
    ShowMToast showMToast = ShowMToast(context);
    showMToast.errorToast(message: message, alignment: Alignment.bottomCenter);
  }

  static void showSuccessToast(BuildContext context, String message) {
    ShowMToast showMToast = ShowMToast(context);
    showMToast.successToast(
        message: message, alignment: Alignment.bottomCenter);
  }
}
