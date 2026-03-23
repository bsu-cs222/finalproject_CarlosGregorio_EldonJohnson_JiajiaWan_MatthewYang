import 'card.dart';

class ServerResponse {
  final bool isSuccess;
  final Card? data;
  final String? errorMessage;

  ServerResponse({required this.isSuccess, this.data, this.errorMessage});
}
