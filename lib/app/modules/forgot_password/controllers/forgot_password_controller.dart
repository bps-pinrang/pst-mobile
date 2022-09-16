import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordController extends GetxController {
  final client = Supabase.instance.client;

  final form = FormGroup({
    kFormKeyEmail: FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ])
  });

  final isProcessing = false.obs;

  Future<void> sendPasswordResetEmail() async {
    try {
      isProcessing.value = true;
      final result = await client.auth.api.resetPasswordForEmail(
        form.control(kFormKeyEmail).value,
        options: AuthOptions(
          redirectTo: 'io.supabase.pst_mobile://reset-callback/',
        ),
      );

      if (result.statusCode == 200) {
        showGetSnackBar(
          title: 'Berhasil!',
          message: 'Silahkan periksa email anda!',
          variant: 'success',
        );
      }
    } catch (e) {
      showGetSnackBar(
        title: 'Gagal!',
        message: 'Terjadi kesalahan saat mengirim email: ${e.toString()}',
        variant: 'error',
      );
    } finally {
      isProcessing.value = false;
    }
  }

  @override
  void onClose() {
    form.dispose();
    super.onClose();
  }
}
