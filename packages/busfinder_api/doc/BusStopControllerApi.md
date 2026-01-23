# openapi.api.BusStopControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createBusStop**](BusStopControllerApi.md#createbusstop) | **POST** /stop/create | 
[**deleteBusStop**](BusStopControllerApi.md#deletebusstop) | **POST** /stop/delete | 
[**editBusStop**](BusStopControllerApi.md#editbusstop) | **POST** /stop/edit | 
[**getAllBusStops**](BusStopControllerApi.md#getallbusstops) | **GET** /stop/all | 


# **createBusStop**
> ApiResponseDtoBusStopResponseDto createBusStop(createBusStopDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusStopControllerApi();
final createBusStopDto = CreateBusStopDto(); // CreateBusStopDto | 

try {
    final result = api_instance.createBusStop(createBusStopDto);
    print(result);
} catch (e) {
    print('Exception when calling BusStopControllerApi->createBusStop: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createBusStopDto** | [**CreateBusStopDto**](CreateBusStopDto.md)|  | 

### Return type

[**ApiResponseDtoBusStopResponseDto**](ApiResponseDtoBusStopResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteBusStop**
> ApiResponseDtoVoid deleteBusStop(deleteBusStopDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusStopControllerApi();
final deleteBusStopDto = DeleteBusStopDto(); // DeleteBusStopDto | 

try {
    final result = api_instance.deleteBusStop(deleteBusStopDto);
    print(result);
} catch (e) {
    print('Exception when calling BusStopControllerApi->deleteBusStop: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteBusStopDto** | [**DeleteBusStopDto**](DeleteBusStopDto.md)|  | 

### Return type

[**ApiResponseDtoVoid**](ApiResponseDtoVoid.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editBusStop**
> ApiResponseDtoBusStopResponseDto editBusStop(editBusStopDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusStopControllerApi();
final editBusStopDto = EditBusStopDto(); // EditBusStopDto | 

try {
    final result = api_instance.editBusStop(editBusStopDto);
    print(result);
} catch (e) {
    print('Exception when calling BusStopControllerApi->editBusStop: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **editBusStopDto** | [**EditBusStopDto**](EditBusStopDto.md)|  | 

### Return type

[**ApiResponseDtoBusStopResponseDto**](ApiResponseDtoBusStopResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllBusStops**
> ApiResponseDtoListBusStopResponseDto getAllBusStops()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BusStopControllerApi();

try {
    final result = api_instance.getAllBusStops();
    print(result);
} catch (e) {
    print('Exception when calling BusStopControllerApi->getAllBusStops: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseDtoListBusStopResponseDto**](ApiResponseDtoListBusStopResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

