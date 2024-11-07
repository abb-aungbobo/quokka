import 'package:json_annotation/json_annotation.dart';
import 'package:quokka/models/network/requests/user_request/user_request.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final UserRequest user;

  const LoginRequest({required this.user});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
