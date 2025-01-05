// application exception class
class AppException implements Exception{

  final _prefix;
  final _message;

  AppException(this._prefix, this._message);

  @override
  String toString(){
    return '$_prefix : $_message';
  }
}

// All the possible exception that we are facing in our application
class FetchDataException extends AppException{
  FetchDataException(String? message) : super("Error During Communication",message);
}

class BadRequestException extends AppException{
  BadRequestException(String? message) : super("Invalid Request",message);
}

class UnauthorizedException extends AppException{
  UnauthorizedException(String? message) : super("Unauthorized Request",message);
}

class InvalidInputException extends AppException{
  InvalidInputException(String? message) : super("Invalid Input",message);
}


