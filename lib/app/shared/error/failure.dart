class Failure {
  final String? message;

  Failure({this.message});

  @override
  bool operator ==(Object other) {
    return other is Failure;
  }

  @override
  int get hashCode => 0;
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({super.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class InternetConnectionFailure extends Failure {
  InternetConnectionFailure({super.message});
}

class LocalStorageFailure extends Failure {
  LocalStorageFailure({super.message});
}

class DataParsingFailure extends Failure {
  DataParsingFailure({super.message});
}

class InputFailure extends Failure {
  InputFailure({super.message});
}

class PermissionFailure extends Failure {
  PermissionFailure({super.message});
}
