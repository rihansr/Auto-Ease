import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReceiptPreview extends StatelessWidget {
  final FutureOr<Uint8List> Function(PdfPageFormat) generator;
  const ReceiptPreview({
    super.key,
    required this.generator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PdfPreview(
      previewPageMargin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      allowPrinting: true,
      canChangeOrientation: false,
      canDebug: false,
      canChangePageFormat: false,
      actions: [
        PdfPreviewAction(
          icon: const Icon(CupertinoIcons.clear),
          onPressed: (context, build, pageFormat) {
            context.pop();
          },
        ),
      ],
      pdfFileName: 'Export_${DateTime.now().millisecondsSinceEpoch}',
      loadingWidget: CupertinoActivityIndicator(
        color: theme.colorScheme.primary,
      ),
      actionBarTheme: PdfActionBarTheme(
        backgroundColor: theme.scaffoldBackgroundColor,
        iconColor: theme.iconTheme.color,
        textStyle: theme.textTheme.bodyLarge,
      ),
      build: generator,
    );
  }
}
