# openapi.api.AuthenticationControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticate**](AuthenticationControllerApi.md#authenticate) | **POST** /auth/login | 
[**register**](AuthenticationControllerApi.md#register) | **POST** /auth/signup | 


# **authenticate**
> ApiResponseDtoLoginResponseDto authenticate(loginUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthenticationControllerApi();
final loginUserDto = LoginUserDto(); // LoginUserDto | 

try {
    final result = api_instance.authenticate(loginUserDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->authenticate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginUserDto** | [**LoginUserDto**](LoginUserDto.md)|  | 

### Return type

[**ApiResponseDtoLoginResponseDto**](ApiResponseDtoLoginResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> ApiResponseDtoLoginResponseDto register(registerUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthenticationControllerApi();
final registerUserDto = RegisterUserDto(); // RegisterUserDto | 

try {
    final result = api_instance.register(registerUserDto);
    print(result);
} catch (e) {
    print('Exception when calling AuthenticationControllerApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerUserDto** | [**RegisterUserDto**](RegisterUserDto.md)|  | 

### Return type

[**ApiResponseDtoLoginResponseDto**](ApiResponseDtoLoginResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

