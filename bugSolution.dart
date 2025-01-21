```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // More specific error handling based on status code
      throw HttpException('HTTP request failed', response.statusCode, response.reasonPhrase);
    }
  } on SocketException {
    // Handle network errors
    throw Exception('No internet connection');
  } on FormatException catch (e) {
    // Handle JSON decoding errors
    throw Exception('Invalid JSON format: ${e.message}');
  } on Exception catch (e) {
    // Handle other exceptions
    throw Exception('An unexpected error occurred: $e');
  } catch (e) {
    //Handle any other unexpected error
    print('Unexpected error: $e');
    rethrow;
  }
}

//Custom Exception class for HTTP errors
class HttpException implements Exception {
  final String message;
  final int statusCode;
  final String? reasonPhrase;

  HttpException(this.message, this.statusCode, this.reasonPhrase);

  @override
  String toString() {
    return 'HttpException: $message (Status Code: $statusCode)';
  }
}
```