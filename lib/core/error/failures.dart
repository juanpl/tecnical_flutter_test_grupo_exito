abstract class Failure {}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class UnexpectedError extends Failure {}

class SaveLocalDataError extends Failure {}

class DeleteLocalDataError extends Failure {}

class LocalFailure extends Failure {}

