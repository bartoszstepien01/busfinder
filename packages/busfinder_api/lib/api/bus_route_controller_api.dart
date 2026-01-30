//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BusRouteControllerApi {
  BusRouteControllerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /route/create' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateBusRouteDto] createBusRouteDto (required):
  Future<Response> createRouteWithHttpInfo(
    CreateBusRouteDto createBusRouteDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/route/create';

    // ignore: prefer_final_locals
    Object? postBody = createBusRouteDto;

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
  /// * [CreateBusRouteDto] createBusRouteDto (required):
  Future<ApiResponseDtoBusRouteResponseDto?> createRoute(
    CreateBusRouteDto createBusRouteDto,
  ) async {
    final response = await createRouteWithHttpInfo(
      createBusRouteDto,
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
        'ApiResponseDtoBusRouteResponseDto',
      ) as ApiResponseDtoBusRouteResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'POST /route/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DeleteBusRouteDto] deleteBusRouteDto (required):
  Future<Response> deleteRouteWithHttpInfo(
    DeleteBusRouteDto deleteBusRouteDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/route/delete';

    // ignore: prefer_final_locals
    Object? postBody = deleteBusRouteDto;

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
  /// * [DeleteBusRouteDto] deleteBusRouteDto (required):
  Future<ApiResponseDtoVoid?> deleteRoute(
    DeleteBusRouteDto deleteBusRouteDto,
  ) async {
    final response = await deleteRouteWithHttpInfo(
      deleteBusRouteDto,
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

  /// Performs an HTTP 'POST /route/edit' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [EditBusRouteDto] editBusRouteDto (required):
  Future<Response> editRouteWithHttpInfo(
    EditBusRouteDto editBusRouteDto,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/route/edit';

    // ignore: prefer_final_locals
    Object? postBody = editBusRouteDto;

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
  /// * [EditBusRouteDto] editBusRouteDto (required):
  Future<ApiResponseDtoBusRouteResponseDto?> editRoute(
    EditBusRouteDto editBusRouteDto,
  ) async {
    final response = await editRouteWithHttpInfo(
      editBusRouteDto,
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
        'ApiResponseDtoBusRouteResponseDto',
      ) as ApiResponseDtoBusRouteResponseDto;
    }
    return null;
  }

  /// Performs an HTTP 'GET /route/all' operation and returns the [Response].
  Future<Response> getAllRoutesWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/route/all';

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

  Future<ApiResponseDtoListBusRouteResponseShortDto?> getAllRoutes() async {
    final response = await getAllRoutesWithHttpInfo();
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
        'ApiResponseDtoListBusRouteResponseShortDto',
      ) as ApiResponseDtoListBusRouteResponseShortDto;
    }
    return null;
  }

  /// Performs an HTTP 'GET /route/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getRouteWithHttpInfo(
    String id,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/route/';

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
  Future<ApiResponseDtoBusRouteResponseDto?> getRoute(
    String id,
  ) async {
    final response = await getRouteWithHttpInfo(
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
        'ApiResponseDtoBusRouteResponseDto',
      ) as ApiResponseDtoBusRouteResponseDto;
    }
    return null;
  }
}
