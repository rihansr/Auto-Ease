import 'package:flutter/material.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../component/booking_info_page.dart';
import '../component/booking_services_page.dart';
import '../component/car_info_page.dart';
import '../component/customer_info_page.dart';
import '../component/mechanic_info_view.dart';
import '../model/booking_model.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../widget/page_indicator.dart';

class NewBookingView extends StatelessWidget {
  final Booking? booking;

  const NewBookingView({
    super.key,
    this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BookingViewModel>(
      model: BookingViewModel(context, booking),
      onInit: (controller) => controller.init(),
      onDispose: (controller) => controller.dispose(),
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => controller.previousPage(),
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Backdrop(
          child: SafeArea(
            bottom: false,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: const [
                BookingInfoPage(
                  key: PageStorageKey("booking_info_page"),
                ),
                CustomerInfoPage(
                  key: PageStorageKey("customer_info_page"),
                ),
                CarInfoPage(
                  key: PageStorageKey("car_info_page"),
                ),
                BookingServicesPage(
                  key: PageStorageKey("booking_services_page"),
                ),
                MechanicInfoPage(
                  key: PageStorageKey("mechanic_info_page"),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PageIndicator(
              controller: controller.pageController,
              count: 5,
            ),
            SizedBox(height: dimen.bottom(24)),
          ],
        ),
      ),
    );
  }
}
