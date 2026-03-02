import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/components/app_button.dart';
import 'package:fashion_shop/core/components/custom_app_bar.dart';
import 'package:fashion_shop/core/components/loading_overlay.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/core/services/services_locator.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/otp/otp_cubit.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/otp/otp_state.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber =
        ModalRoute.of(context)!.settings.arguments as String? ?? '';

    return BlocProvider(
      create: (_) => sl<OtpCubit>(param1: phoneNumber),
      child: const _OtpView(),
    );
  }
}

class _OtpView extends StatelessWidget {
  const _OtpView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.verification),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: SvgPicture.asset(
                  ImageAssets.iconSvg,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  AppStrings.verification,
                  style: getBukraBold(
                    fontSize: FontSize.s14,
                    color: ColorManager.darkText,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Enter the verification code sent to\n${cubit.phoneNumber}',

                  style: getKaffRegular(
                    fontSize: FontSize.s14,
                    color: ColorManager.darkText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<OtpCubit, OtpState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: List.generate(4, (index) {
                          return Expanded(
                            child: Container(
                            height: 60,
                            margin: EdgeInsets.only(
                              left: index == 0 ? 0 : 8,
                              right: index == 3 ? 0 : 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: state.otpDigits[index].isNotEmpty
                                    ? ColorManager.primary
                                    : ColorManager.secondary,
                                width: 1,
                              ),
                            ),
                            child: KeyboardListener(
                              focusNode: FocusNode(),
                              onKeyEvent: (event) {
                                if (event is KeyDownEvent &&
                                    event.logicalKey ==
                                        LogicalKeyboardKey.backspace) {
                                  cubit.onKeyBackspace(index);
                                }
                              },
                              child: TextField(
                                controller: cubit.controllers[index],
                                focusNode: cubit.focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: getKaffRegular(
                                  fontSize: FontSize.s20,
                                  color: ColorManager.hint,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: AppStrings.otpHint,
                                  hintStyle: getKaffRegular(
                                    fontSize: FontSize.s20,
                                    color: ColorManager.hint,
                                  ),
                                ),
                                onChanged: (value) {
                                  cubit.onDigitChanged(index, value);
                                },
                              ),
                            ),
                          ),
                          );
                        }),
                      ),
                      if (state.error != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          state.error!,
                          style: getKaffRegular(
                            fontSize: FontSize.s12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              AppButton(
                text: AppStrings.verify,
                onPressed: () async {
                  if (!cubit.validateCode()) return;
                  LoadingOverlay.show(context);
                  await cubit.saveLogin();
                  LoadingOverlay.hide();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteConst.home,
                      (route) => false,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Resend code
                  },
                  child: Text(
                    AppStrings.resendCode,
                    style: getBukraBold(
                      fontSize: FontSize.s12,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
