import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  matchPassword(String confirmPassword, {String? message}) => add((value) {
        print(value);
        print(confirmPassword);
        if (value != confirmPassword) {
          return message ?? 'Password is not matching';
        }
        return null;
      });
}
