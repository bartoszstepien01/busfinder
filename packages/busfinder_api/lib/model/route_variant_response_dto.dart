//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RouteVariantResponseDto {
  /// Returns a new [RouteVariantResponseDto] instance.
  RouteVariantResponseDto({
    required this.id,
    required this.name,
    required this.standard,
    this.busStops = const [],
  });

  String id;

  String name;

  bool standard;

  List<String> busStops;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteVariantResponseDto &&
          other.id == id &&
          other.name == name &&
          other.standard == standard &&
          _deepEquality.equals(other.busStops, busStops);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (name.hashCode) +
      (standard.hashCode) +
      (busStops.hashCode);

  @override
  String toString() =>
      'RouteVariantResponseDto[id=$id, name=$name, standard=$standard, busStops=$busStops]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'name'] = this.name;
    json[r'standard'] = this.standard;
    json[r'busStops'] = this.busStops;
    return json;
  }

  /// Returns a new [RouteVariantResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RouteVariantResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "RouteVariantResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "RouteVariantResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RouteVariantResponseDto(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        standard: mapValueOfType<bool>(json, r'standard')!,
        busStops: json[r'busStops'] is Iterable
            ? (json[r'busStops'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<RouteVariantResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RouteVariantResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RouteVariantResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RouteVariantResponseDto> mapFromJson(dynamic json) {
    final map = <String, RouteVariantResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RouteVariantResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RouteVariantResponseDto-objects as value to a dart map
  static Map<String, List<RouteVariantResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RouteVariantResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RouteVariantResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'standard',
    'busStops',
  };
}
