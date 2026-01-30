//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/authentication_controller_api.dart';
part 'api/bus_route_controller_api.dart';
part 'api/bus_stop_controller_api.dart';
part 'api/schedule_controller_api.dart';
part 'api/user_controller_api.dart';

part 'model/api_response_dto_bus_route_response_dto.dart';
part 'model/api_response_dto_bus_stop_response_dto.dart';
part 'model/api_response_dto_list_bus_route_response_short_dto.dart';
part 'model/api_response_dto_list_bus_stop_response_dto.dart';
part 'model/api_response_dto_list_schedule_response_dto.dart';
part 'model/api_response_dto_list_user_response_dto.dart';
part 'model/api_response_dto_login_response_dto.dart';
part 'model/api_response_dto_schedule_response_dto.dart';
part 'model/api_response_dto_void.dart';
part 'model/bus_arrival_dto.dart';
part 'model/bus_route_response_dto.dart';
part 'model/bus_route_response_short_dto.dart';
part 'model/bus_stop_response_dto.dart';
part 'model/change_user_type_dto.dart';
part 'model/create_bus_route_dto.dart';
part 'model/create_bus_stop_dto.dart';
part 'model/create_schedule_dto.dart';
part 'model/delete_bus_route_dto.dart';
part 'model/delete_bus_stop_dto.dart';
part 'model/delete_schedule_dto.dart';
part 'model/delete_user_dto.dart';
part 'model/edit_bus_route_dto.dart';
part 'model/edit_bus_stop_dto.dart';
part 'model/edit_route_variant_dto.dart';
part 'model/edit_schedule_dto.dart';
part 'model/location_dto.dart';
part 'model/login_response_dto.dart';
part 'model/login_user_dto.dart';
part 'model/register_user_dto.dart';
part 'model/route_variant_response_dto.dart';
part 'model/schedule_response_dto.dart';
part 'model/user_response_dto.dart';

/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) =>
    pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
