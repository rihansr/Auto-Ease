import 'dart:async';
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
    required FutureOr Function(auth.User) onSuccess,
  }) async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'signing_up');

    await authService.invoke(
      onExecute: (auth) async => auth.createUserWithEmailAndPassword(
        email: validator.string(emailController?.text, orElse: '')!,
        password: validator.string(passwordController?.text, orElse: '')!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await onSuccess(credentials.user!);
      },
    );

    setBusy(false, key: 'signing_up');
  }

  Future<void> saveUser({
    required String uid,
    required FutureOr Function(User) onSuccess,
  }) async {
    final user = User(
      uid: uid,
      name: validator.string(nameController?.text, orElse: '')!,
      phone: validator.string(phoneController?.text, orElse: '')!,
      email: validator.string(emailController?.text, orElse: '')!,
      role: role,
    );
    firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection(role.table).set(
            id: uid,
            data: user.toMap(),
          ),
      onCompleted: (_) async {
        await onSuccess.call(user);
      },
    );
  }

  Future<void> signIn({
    required FutureOr Function(auth.User) onSuccess,
  }) async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'signing_in');
    await authService.invoke(
      onExecute: (auth) async => auth.signInWithEmailAndPassword(
        email: validator.string(emailController?.text, orElse: '')!,
        password: validator.string(passwordController?.text, orElse: '')!,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        await onSuccess(credentials.user!);
      },
    );
    setBusy(false, key: 'signing_in');
  }

  Future<void> updateAccount({
    required FutureOr Function(User) onSuccess,
  }) async {
    if (!validate(formKey) || this.user == null) return;
    final user = this.user!.copyWith(
          name: validator.string(nameController?.text, orElse: '')!,
          phone: validator.string(phoneController?.text, orElse: '')!,
          email: validator.string(emailController?.text, orElse: '')!,
          role: role,
        );
    firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection(role.table).update(
            id: user.uid,
            data: user.toMap(),
          ),
      onCompleted: (_) async {
        await onSuccess.call(user);
      },
    );
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
