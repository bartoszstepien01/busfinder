//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiResponseDtoListBusRouteResponseShortDto {
  /// Returns a new [ApiResponseDtoListBusRouteResponseShortDto] instance.
  ApiResponseDtoListBusRouteResponseShortDto({
    required this.success,
    this.data = const [],
    this.error,
  });

  bool success;

  List<BusRouteResponseShortDto> data;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? error;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiResponseDtoListBusRouteResponseShortDto &&
    other.success == success &&
    _deepEquality.equals(other.data, data) &&
    other.error == error;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (data.hashCode) +
    (error == null ? 0 : error!.hashCode);

  @override
  String toString() => 'ApiResponseDtoListBusRouteResponseShortDto[success=$success, data=$data, error=$error]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'data'] = this.data;
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    return json;
  }

  /// Returns a new [ApiResponseDtoListBusRouteResponseShortDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiResponseDtoListBusRouteResponseShortDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiResponseDtoListBusRouteResponseShortDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiResponseDtoListBusRouteResponseShortDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiResponseDtoListBusRouteResponseShortDto(
        success: mapValueOfType<bool>(json, r'success')!,
        data: BusRouteResponseShortDto.listFromJson(json[r'data']),
        error: mapValueOfType<String>(json, r'error'),
      );
    }
    return null;
  }

  static List<ApiResponseDtoListBusRouteResponseShortDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiResponseDtoListBusRouteResponseShortDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiResponseDtoListBusRouteResponseShortDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiResponseDtoListBusRouteResponseShortDto> mapFromJson(dynamic json) {
    final map = <String, ApiResponseDtoListBusRouteResponseShortDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiResponseDtoListBusRouteResponseShortDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiResponseDtoListBusRouteResponseShortDto-objects as value to a dart map
  static Map<String, List<ApiResponseDtoListBusRouteResponseShortDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiResponseDtoListBusRouteResponseShortDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiResponseDtoListBusRouteResponseShortDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
  };
}

