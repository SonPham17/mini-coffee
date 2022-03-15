class TimeOutException implements Exception {
  String? message;
  String? errorText;

  TimeOutException(
      {this.message = 'Something error', this.errorText});
}
