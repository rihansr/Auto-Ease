import 'package:flutter/material.dart';
import '../../../core/service/analytics_service.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/user_model.dart';

class AuthViewModel extends BaseViewModel {
  late GlobalKey<FormState> formKey;
  User? user;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? secondaryPasswordController;

  AuthViewModel.login()
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  AuthViewModel.register()
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController(),
        secondaryPasswordController = TextEditingController();

  AuthViewModel.update() : formKey = GlobalKey<FormState>() {
    user = localStorage.user;
    nameController = TextEditingController(text: user?.name);
    emailController = TextEditingController(text: user?.email);
  }

  Future<bool> register() async {
    if (!validate(formKey)) return false;
    setBusy(true, key: 'register');
    analyticsService.logRegister();
    setBusy(false, key: 'register');
    return true;
  }

  Future<bool> login() async {
    if (!validate(formKey)) return false;
    setBusy(true, key: 'login');
    analyticsService.logLogin();
    setBusy(false, key: 'login');
    return true;
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    secondaryPasswordController?.dispose();
    super.dispose();
  }
}
