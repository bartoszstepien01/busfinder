//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EditScheduleDto {
  /// Returns a new [EditScheduleDto] instance.
  EditScheduleDto({
    required this.id,
    this.timetable = const {},
  });

  String id;

  Map<String, List<BusArrivalDto>> timetable;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EditScheduleDto &&
    other.id == id &&
    _deepEquality.equals(other.timetable, timetable);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (timetable.hashCode);

  @override
  String toString() => 'EditScheduleDto[id=$id, timetable=$timetable]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'timetable'] = this.timetable;
    return json;
  }

  /// Returns a new [EditScheduleDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EditScheduleDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EditScheduleDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EditScheduleDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EditScheduleDto(
        id: mapValueOfType<String>(json, r'id')!,
        timetable: json[r'timetable'] == null
          ? const {}
            : BusArrivalDto.mapListFromJson(json[r'timetable']),
      );
    }
    return null;
  }

  static List<EditScheduleDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EditScheduleDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EditScheduleDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EditScheduleDto> mapFromJson(dynamic json) {
    final map = <String, EditScheduleDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EditScheduleDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EditScheduleDto-objects as value to a dart map
  static Map<String, List<EditScheduleDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EditScheduleDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EditScheduleDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'timetable',
  };
}

