import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BackdropFilter(
          filter: style.defaultBlur,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Transform.rotate(
                        angle: 0.785398,
                        child: const Icon(Iconsax.add, size: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
