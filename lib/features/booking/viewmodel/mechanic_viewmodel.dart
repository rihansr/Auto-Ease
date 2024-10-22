import '../../../core/shared/enums.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';

class MechanicViewModel extends AuthViewModel {
  MechanicViewModel(super.context) : super.register() {
    super.role = Role.mechanic;
  }
}
