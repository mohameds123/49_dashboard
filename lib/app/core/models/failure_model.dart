
import 'Http_request_enum.dart';

class FailureModel {
  String? message;
  HttpResponseStatus? responseStatus;
  FailureModel({ this.responseStatus, this.message});
}
