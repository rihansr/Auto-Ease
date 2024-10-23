import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/listview_builder_widget.dart';
import '../../service/view/new_service_view.dart';
import '../model/service_model.dart';
import '../viewmodel/create_booking_viewmodel.dart';
import '../widget/page_view_builder.dart';

class BookingServicesPage extends StatelessWidget {
  const BookingServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.read<CreateBookingViewModel>();
    final controller = context.watch<CreateBookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[3],
      title: string.of(context).bookingServices,
      action: Button(
        label: string.of(context).next,
        onPressed: controller.nextPage,
      ),
      children: [
        ListViewBuilder(
          scrollPhysics: const NeverScrollableScrollPhysics(),
          items: listener.services,
          loading: listener.isLoading(key: 'fetching_services', orElse: false),
          skeletonItems: List.filled(5, const Service(uid: '', name: 'title')),
          itemBuilder: (i, service) => CheckboxListTile(
            key: ValueKey(i),
            contentPadding: const EdgeInsets.all(0),
            title: Text(service.name),
            value: controller.bookedServices.contains(service),
            onChanged: (_) => controller.selectedService = service,
          ),
        ),
        TextButton.icon(
          onPressed: () => showCupertinoModalPopup(
            context: context,
            barrierDismissible: false,
            builder: (context) => const NewServiceView(),
          ).then(
            (service) {
              if (service != null) controller.service = service;
            },
          ),
          icon: const Icon(Icons.add),
          label: Text(string.of(context).newService),
        )
      ],
    );
  }
}
