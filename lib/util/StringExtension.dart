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