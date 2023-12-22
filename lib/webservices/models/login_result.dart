


import 'package:json_annotation/json_annotation.dart';
 part 'login_result.g.dart';

@JsonSerializable()
class LoginResult{
  String? token;
  LoginData? data;

  LoginResult({this.token, this.data});

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}


@JsonSerializable()
class LoginData{
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? password;
  String? email;
  String? createdAt;
  String? updatedAt;

  LoginData({this.id, this.username, this.password, this.email, this.createdAt,
      this.updatedAt});
  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

}

/*
*
* {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InNhaGlsQGdtYWlsLmNvbSIsImlkIjoiNjU4MDI5OTAwMzU1YzBmM2JkM2RiNDhmIiwiaWF0IjoxNzAyODk5Njc3fQ.Dx38y2ELU5UvGlR9jyryg2njC8lW0WBApB1Uiu8jzTQ",
    "data": {
        "_id": "658029900355c0f3bd3db48f",
        "username": "sahil",
        "password": "$2b$10$GSfMkuLmUWaY8j07c4tEC.jqiLCAZZI3OhITIS6ZBibCrMW7u2NgC",
        "email": "sahil@gmail.com",
        "createdAt": "2023-12-18T11:14:24.975Z",
        "updatedAt": "2023-12-18T11:14:24.975Z",
        "__v": 0
    }
}
* */