import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_routes.dart';
import 'package:chat_app/core/utils/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/auth/baseAuthViewModel.dart';
import '../../../viewModel/auth/login_viewModel.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_loginTextFormField.dart';
import '../../widget/custom_passwordTextFormField.dart';
import '../../widget/custom_sign_stack.dart';
import '../../widget/switch_sign_page_widget.dart';
import 'animation/fadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements AuthNavigator {
  late LoginViewModel viewModel;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel = LoginViewModel();
    viewModel.navigator = this;
    // viewModel.checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CustomSignStack(text: "Login"),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.primaryColor,
                                    blurRadius: 10,
                                    offset: Offset(0, 5))
                              ]),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                validator: (value) =>
                                    viewModel.validateEmail(value!),
                                controller: viewModel.emailController,
                                hitText: 'Email',
                                icon: Icons.email_outlined,
                              ),
                              // SizedBox(height: 5,),
                              Consumer<LoginViewModel>(
                                builder: (context, myProvider, child) {
                                  return CustomPasswordTextFormField(
                                    validator: (value) =>
                                        viewModel.validatePassword(value!),
                                    controller: viewModel.passwordController,
                                    onPressed: () {
                                      viewModel.changeSecurePassword();
                                    },
                                    icon: viewModel.securePassword
                                        ? CupertinoIcons.eye_fill
                                        : CupertinoIcons.eye_slash_fill,
                                    obscureText: viewModel.obscureText,
                                  );
                                },
                              ),
                            ],
                          ),
                        ))),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FadeAnimation(
                      1.4,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomButton(
                              text: 'LogIn',
                              onPressed: () {
                                if (formKey.currentState?.validate() == false)
                                  return;
                                viewModel.loginWithEmailAndPassword();
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          SwitchSignPageWidget(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.register.name);
                            },
                            text1: "Don't have account ?",
                            text2: 'Sign Up',
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showLoading() {
    DialogUtils.showProgressDialog(context, 'loading..');
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context, message);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.home.name);
  }
}
