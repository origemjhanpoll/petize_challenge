import 'dart:convert';

String extractMessage(String body) {
  try {
    final decodedBody = json.decode(body);
    return decodedBody['message'] ?? '';
  } catch (e) {
    return 'Error parsing response body: $e';
  }
}
