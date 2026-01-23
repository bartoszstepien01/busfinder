//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class BusStopControllerApi {
  BusStopControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /stop/create' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [CreateBusStopDto] createBusStopDto (required):
  Future<Response> createBusStopWithHttpInfo(CreateBusStopDto createBusStopDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/stop/create';

    // ignore: prefer_final_locals
    Object? postBody = createBusStopDto;

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
  /// * [CreateBusStopDto] createBusStopDto (required):
  Future<ApiResponseDtoBusStopResponseDto?> createBusStop(CreateBusStopDto createBusStopDto,) async {
    final response = await createBusStopWithHttpInfo(createBusStopDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoBusStopResponseDto',) as ApiResponseDtoBusStopResponseDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /stop/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DeleteBusStopDto] deleteBusStopDto (required):
  Future<Response> deleteBusStopWithHttpInfo(DeleteBusStopDto deleteBusStopDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/stop/delete';

    // ignore: prefer_final_locals
    Object? postBody = deleteBusStopDto;

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
  /// * [DeleteBusStopDto] deleteBusStopDto (required):
  Future<ApiResponseDtoVoid?> deleteBusStop(DeleteBusStopDto deleteBusStopDto,) async {
    final response = await deleteBusStopWithHttpInfo(deleteBusStopDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoVoid',) as ApiResponseDtoVoid;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /stop/edit' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [EditBusStopDto] editBusStopDto (required):
  Future<Response> editBusStopWithHttpInfo(EditBusStopDto editBusStopDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/stop/edit';

    // ignore: prefer_final_locals
    Object? postBody = editBusStopDto;

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
  /// * [EditBusStopDto] editBusStopDto (required):
  Future<ApiResponseDtoBusStopResponseDto?> editBusStop(EditBusStopDto editBusStopDto,) async {
    final response = await editBusStopWithHttpInfo(editBusStopDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoBusStopResponseDto',) as ApiResponseDtoBusStopResponseDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /stop/all' operation and returns the [Response].
  Future<Response> getAllBusStopsWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/stop/all';

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

  Future<ApiResponseDtoListBusStopResponseDto?> getAllBusStops() async {
    final response = await getAllBusStopsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoListBusStopResponseDto',) as ApiResponseDtoListBusStopResponseDto;
    
    }
    return null;
  }
}
