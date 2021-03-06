import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/api/rest_api/interceptors/dio_error_interceptor.dart';
import 'package:weather_app_2_0/data/api/rest_api/request/get_request_body.dart';
import 'package:weather_app_2_0/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:weather_app_2_0/data/mapper/day/daily_mapper.dart';
import 'package:weather_app_2_0/data/mapper/hour/hourly_mapper.dart';
import 'package:weather_app_2_0/data/api/rest_api/services/openweathermap_service.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

@LazySingleton(as: IRemoteDataSource)
class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource() {
    final dio = Dio(OpenWeatherMapService.baseOptions);

    dio.interceptors.add(DioErrorInterceptor());
    _weatherService = OpenWeatherMapService(dio: dio);
  }

  late final OpenWeatherMapService _weatherService;

  @override
  Future<List<Day>> fetchDailyContent({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    final body = GetRequestBody(latitude: latitude, longitude: longitude, language: language);
    final dayList = await _weatherService.fetchDailyContent(body);
    return DailyMapper.fromApi(dayList);
  }

  @override
  Future<List<Hour>> fetchHourlyContent({
    required double latitude,
    required double longitude,
    required String language,
  }) async {
    final body = GetRequestBody(latitude: latitude, longitude: longitude, language: language);
    final result = await _weatherService.fetchHourlyContent(body);
    return HourlyMapper.fromApi(result);
  }
}
