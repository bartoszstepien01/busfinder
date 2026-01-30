//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BusArrivalDto {
  /// Returns a new [BusArrivalDto] instance.
  BusArrivalDto({
    required this.time,
    required this.courseNumber,
    required this.routeVariantId,
  });

  String time;

  int courseNumber;

  String routeVariantId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusArrivalDto &&
          other.time == time &&
          other.courseNumber == courseNumber &&
          other.routeVariantId == routeVariantId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (time.hashCode) + (courseNumber.hashCode) + (routeVariantId.hashCode);

  @override
  String toString() =>
      'BusArrivalDto[time=$time, courseNumber=$courseNumber, routeVariantId=$routeVariantId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'time'] = this.time;
    json[r'courseNumber'] = this.courseNumber;
    json[r'routeVariantId'] = this.routeVariantId;
    return json;
  }

  /// Returns a new [BusArrivalDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BusArrivalDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "BusArrivalDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "BusArrivalDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BusArrivalDto(
        time: mapValueOfType<String>(json, r'time')!,
        courseNumber: mapValueOfType<int>(json, r'courseNumber')!,
        routeVariantId: mapValueOfType<String>(json, r'routeVariantId')!,
      );
    }
    return null;
  }

  static List<BusArrivalDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <BusArrivalDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BusArrivalDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BusArrivalDto> mapFromJson(dynamic json) {
    final map = <String, BusArrivalDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BusArrivalDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BusArrivalDto-objects as value to a dart map
  static Map<String, List<BusArrivalDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<BusArrivalDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BusArrivalDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'time',
    'courseNumber',
    'routeVariantId',
  };
}
