# openapi.api.ScheduleControllerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSchedule**](ScheduleControllerApi.md#createschedule) | **POST** /schedule/create | 
[**deleteSchedule**](ScheduleControllerApi.md#deleteschedule) | **POST** /schedule/delete | 
[**editSchedule**](ScheduleControllerApi.md#editschedule) | **POST** /schedule/edit | 
[**getAllSchedules**](ScheduleControllerApi.md#getallschedules) | **GET** /schedule/all | 
[**getSchedule**](ScheduleControllerApi.md#getschedule) | **GET** /schedule/ | 


# **createSchedule**
> ApiResponseDtoScheduleResponseDto createSchedule(createScheduleDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ScheduleControllerApi();
final createScheduleDto = CreateScheduleDto(); // CreateScheduleDto | 

try {
    final result = api_instance.createSchedule(createScheduleDto);
    print(result);
} catch (e) {
    print('Exception when calling ScheduleControllerApi->createSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createScheduleDto** | [**CreateScheduleDto**](CreateScheduleDto.md)|  | 

### Return type

[**ApiResponseDtoScheduleResponseDto**](ApiResponseDtoScheduleResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSchedule**
> ApiResponseDtoVoid deleteSchedule(deleteScheduleDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ScheduleControllerApi();
final deleteScheduleDto = DeleteScheduleDto(); // DeleteScheduleDto | 

try {
    final result = api_instance.deleteSchedule(deleteScheduleDto);
    print(result);
} catch (e) {
    print('Exception when calling ScheduleControllerApi->deleteSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteScheduleDto** | [**DeleteScheduleDto**](DeleteScheduleDto.md)|  | 

### Return type

[**ApiResponseDtoVoid**](ApiResponseDtoVoid.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editSchedule**
> ApiResponseDtoScheduleResponseDto editSchedule(editScheduleDto)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ScheduleControllerApi();
final editScheduleDto = EditScheduleDto(); // EditScheduleDto | 

try {
    final result = api_instance.editSchedule(editScheduleDto);
    print(result);
} catch (e) {
    print('Exception when calling ScheduleControllerApi->editSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **editScheduleDto** | [**EditScheduleDto**](EditScheduleDto.md)|  | 

### Return type

[**ApiResponseDtoScheduleResponseDto**](ApiResponseDtoScheduleResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllSchedules**
> ApiResponseDtoListScheduleResponseDto getAllSchedules()



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ScheduleControllerApi();

try {
    final result = api_instance.getAllSchedules();
    print(result);
} catch (e) {
    print('Exception when calling ScheduleControllerApi->getAllSchedules: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApiResponseDtoListScheduleResponseDto**](ApiResponseDtoListScheduleResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSchedule**
> ApiResponseDtoScheduleResponseDto getSchedule(id)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ScheduleControllerApi();
final id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getSchedule(id);
    print(result);
} catch (e) {
    print('Exception when calling ScheduleControllerApi->getSchedule: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ApiResponseDtoScheduleResponseDto**](ApiResponseDtoScheduleResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

