/// Error types enumeration
enum ErrorType {
  network,
  authentication,
  validation,
  permission,
  server,
  unknown,
  timeout,
  offline,
  cultural, // Morocco-specific errors (prayer times, cultural constraints)
}