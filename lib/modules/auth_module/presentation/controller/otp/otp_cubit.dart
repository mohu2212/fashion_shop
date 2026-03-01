import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashion_shop/core/data/local/app_data.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/otp/otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({required this.phoneNumber}) : super(OtpState());

  final String phoneNumber;
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  void onDigitChanged(int index, String value) {
    if (value.length > 1) {
      value = value[value.length - 1];
      controllers[index].text = value;
    }

    final digits = List<String>.from(state.otpDigits);
    digits[index] = value;
    emit(state.copyWith(otpDigits: digits, error: null));

    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
  }

  void onKeyBackspace(int index) {
    if (controllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  bool validateCode() {
    final code = state.otpCode;
    if (code.length != 4) {
      emit(state.copyWith(error: 'Please enter the full code'));
      return false;
    }
    if (code != '0000') {
      emit(state.copyWith(error: 'Invalid verification code'));
      return false;
    }
    return true;
  }

  Future<void> saveLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    await AppData.saveLogin(phoneNumber);
  }

  @override
  Future<void> close() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    return super.close();
  }
}
