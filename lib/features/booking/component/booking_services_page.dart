import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/listview_builder_widget.dart';
import '../model/service_model.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../widget/page_view_builder.dart';

class BookingServicesPage extends StatelessWidget {
  const BookingServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.read<BookingViewModel>();
    final controller = context.watch<BookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[3],
      title: string.of(context).bookingServices,
      action: Button(
        label: string.of(context).next,
        onPressed: () => controller.nextPage(),
      ),
      children: [
        ListViewBuilder(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          items: listener.services,
          loading: listener.isLoading(key: 'fetching_services', orElse: false),
          skeletonItems: List.filled(5, const Service(uid: '', title: 'title')),
          itemBuilder: (i, service) => CheckboxListTile(
            key: ValueKey(i),
            title: Text(service.title),
            value: controller.bookingServices.contains(service),
            onChanged: (_) => controller.toggleService(service),
          ),
        ),
      ],
    );
  }
}
