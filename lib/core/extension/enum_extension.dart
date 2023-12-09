extension EnumExtension on Enum {
  String toSnakeCase() {
    return toString().replaceAllMapped(RegExp('([A-Z])'), (match) => '_${match[0]}').toLowerCase();
  }
}
