import 'package:flutter/foundation.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<CountryResponse> countries,
    @Default(HomeStatus.initial) HomeStatus status,
  }) = _HomeState;
}
