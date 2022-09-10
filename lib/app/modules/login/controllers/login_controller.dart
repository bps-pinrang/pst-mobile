import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginController extends GetxController {
  final FormGroup form = FormGroup({
    'email': FormControl(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),
  });

  @override
  void onClose() {
    form.dispose();
    super.onClose();
  }
}
