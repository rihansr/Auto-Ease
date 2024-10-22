import '../../../core/shared/enums.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';

class CustomerViewModel extends AuthViewModel {
  CustomerViewModel(super.context) : super.register() {
    super.role = Role.customer;
  }
}
