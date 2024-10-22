import 'package:flutter/material.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/card_box_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../../booking/model/service_model.dart';
import '../../booking/widget/decimal_text_input_formatter.dart';
import '../viewmodel/service_viewmodel.dart';

class NewServiceView extends StatelessWidget {
  final Service? service;

  const NewServiceView({
    super.key,
    this.service,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseWidget<ServiceViewModel>(
      model: ServiceViewModel(context, service),
      onDispose: (controller) => controller.dispose(),
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: Backdrop(
          child: SafeArea(
            child: Form(
              key: controller.formKey,
              child: CardBox(
                children: [
                  Text(
                    string.of(context).newService,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFieldWidget(
                    controller: controller.nameController,
                    title: string.of(context).name,
                    autoValidate: controller.enabledAutoValidate,
                    validator: (value) => validator.validateField(value),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                  TextFieldWidget(
                    controller: controller.priceController,
                    title: string.of(context).price,
                    autoValidate: controller.enabledAutoValidate,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalDigits: 2)
                    ],
                    validator: (value) => validator.validateField(value),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    onPressed: () => controller.saveService(),
                    loading: controller.isLoading(
                        key: 'saving_service', orElse: false),
                    label: string.of(context).save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
