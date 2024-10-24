import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';
import '../../../core/shared/drawables.dart';
import '../model/booking_model.dart';

class ReceiptGenerator {
  final Booking booking;
  late MemoryImage logo;

  ReceiptGenerator({
    required this.booking,
  });

  Future<Uint8List> generate() async {
    logo = MemoryImage(
      (await rootBundle.load(drawable.receiptLogo)).buffer.asUint8List(),
    );

    final pdf = Document(
      theme: ThemeData.withFont(
        icons: await PdfGoogleFonts.materialIcons(),
      ),
    );

    pdf.addPage(
      MultiPage(
        build: (context) => [
          _buildHeader(),
          _buildJobDetails(),
          _buildCustomerAndMechanicDetails(),
          _buildCarDetails(),
          _buildServices(),
          _buildMechanicNote(),
        ],
      ),
    );

    return await pdf.save();
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(logo, height: 48),
        SizedBox(height: 20),
        Text(
          'Receipt',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildJobDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Booking ID: ${booking.uid}'),
        Text(
          'Date & Time: ${DateFormat("EEEE, MMM d 'at' hh:mm a").format(booking.bookedAt)}',
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCustomerAndMechanicDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Name:  ${booking.customer.name ?? 'N/A'}'),
              Text('Phone:  ${booking.customer.phone ?? 'N/A'}'),
              Text('Email:  ${booking.customer.email ?? 'N/A'}'),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mechanic',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Name:  ${booking.mechanic?.name ?? 'N/A'}'),
              Text('Phone:  ${booking.mechanic?.phone ?? 'N/A'}'),
              Text('Email:  ${booking.mechanic?.email ?? 'N/A'}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          'Car Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: [booking.carDetails.make, booking.carDetails.model]
                    .join(' '),
              ),
              if (booking.carDetails.year != null)
                TextSpan(
                  text: ' (${booking.carDetails.year})',
                ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(booking.carDetails.plate),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Services',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TableHelper.fromTextArray(
          cellAlignments: {
            0: Alignment.centerLeft,
            1: Alignment.center,
            2: Alignment.center,
          },
          data: <List<String>>[
            <String>['Service', 'Status', 'Price'],
            ...booking.services.map((service) => [
                  service.name,
                  service.isCompleted ?? false ? 'Completed' : 'Pending',
                  '\$${service.price.toString()}',
                ]),
          ],
        ),
        SizedBox(height: 20),
        Text('Total: \$${booking.total}', textAlign: TextAlign.right),
        SizedBox(height: 4),
        Text('Due: \$${booking.total}', textAlign: TextAlign.right),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMechanicNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mechanic Note',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(booking.notes ?? 'No notes provided'),
        SizedBox(height: 20),
      ],
    );
  }
}
