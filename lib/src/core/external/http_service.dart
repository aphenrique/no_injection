import 'package:no_injection/src/core/utils/clients/uno_service.dart';

abstract class HttpService {
  factory HttpService() => UnoService();

  Future<Map<String, dynamic>> get(String url);
}
