//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserControllerApi {
  UserControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /user/delete' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [DeleteUserDto] deleteUserDto (required):
  Future<Response> deleteUserWithHttpInfo(DeleteUserDto deleteUserDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/delete';

    // ignore: prefer_final_locals
    Object? postBody = deleteUserDto;

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
  /// * [DeleteUserDto] deleteUserDto (required):
  Future<ApiResponseDtoVoid?> deleteUser(DeleteUserDto deleteUserDto,) async {
    final response = await deleteUserWithHttpInfo(deleteUserDto,);
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

  /// Performs an HTTP 'GET /user/all' operation and returns the [Response].
  Future<Response> getAllUsersWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/user/all';

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

  Future<ApiResponseDtoListUserResponseDto?> getAllUsers() async {
    final response = await getAllUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoListUserResponseDto',) as ApiResponseDtoListUserResponseDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /user/set-type' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ChangeUserTypeDto] changeUserTypeDto (required):
  Future<Response> setUserTypeWithHttpInfo(ChangeUserTypeDto changeUserTypeDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/user/set-type';

    // ignore: prefer_final_locals
    Object? postBody = changeUserTypeDto;

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
  /// * [ChangeUserTypeDto] changeUserTypeDto (required):
  Future<ApiResponseDtoVoid?> setUserType(ChangeUserTypeDto changeUserTypeDto,) async {
    final response = await setUserTypeWithHttpInfo(changeUserTypeDto,);
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
}
