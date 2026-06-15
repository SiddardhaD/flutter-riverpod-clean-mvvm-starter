/// Lightweight string validators used by form view models.
extension ValidatorExtension on String {
  static final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
  );

  bool get isValidEmail => _emailRegex.hasMatch(trim());

  /// Minimum viable password: at least 6 characters. Tighten as needed.
  bool get isValidPassword => trim().length >= 6;

  bool get isBlank => trim().isEmpty;
  bool get isNotBlank => trim().isNotEmpty;
}
