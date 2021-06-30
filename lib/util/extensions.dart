extension StringExtension on String {
  String capitalize() {
    // print("se $this");
    if(this != null) {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
    return "";
  }
  // String get capitalize =>
  //     this != null ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  //
  // String get capitalizeFirstOfEach => this
  //     .replaceAll(RegExp(' +'), ' ')
  //     .split(" ")
  //     .map((str) => str.capitalize)
  //     .join(" ");
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}