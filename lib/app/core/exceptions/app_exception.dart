class AppException implements Exception {
  AppException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException( this.message, this.prefix);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException( String message)
      : super(message, 'Kesalahan saat menghubungkan: ');
}

class BadRequestException extends CustomException {
  BadRequestException(String message) : super(message, 'Permintaan Tidak Valid: ');
}

class UnauthorizedException extends CustomException {
  UnauthorizedException(String message) : super(message, 'Tidak Diizinkan: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException(String message) : super(message, 'Masukan Tidak Valid: ');
}
