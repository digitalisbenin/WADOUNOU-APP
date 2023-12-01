class ValidationMessage {
  bool valid;
  String? message;

  get invalid => !valid;

  ValidationMessage({this.valid = false, this.message});

  void setError(String message) {
    this.message = message;
    valid = false;
  }

  void setValid() {
    message = null;
    valid = true;
  }
}
