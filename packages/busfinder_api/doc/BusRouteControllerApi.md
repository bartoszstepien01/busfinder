# openapi.api.BusRouteControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createRoute**](BusRouteControllerApi.md#createroute) | **POST** /route/create | 
[**deleteRoute**](BusRouteControllerApi.md#deleteroute) | **POST** /route/delete | 
[**editRoute**](BusRouteControllerApi.md#editroute) | **POST** /route/edit | 
[**getAllRoutes**](BusRouteControllerApi.md#getallroutes) | **GET** /route/all | 
[**getRoute**](BusRouteControllerApi.md#getroute) | **GET** /route/ | 


# **createRoute**
> ApiResponseDtoBusRouteResponseDto createRoute(createBusRouteDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusRouteControllerApi();
final createBusRouteDto = CreateBusRouteDto(); // CreateBusRouteDto | 

try {
    final result = api_instance.createRoute(createBusRouteDto);
    print(result);
} catch (e) {
    print('Exception when calling BusRouteControllerApi->createRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createBusRouteDto** | [**CreateBusRouteDto**](CreateBusRouteDto.md)|  | 

### Return type

[**ApiResponseDtoBusRouteResponseDto**](ApiResponseDtoBusRouteResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRoute**
> ApiResponseDtoVoid deleteRoute(deleteBusRouteDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusRouteControllerApi();
final deleteBusRouteDto = DeleteBusRouteDto(); // DeleteBusRouteDto | 

try {
    final result = api_instance.deleteRoute(deleteBusRouteDto);
    print(result);
} catch (e) {
    print('Exception when calling BusRouteControllerApi->deleteRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteBusRouteDto** | [**DeleteBusRouteDto**](DeleteBusRouteDto.md)|  | 

### Return type

[**ApiResponseDtoVoid**](ApiResponseDtoVoid.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editRoute**
> ApiResponseDtoBusRouteResponseDto editRoute(editBusRouteDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusRouteControllerApi();
final editBusRouteDto = EditBusRouteDto(); // EditBusRouteDto | 

try {
    final result = api_instance.editRoute(editBusRouteDto);
    print(result);
} catch (e) {
    print('Exception when calling BusRouteControllerApi->editRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **editBusRouteDto** | [**EditBusRouteDto**](EditBusRouteDto.md)|  | 

### Return type

[**ApiResponseDtoBusRouteResponseDto**](ApiResponseDtoBusRouteResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllRoutes**
> ApiResponseDtoListBusRouteResponseShortDto getAllRoutes()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusRouteControllerApi();

try {
    final result = api_instance.getAllRoutes();
    print(result);
} catch (e) {
    print('Exception when calling BusRouteControllerApi->getAllRoutes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseDtoListBusRouteResponseShortDto**](ApiResponseDtoListBusRouteResponseShortDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRoute**
> ApiResponseDtoBusRouteResponseDto getRoute(id)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusRouteControllerApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getRoute(id);
    print(result);
} catch (e) {
    print('Exception when calling BusRouteControllerApi->getRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseDtoBusRouteResponseDto**](ApiResponseDtoBusRouteResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

