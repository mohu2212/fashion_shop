import 'package:country_picker/country_picker.dart';

class LoginState {
  final Country selectedCountry;
  final bool isLoading;
  final String? error;

  LoginState({
    Country? selectedCountry,
    this.isLoading = false,
    this.error,
  }) : selectedCountry = selectedCountry ?? Country.parse('SA');

  LoginState copyWith({
    Country? selectedCountry,
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
