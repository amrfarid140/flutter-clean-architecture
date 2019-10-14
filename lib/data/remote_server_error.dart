class RemoteServerError extends Error {
  String message;
  RemoteServerError(this.message);
}