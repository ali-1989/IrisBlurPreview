class BlurHashDecodeException implements Exception {
  final String message;

  BlurHashDecodeException([String? message,]) : message = message ?? '';

  @override
  String toString() => 'Exception: $message';
}
///=============================================================================================
class BlurHashEncodeException implements Exception {
  final String message;

  BlurHashEncodeException([String? message,]) : message = message ?? '';

  @override
  String toString() => 'Exception: $message';
}