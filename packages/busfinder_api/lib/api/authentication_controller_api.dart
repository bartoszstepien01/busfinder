//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthenticationControllerApi {
  AuthenticationControllerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /auth/login' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [LoginUserDto] loginUserDto (required):
  Future<Response> authenticateWithHttpInfo(LoginUserDto loginUserDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/auth/login';

    // ignore: prefer_final_locals
    Object? postBody = loginUserDto;

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
  /// * [LoginUserDto] loginUserDto (required):
  Future<ApiResponseDtoLoginResponseDto?> authenticate(LoginUserDto loginUserDto,) async {
    final response = await authenticateWithHttpInfo(loginUserDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoLoginResponseDto',) as ApiResponseDtoLoginResponseDto;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /auth/signup' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [RegisterUserDto] registerUserDto (required):
  Future<Response> registerWithHttpInfo(RegisterUserDto registerUserDto,) async {
    // ignore: prefer_const_declarations
    final path = r'/auth/signup';

    // ignore: prefer_final_locals
    Object? postBody = registerUserDto;

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
  /// * [RegisterUserDto] registerUserDto (required):
  Future<ApiResponseDtoLoginResponseDto?> register(RegisterUserDto registerUserDto,) async {
    final response = await registerWithHttpInfo(registerUserDto,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiResponseDtoLoginResponseDto',) as ApiResponseDtoLoginResponseDto;
    
    }
    return null;
  }
}
