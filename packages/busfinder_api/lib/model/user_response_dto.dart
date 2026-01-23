//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserResponseDto {
  /// Returns a new [UserResponseDto] instance.
  UserResponseDto({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.userType,
  });

  String id;

  String email;

  String name;

  String surname;

  UserResponseDtoUserTypeEnum userType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserResponseDto &&
    other.id == id &&
    other.email == email &&
    other.name == name &&
    other.surname == surname &&
    other.userType == userType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (email.hashCode) +
    (name.hashCode) +
    (surname.hashCode) +
    (userType.hashCode);

  @override
  String toString() => 'UserResponseDto[id=$id, email=$email, name=$name, surname=$surname, userType=$userType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'email'] = this.email;
      json[r'name'] = this.name;
      json[r'surname'] = this.surname;
      json[r'userType'] = this.userType;
    return json;
  }

  /// Returns a new [UserResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserResponseDto(
        id: mapValueOfType<String>(json, r'id')!,
        email: mapValueOfType<String>(json, r'email')!,
        name: mapValueOfType<String>(json, r'name')!,
        surname: mapValueOfType<String>(json, r'surname')!,
        userType: UserResponseDtoUserTypeEnum.fromJson(json[r'userType'])!,
      );
    }
    return null;
  }

  static List<UserResponseDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserResponseDto> mapFromJson(dynamic json) {
    final map = <String, UserResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserResponseDto-objects as value to a dart map
  static Map<String, List<UserResponseDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserResponseDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'email',
    'name',
    'surname',
    'userType',
  };
}


class UserResponseDtoUserTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const UserResponseDtoUserTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const user = UserResponseDtoUserTypeEnum._(r'user');
  static const driver = UserResponseDtoUserTypeEnum._(r'driver');
  static const admin = UserResponseDtoUserTypeEnum._(r'admin');

  /// List of all possible values in this [enum][UserResponseDtoUserTypeEnum].
  static const values = <UserResponseDtoUserTypeEnum>[
    user,
    driver,
    admin,
  ];

  static UserResponseDtoUserTypeEnum? fromJson(dynamic value) => UserResponseDtoUserTypeEnumTypeTransformer().decode(value);

  static List<UserResponseDtoUserTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserResponseDtoUserTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserResponseDtoUserTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserResponseDtoUserTypeEnum] to String,
/// and [decode] dynamic data back to [UserResponseDtoUserTypeEnum].
class UserResponseDtoUserTypeEnumTypeTransformer {
  factory UserResponseDtoUserTypeEnumTypeTransformer() => _instance ??= const UserResponseDtoUserTypeEnumTypeTransformer._();

  const UserResponseDtoUserTypeEnumTypeTransformer._();

  String encode(UserResponseDtoUserTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UserResponseDtoUserTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserResponseDtoUserTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'user': return UserResponseDtoUserTypeEnum.user;
        case r'driver': return UserResponseDtoUserTypeEnum.driver;
        case r'admin': return UserResponseDtoUserTypeEnum.admin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserResponseDtoUserTypeEnumTypeTransformer] instance.
  static UserResponseDtoUserTypeEnumTypeTransformer? _instance;
}


