class FirestoreApiException implements Exception {
  final String message;
  final String? devDetails;
  final String? orettyDetails;

  FirestoreApiException(
      {required this.message, this.devDetails, this.orettyDetails});

  @override
  String toString() {
    return 'firestoreApiException: $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
