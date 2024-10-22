import 'package:autoease/core/service/firestore_service.dart';
import 'package:flutter/material.dart';

import '../../../core/shared/validator.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../booking/model/service_model.dart';

class ServiceViewModel extends BaseViewModel {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  Service? service;

  ServiceViewModel(this.context, [this.service])
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(text: service?.name),
        priceController =
            TextEditingController(text: service?.price.toStringAsFixed(2));

  Future<void> saveService() async {
    if (!validate(formKey)) return;
    setBusy(true, key: 'saving_service');

    final service = Service(
      uid: this.service?.uid ?? firestoreService.uniqueId,
      name: validator.string(nameController.text)!,
      price: num.tryParse(priceController.text) ?? 0,
    );

    await firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection('services').set(
            id: service.uid,
            data: service.toMap(),
          ),
      onCompleted: (_) async {
        Navigator.pop(context, service);
      },
    );

    setBusy(false, key: 'saving_service');
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
