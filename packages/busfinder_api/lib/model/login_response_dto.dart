//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginResponseDto {
  /// Returns a new [LoginResponseDto] instance.
  LoginResponseDto({
    required this.token,
    required this.expiresIn,
    required this.userType,
  });

  String token;

  int expiresIn;

  LoginResponseDtoUserTypeEnum userType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginResponseDto &&
    other.token == token &&
    other.expiresIn == expiresIn &&
    other.userType == userType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode) +
    (expiresIn.hashCode) +
    (userType.hashCode);

  @override
  String toString() => 'LoginResponseDto[token=$token, expiresIn=$expiresIn, userType=$userType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
      json[r'expiresIn'] = this.expiresIn;
      json[r'userType'] = this.userType;
    return json;
  }

  /// Returns a new [LoginResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LoginResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LoginResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LoginResponseDto(
        token: mapValueOfType<String>(json, r'token')!,
        expiresIn: mapValueOfType<int>(json, r'expiresIn')!,
        userType: LoginResponseDtoUserTypeEnum.fromJson(json[r'userType'])!,
      );
    }
    return null;
  }

  static List<LoginResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginResponseDto> mapFromJson(dynamic json) {
    final map = <String, LoginResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginResponseDto-objects as value to a dart map
  static Map<String, List<LoginResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
    'expiresIn',
    'userType',
  };
}


class LoginResponseDtoUserTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const LoginResponseDtoUserTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const user = LoginResponseDtoUserTypeEnum._(r'user');
  static const driver = LoginResponseDtoUserTypeEnum._(r'driver');
  static const admin = LoginResponseDtoUserTypeEnum._(r'admin');

  /// List of all possible values in this [enum][LoginResponseDtoUserTypeEnum].
  static const values = <LoginResponseDtoUserTypeEnum>[
    user,
    driver,
    admin,
  ];

  static LoginResponseDtoUserTypeEnum? fromJson(dynamic value) => LoginResponseDtoUserTypeEnumTypeTransformer().decode(value);

  static List<LoginResponseDtoUserTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginResponseDtoUserTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginResponseDtoUserTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LoginResponseDtoUserTypeEnum] to String,
/// and [decode] dynamic data back to [LoginResponseDtoUserTypeEnum].
class LoginResponseDtoUserTypeEnumTypeTransformer {
  factory LoginResponseDtoUserTypeEnumTypeTransformer() => _instance ??= const LoginResponseDtoUserTypeEnumTypeTransformer._();

  const LoginResponseDtoUserTypeEnumTypeTransformer._();

  String encode(LoginResponseDtoUserTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a LoginResponseDtoUserTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LoginResponseDtoUserTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'user': return LoginResponseDtoUserTypeEnum.user;
        case r'driver': return LoginResponseDtoUserTypeEnum.driver;
        case r'admin': return LoginResponseDtoUserTypeEnum.admin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LoginResponseDtoUserTypeEnumTypeTransformer] instance.
  static LoginResponseDtoUserTypeEnumTypeTransformer? _instance;
}


