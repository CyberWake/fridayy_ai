class Validate {
  static String? validatePhoneNumber(String? number) {
    return number?.isEmpty ?? true
        ? 'Phone number is required field'
        : number?.length != 10
            ? 'Phone number should have 10 digits'
            : null;
  }

  static String? validateName(String? number) {
    return number?.isEmpty ?? true ? 'Name cannot be empty' : null;
  }
}
