import 'package:gestor_de_inventario/Models/service.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/request_data.dart';

class TokenInterceptor implements InterceptorContract {
  Service _service = Service.getInstance();
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Access-Control-Allow-Origin"] = "*";
      data.headers["Authorization"] = "Bearer ${_service.getToken()}";
    } catch (e) {
      print(e);
    }

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
