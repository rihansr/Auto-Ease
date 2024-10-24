import 'package:flutter/material.dart';

import '../../../core/shared/strings.dart';
import '../../../core/shared/styles.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';

class AddNotesView extends StatefulWidget {
  const AddNotesView({super.key});

  @override
  State<AddNotesView> createState() => _AddNotesViewState();
}

class _AddNotesViewState extends State<AddNotesView> {
  late TextEditingController _notesController;

  @override
  void initState() {
    _notesController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: style.defaultBlur,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldWidget(
            controller: _notesController,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 16),
          Button(
            label: string.of(context).complete,
            onPressed: () => Navigator.pop(
              context,
              validator.string(_notesController, orElse: null),
            ),
          )
        ],
      ),
    );
  }
}
