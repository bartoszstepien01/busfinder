//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScheduleControllerApi {
  ScheduleControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /schedule/create' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateScheduleDto] createScheduleDto (required):
  Future<Response> createScheduleWithHttpInfo(
    CreateScheduleDto createScheduleDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/schedule/create';

    // ignore: prefer_final_locals
    Object? postBody = createScheduleDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [CreateScheduleDto] createScheduleDto (required):
  Future<ApiResponseDtoScheduleResponseDto?> createSchedule(
    CreateScheduleDto createScheduleDto,
  ) async {
    final response = await createScheduleWithHttpInfo(
      createScheduleDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ApiResponseDtoScheduleResponseDto',
      ) as ApiResponseDtoScheduleResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'POST /schedule/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DeleteScheduleDto] deleteScheduleDto (required):
  Future<Response> deleteScheduleWithHttpInfo(
    DeleteScheduleDto deleteScheduleDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/schedule/delete';

    // ignore: prefer_final_locals
    Object? postBody = deleteScheduleDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [DeleteScheduleDto] deleteScheduleDto (required):
  Future<ApiResponseDtoVoid?> deleteSchedule(
    DeleteScheduleDto deleteScheduleDto,
  ) async {
    final response = await deleteScheduleWithHttpInfo(
      deleteScheduleDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ApiResponseDtoVoid',
      ) as ApiResponseDtoVoid;
    }
    return null;
  }

  /// Performs an HTTP 'POST /schedule/edit' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [EditScheduleDto] editScheduleDto (required):
  Future<Response> editScheduleWithHttpInfo(
    EditScheduleDto editScheduleDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/schedule/edit';

    // ignore: prefer_final_locals
    Object? postBody = editScheduleDto;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [EditScheduleDto] editScheduleDto (required):
  Future<ApiResponseDtoScheduleResponseDto?> editSchedule(
    EditScheduleDto editScheduleDto,
  ) async {
    final response = await editScheduleWithHttpInfo(
      editScheduleDto,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ApiResponseDtoScheduleResponseDto',
      ) as ApiResponseDtoScheduleResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'GET /schedule/all' operation and returns the [Response].
  Future<Response> getAllSchedulesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/schedule/all';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<ApiResponseDtoListScheduleResponseDto?> getAllSchedules() async {
    final response = await getAllSchedulesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ApiResponseDtoListScheduleResponseDto',
      ) as ApiResponseDtoListScheduleResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'GET /schedule/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getScheduleWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/schedule/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'id', id));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ApiResponseDtoScheduleResponseDto?> getSchedule(
    String id,
  ) async {
    final response = await getScheduleWithHttpInfo(
      id,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'ApiResponseDtoScheduleResponseDto',
      ) as ApiResponseDtoScheduleResponseDto;
    }
    return null;
  }
}
