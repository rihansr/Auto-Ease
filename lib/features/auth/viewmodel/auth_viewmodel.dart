import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routing/routes.dart';
import '../../../core/service/analytics_service.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/shared/validator.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../account/viewmodel/account_viewmodel.dart';
import '../model/user_model.dart';

class AuthViewModel extends BaseViewModel {
  final BuildContext context;
  late GlobalKey<FormState> formKey;
  User? user;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  AuthViewModel.login(this.context)
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  AuthViewModel.register(this.context)
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  AuthViewModel.update(this.context) : formKey = GlobalKey<FormState>() {
    user = localStorage.user;
    nameController = TextEditingController(text: user?.name);
    emailController = TextEditingController(text: user?.email);
    _role = user?.role ?? Role.admin;
  }

  Role _role = Role.admin;
  Role get role => _role;
  set role(Role role) => this
    .._role = role
    ..notifyListeners();

  Future<void> register() async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'register');

    await authService.invoke(
      onExecute: (auth) async => auth.createUserWithEmailAndPassword(
        email: validator.string(emailController?.text, orElse: '')!,
        password: validator.string(passwordController?.text, orElse: '')!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await saveUser(credentials.user!.uid);
        context.pop();
        context.pushReplacementNamed(Routes.home);
      },
    );

    setBusy(false, key: 'register');
  }

  Future<void> saveUser(String uid) async {
    final user = User(
      uid: uid,
      name: validator.string(nameController?.text, orElse: '')!,
      email: validator.string(emailController?.text, orElse: '')!,
      role: _role,
    );
    firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection('users').set(
            id: uid,
            data: user.toMap(),
          ),
      onCompleted: (_) {
        provider<AccountViewModel>().user = user;
        analyticsService.logUser(uid);
        analyticsService.logRegister();
      },
    );
  }

  Future<bool> login() async {
    if (!validate(formKey)) return false;
    setBusy(true, key: 'login');
    await authService.invoke(
      onExecute: (auth) async => auth.signInWithEmailAndPassword(
        email: validator.string(emailController?.text, orElse: '')!,
        password: validator.string(passwordController?.text, orElse: '')!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await context.read<AccountViewModel>().userinfo();
        analyticsService.logLogin();
        context.pushReplacementNamed(Routes.home);
      },
    );
    setBusy(false, key: 'login');
    return true;
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
