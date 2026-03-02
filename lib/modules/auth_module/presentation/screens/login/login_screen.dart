import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fashion_shop/core/resources/image_assets.dart';
import 'package:fashion_shop/core/resources/color_manager.dart';
import 'package:fashion_shop/core/resources/style_manager.dart';
import 'package:fashion_shop/core/resources/font_manager.dart';
import 'package:fashion_shop/core/components/app_button.dart';
import 'package:fashion_shop/core/resources/app_strings.dart';
import 'package:fashion_shop/core/route/route_const.dart';
import 'package:fashion_shop/core/services/services_locator.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/login/login_cubit.dart';
import 'package:fashion_shop/modules/auth_module/presentation/controller/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: cubit.formKey,
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
                    AppStrings.login,
                    style: getBukraBold(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkText,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    AppStrings.loginSubtitle,
                    style: getKaffRegular(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  AppStrings.phone,
                  style: getBukraBold(
                    fontSize: FontSize.s12,
                    color: ColorManager.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorManager.secondary,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                countryListTheme: CountryListThemeData(
                                  borderRadius: BorderRadius.circular(10),
                                  inputDecoration: InputDecoration(
                                    hintText: AppStrings.search,
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onSelect: (country) {
                                  cubit.selectCountry(country);
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.call,
                                    size: 18,
                                    color: ColorManager.secondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${state.selectedCountry.flagEmoji} +${state.selectedCountry.phoneCode}',
                                    style: getKaffRegular(
                                      fontSize: FontSize.s12,
                                      color: ColorManager.hint,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                    color: ColorManager.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: cubit.phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: cubit.phoneLength,
                              style: getKaffRegular(
                                fontSize: FontSize.s12,
                                color: ColorManager.hint,
                              ),
                              decoration: InputDecoration(
                                hintText: AppStrings.phoneNumber,
                                hintStyle: getKaffRegular(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.hint,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                counterText: '',
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (prev, curr) => prev.error != curr.error,
                  builder: (context, state) {
                    if (state.error == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        state.error!,
                        style: getKaffRegular(
                          fontSize: FontSize.s12,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: AppStrings.login,
                  onPressed: () {
                    if (cubit.login()) {
                      Navigator.pushNamed(
                        context,
                        RouteConst.otp,
                        arguments: cubit.fullPhoneNumber,
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteConst.home,
                        (route) => false,
                      );
                    },
                    child: Text(
                      AppStrings.loginAsGuest,
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
      ),
    );
  }
}
