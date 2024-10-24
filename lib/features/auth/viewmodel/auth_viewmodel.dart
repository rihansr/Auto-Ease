import 'dart:async';
import 'package:autoease/core/shared/strings.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/validator.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/user_model.dart';

class AuthViewModel extends BaseViewModel {
  final BuildContext context;
  late GlobalKey<FormState> formKey;
  User? user;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? passwordController;

  AuthViewModel.login(this.context)
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

  AuthViewModel.register(this.context)
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(),
        emailController = TextEditingController(),
        phoneController = TextEditingController(),
        passwordController = TextEditingController();

  AuthViewModel.forgetPass(this.context)
      : formKey = GlobalKey<FormState>(),
        emailController = TextEditingController();

  AuthViewModel.update(this.context, this.user)
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(text: user?.name),
        emailController = TextEditingController(text: user?.email),
        phoneController = TextEditingController(text: user?.phone),
        role = user?.role ?? Role.admin;

  Role role = Role.admin;
  set userRole(Role role) => this
    ..role = role
    ..notifyListeners();

  Future<void> signUp({
    bool isolatedAuth = false,
    required FutureOr Function(auth.User) onSuccess,
  }) async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'signing_up');

    await authService.invoke(
      isolatedAuth: isolatedAuth,
      onExecute: (auth) async => auth.createUserWithEmailAndPassword(
        email: validator.string(emailController)!,
        password: validator.string(passwordController)!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await onSuccess(credentials.user!);
      },
    );

    setBusy(false, key: 'signing_up');
  }

  Future<void> saveUser({
    String? uid,
    required FutureOr Function(User) onSuccess,
  }) async {
    if (!validate(formKey)) return;

    setBusy(true, key: 'saving_user');

    uid ??= firestoreService.uniqueId;
    final user = User(
      uid: uid,
      name: validator.string(nameController)!,
      phone: validator.string(phoneController, orElse: null)!,
      email: validator.string(emailController)!,
      role: role,
    );
    firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection(role.table).set(
                id: uid!,
                data: user.toMap(),
              ),
      onCompleted: (_) async {
        await onSuccess.call(user);
      },
    );
    setBusy(false, key: 'saving_user');
  }

  Future<void> signIn({
    bool isolatedAuth = false,
    required FutureOr Function(auth.User) onSuccess,
  }) async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'signing_in');
    await authService.invoke(
      isolatedAuth: isolatedAuth,
      onExecute: (auth) async => auth.signInWithEmailAndPassword(
        email: validator.string(emailController)!,
        password: validator.string(passwordController)!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await onSuccess(credentials.user!);
      },
    );
    setBusy(false, key: 'signing_in');
  }

  Future<void> forgetPassword({
    required FutureOr Function() onSuccess,
  }) async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'sending_reset_email');
    await authService.invoke(
      onExecute: (auth) async => await auth.sendPasswordResetEmail(
        email: validator.string(emailController)!,
      ),
      onCompleted: (_) async {
        showMessage(string.of(context).resetEmailSent);
        await onSuccess.call();
      },
    );
    setBusy(false, key: 'sending_reset_email');
  }

  Future<void> updateAccount({
    required FutureOr Function(User) onSuccess,
  }) async {
    if (!validate(formKey) || this.user == null) return;

    setBusy(true, key: 'updating_account');

    final user = this.user!.copyWith(
          name: validator.string(nameController)!,
          phone: validator.string(phoneController)!,
          email: validator.string(emailController, orElse: null)!,
          role: role,
        );
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection(role.table).update(
                id: user.uid!,
                data: user.toMap(),
              ),
      onCompleted: (_) async {
        await onSuccess.call(user);
      },
    );

    setBusy(false, key: 'updating_account');
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    phoneController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }
}
