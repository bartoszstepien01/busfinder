# openapi.api.UserControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteUser**](UserControllerApi.md#deleteuser) | **POST** /user/delete | 
[**getAllUsers**](UserControllerApi.md#getallusers) | **GET** /user/all | 
[**setUserType**](UserControllerApi.md#setusertype) | **POST** /user/set-type | 


# **deleteUser**
> ApiResponseDtoVoid deleteUser(deleteUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UserControllerApi();
final deleteUserDto = DeleteUserDto(); // DeleteUserDto | 

try {
    final result = api_instance.deleteUser(deleteUserDto);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->deleteUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteUserDto** | [**DeleteUserDto**](DeleteUserDto.md)|  | 

### Return type

[**ApiResponseDtoVoid**](ApiResponseDtoVoid.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllUsers**
> ApiResponseDtoListUserResponseDto getAllUsers()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UserControllerApi();

try {
    final result = api_instance.getAllUsers();
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->getAllUsers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseDtoListUserResponseDto**](ApiResponseDtoListUserResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setUserType**
> ApiResponseDtoVoid setUserType(changeUserTypeDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UserControllerApi();
final changeUserTypeDto = ChangeUserTypeDto(); // ChangeUserTypeDto | 

try {
    final result = api_instance.setUserType(changeUserTypeDto);
    print(result);
} catch (e) {
    print('Exception when calling UserControllerApi->setUserType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeUserTypeDto** | [**ChangeUserTypeDto**](ChangeUserTypeDto.md)|  | 

### Return type

[**ApiResponseDtoVoid**](ApiResponseDtoVoid.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

