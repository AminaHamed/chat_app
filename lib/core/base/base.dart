import 'package:flutter/material.dart';

import '../utils/dialog_utils.dart';

abstract class BaseNavigator {
  void showLoading();

  void showMessage(String message);

  void hideLoading();
}

abstract class BaseViewModel<N extends BaseNavigator>extends ChangeNotifier {
N? navigator;
}

abstract class BaseState<T extends StatefulWidget,vm extends BaseViewModel> extends State<T> implements BaseNavigator {
late vm viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;

  }

  vm initViewModel(); 

  

  @override
  void hideLoading() {
    DialogUtils.hideDialog(context);
  }

  @override
  void showLoading() {
    DialogUtils.showProgressDialog(context, 'Loading');
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context, message);
  }



  
}

