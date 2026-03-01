import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(
    selectedCountry: Country.parse('SA'),
  ));

  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void selectCountry(Country country) {
    phoneController.clear();
    emit(state.copyWith(selectedCountry: country));
  }

  String? validatePhone(String? value) {
    final country = state.selectedCountry;
    final expectedLength = country.example.replaceAll(RegExp(r'\D'), '').length;

    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }
    if (value.length != expectedLength) {
      return 'Phone number for ${country.name} must be $expectedLength digits';
    }
    return null;
  }

  int get phoneLength {
    return state.selectedCountry.example.replaceAll(RegExp(r'\D'), '').length;
  }

  String get fullPhoneNumber =>
      '+${state.selectedCountry.phoneCode}${phoneController.text}';

  bool login() {
    final error = validatePhone(phoneController.text);
    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    }
    emit(state.copyWith(error: null));
    return true;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
