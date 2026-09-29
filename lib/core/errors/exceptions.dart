/// Exception thrown when local storage/cache operations fail.
class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

/// Exception thrown when remote server operations fail.
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}
