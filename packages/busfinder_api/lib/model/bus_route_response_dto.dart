//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BusRouteResponseDto {
  /// Returns a new [BusRouteResponseDto] instance.
  BusRouteResponseDto({
    required this.id,
    required this.name,
    this.variants = const [],
  });

  String id;

  String name;

  List<RouteVariantResponseDto> variants;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusRouteResponseDto &&
          other.id == id &&
          other.name == name &&
          _deepEquality.equals(other.variants, variants);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) + (name.hashCode) + (variants.hashCode);

  @override
  String toString() =>
      'BusRouteResponseDto[id=$id, name=$name, variants=$variants]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'name'] = this.name;
    json[r'variants'] = this.variants;
    return json;
  }

  /// Returns a new [BusRouteResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BusRouteResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "BusRouteResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "BusRouteResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BusRouteResponseDto(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        variants: RouteVariantResponseDto.listFromJson(json[r'variants']),
      );
    }
    return null;
  }

  static List<BusRouteResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <BusRouteResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BusRouteResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BusRouteResponseDto> mapFromJson(dynamic json) {
    final map = <String, BusRouteResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BusRouteResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BusRouteResponseDto-objects as value to a dart map
  static Map<String, List<BusRouteResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<BusRouteResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BusRouteResponseDto.listFromJson(
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
    'variants',
  };
}
