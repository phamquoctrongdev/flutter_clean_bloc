import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/data/core/api_result.dart';
import 'package:flutter_clean_bloc/data/repository/country/country_repository.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:flutter_clean_bloc/presentation/ui/search/search_event.dart';
import 'package:flutter_clean_bloc/presentation/ui/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CountryRepository repository;

  SearchBloc({required this.repository}) : super(SearchState()) {
    on<InitialSearchEvent>(_initialFetch);
    on<OnSearchEvent>(_onSearch);
  }

  Future<void> _initialFetch(
    InitialSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    final result = await repository.fetchAllCountries();
    switch (result) {
      case Success<List<CountryResponse>>():
        return emit(
          state.copyWith(
            countries: result.value,
          ),
        );
      case Failure<List<CountryResponse>>():
        throw result.error;
    }
  }

  Future<void> _onSearch(
    OnSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        countriesByKeyword: [],
      ),
    );
    final result = await repository.search(event.keyword);
    switch (result) {
      case Success<List<CountryResponse>>():
        return emit(
          state.copyWith(
            countriesByKeyword: result.value,
            isLoading: false,
          ),
        );
      case Failure<List<CountryResponse>>():
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
        throw result.error;
    }
  }
}
