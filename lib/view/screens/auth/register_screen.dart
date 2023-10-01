import 'package:chat_app/core/app_routes.dart';
import 'package:chat_app/core/utils/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../viewModel/auth/baseAuthViewModel.dart';
import '../../../viewModel/auth/register_viewModel.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_loginTextFormField.dart';
import '../../widget/custom_passwordTextFormField.dart';
import '../../widget/custom_sign_stack.dart';
import '../../widget/switch_sign_page_widget.dart';
import 'animation/fadeAnimation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements AuthNavigator {
  late RegisterViewModel viewModel;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    viewModel = RegisterViewModel();
    viewModel.navigator = this;
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
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomSignStack(text: 'Register'),
                const SizedBox(
                  height: 15,
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
                                    viewModel.validateUserName(value!),
                                controller: viewModel.userNameController,
                                hitText: 'UserName',
                                icon: Icons.person_outlined,
                              ),
                              CustomTextFormField(
                                validator: (value) =>
                                    viewModel.validateEmail(value!),
                                controller: viewModel.emailController,
                                hitText: 'Email',
                                icon: Icons.email_outlined,
                              ),
                              // SizedBox(height: 5,),
                              Consumer<RegisterViewModel>(
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
                              CustomTextFormField(
                                validator: (value) =>
                                    viewModel.validateConfirmPassword(value!),
                                hitText: 'Confirm Password',
                                icon: Icons.password,
                                controller: viewModel.confirmPasswordController,
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
                              text: 'Register',
                              onPressed: () {
                                if (formKey.currentState?.validate() == false)
                                  return;
                                viewModel.registerWithEmailAndPassword();
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          SwitchSignPageWidget(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.login.name);
                            },
                            text1: "Already have account ?",
                            text2: 'Sign In',
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
  void showLoading() {
    DialogUtils.showProgressDialog(context, 'Loading');
  }

  @override
  void hideLoading() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showMessage(String m) {
    DialogUtils.showMessage(context, m);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.home.name);
  }
}
