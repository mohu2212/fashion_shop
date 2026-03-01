class OtpState {
  final List<String> otpDigits;
  final bool isLoading;
  final String? error;

  OtpState({
    this.otpDigits = const ['', '', '', ''],
    this.isLoading = false,
    this.error,
  });

  String get otpCode => otpDigits.join();

  OtpState copyWith({
    List<String>? otpDigits,
    bool? isLoading,
    String? error,
  }) {
    return OtpState(
      otpDigits: otpDigits ?? this.otpDigits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
