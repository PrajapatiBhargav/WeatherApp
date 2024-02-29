import 'package:bloc/bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/screens/home/bloc/weather_event.dart';
import 'package:weather_app/screens/home/bloc/weather_state.dart';

import '../../../data/data.dart';


class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}