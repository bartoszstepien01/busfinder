//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiResponseDtoScheduleResponseDto {
  /// Returns a new [ApiResponseDtoScheduleResponseDto] instance.
  ApiResponseDtoScheduleResponseDto({
    required this.success,
    this.data,
    this.error,
  });

  bool success;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ScheduleResponseDto? data;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiResponseDtoScheduleResponseDto &&
          other.success == success &&
          other.data == data &&
          other.error == error;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (success.hashCode) +
      (data == null ? 0 : data!.hashCode) +
      (error == null ? 0 : error!.hashCode);

  @override
  String toString() =>
      'ApiResponseDtoScheduleResponseDto[success=$success, data=$data, error=$error]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'success'] = this.success;
    if (this.data != null) {
      json[r'data'] = this.data;
    } else {
      json[r'data'] = null;
    }
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    return json;
  }

  /// Returns a new [ApiResponseDtoScheduleResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiResponseDtoScheduleResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ApiResponseDtoScheduleResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ApiResponseDtoScheduleResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiResponseDtoScheduleResponseDto(
        success: mapValueOfType<bool>(json, r'success')!,
        data: ScheduleResponseDto.fromJson(json[r'data']),
        error: mapValueOfType<String>(json, r'error'),
      );
    }
    return null;
  }

  static List<ApiResponseDtoScheduleResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ApiResponseDtoScheduleResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiResponseDtoScheduleResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiResponseDtoScheduleResponseDto> mapFromJson(
      dynamic json) {
    final map = <String, ApiResponseDtoScheduleResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiResponseDtoScheduleResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiResponseDtoScheduleResponseDto-objects as value to a dart map
  static Map<String, List<ApiResponseDtoScheduleResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ApiResponseDtoScheduleResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiResponseDtoScheduleResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
  };
}
