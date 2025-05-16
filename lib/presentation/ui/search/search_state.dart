import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@Freezed(toJson: false, fromJson: false)
class SearchState with _$SearchState {
  const factory SearchState({
    @Default([]) List<CountryResponse> countries,
    @Default([]) List<CountryResponse> countriesByKeyword,
    @Default(false) bool isLoading,
    @Default(false) bool isSearching,
  }) = _SearchState;
}
