//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScheduleResponseDto {
  /// Returns a new [ScheduleResponseDto] instance.
  ScheduleResponseDto({
    required this.id,
    required this.routeId,
    required this.dayType,
    this.timetable = const {},
  });

  String id;

  String routeId;

  ScheduleResponseDtoDayTypeEnum dayType;

  Map<String, List<BusArrivalDto>> timetable;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleResponseDto &&
          other.id == id &&
          other.routeId == routeId &&
          other.dayType == dayType &&
          _deepEquality.equals(other.timetable, timetable);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (routeId.hashCode) +
      (dayType.hashCode) +
      (timetable.hashCode);

  @override
  String toString() =>
      'ScheduleResponseDto[id=$id, routeId=$routeId, dayType=$dayType, timetable=$timetable]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'routeId'] = this.routeId;
    json[r'dayType'] = this.dayType;
    json[r'timetable'] = this.timetable;
    return json;
  }

  /// Returns a new [ScheduleResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ScheduleResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ScheduleResponseDto[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ScheduleResponseDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ScheduleResponseDto(
        id: mapValueOfType<String>(json, r'id')!,
        routeId: mapValueOfType<String>(json, r'routeId')!,
        dayType: ScheduleResponseDtoDayTypeEnum.fromJson(json[r'dayType'])!,
        timetable: json[r'timetable'] == null
            ? const {}
            : BusArrivalDto.mapListFromJson(json[r'timetable']),
      );
    }
    return null;
  }

  static List<ScheduleResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ScheduleResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScheduleResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ScheduleResponseDto> mapFromJson(dynamic json) {
    final map = <String, ScheduleResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScheduleResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ScheduleResponseDto-objects as value to a dart map
  static Map<String, List<ScheduleResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ScheduleResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ScheduleResponseDto.listFromJson(
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
    'routeId',
    'dayType',
    'timetable',
  };
}

class ScheduleResponseDtoDayTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const ScheduleResponseDtoDayTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const workday = ScheduleResponseDtoDayTypeEnum._(r'workday');
  static const saturday = ScheduleResponseDtoDayTypeEnum._(r'saturday');
  static const sunday = ScheduleResponseDtoDayTypeEnum._(r'sunday');
  static const holiday = ScheduleResponseDtoDayTypeEnum._(r'holiday');
  static const special = ScheduleResponseDtoDayTypeEnum._(r'special');

  /// List of all possible values in this [enum][ScheduleResponseDtoDayTypeEnum].
  static const values = <ScheduleResponseDtoDayTypeEnum>[
    workday,
    saturday,
    sunday,
    holiday,
    special,
  ];

  static ScheduleResponseDtoDayTypeEnum? fromJson(dynamic value) =>
      ScheduleResponseDtoDayTypeEnumTypeTransformer().decode(value);

  static List<ScheduleResponseDtoDayTypeEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ScheduleResponseDtoDayTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScheduleResponseDtoDayTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ScheduleResponseDtoDayTypeEnum] to String,
/// and [decode] dynamic data back to [ScheduleResponseDtoDayTypeEnum].
class ScheduleResponseDtoDayTypeEnumTypeTransformer {
  factory ScheduleResponseDtoDayTypeEnumTypeTransformer() =>
      _instance ??= const ScheduleResponseDtoDayTypeEnumTypeTransformer._();

  const ScheduleResponseDtoDayTypeEnumTypeTransformer._();

  String encode(ScheduleResponseDtoDayTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ScheduleResponseDtoDayTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ScheduleResponseDtoDayTypeEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'workday':
          return ScheduleResponseDtoDayTypeEnum.workday;
        case r'saturday':
          return ScheduleResponseDtoDayTypeEnum.saturday;
        case r'sunday':
          return ScheduleResponseDtoDayTypeEnum.sunday;
        case r'holiday':
          return ScheduleResponseDtoDayTypeEnum.holiday;
        case r'special':
          return ScheduleResponseDtoDayTypeEnum.special;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ScheduleResponseDtoDayTypeEnumTypeTransformer] instance.
  static ScheduleResponseDtoDayTypeEnumTypeTransformer? _instance;
}
