import 'package:get/get.dart';
import 'validation_message.dart';

extension RxValidationMessageExtension on Rx<ValidationMessage> {
  get message => value.message;
  get valid => value.valid;
  get invalid => value.invalid;

  setError(String message) {
    value.valid = false;
    value.message = message;
    refresh();
  }

  setValid() {
    value.valid = true;
    value.message = null;
    refresh();
  }
}
