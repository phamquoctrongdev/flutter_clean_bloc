import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/data/repository/country/country_repository.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:flutter_clean_bloc/presentation/ui/home/home_state.dart';

import '../../../data/core/api_result.dart';

class HomeCubit extends Cubit<HomeState> {
  final CountryRepository repository;

  HomeCubit({
    required this.repository,
  }) : super(HomeState());

  Future<void> initialize() async {
    final result = await repository.fetchAllCountries();
    switch (result) {
      case Success<List<CountryResponse>>():
        final response = result.value;
        emit(
          HomeState(
            countries: response,
            status: HomeStatus.success,
          ),
        );
      case Failure<List<CountryResponse>>():
        emit(
          HomeState(
            status: HomeStatus.failure,
          ),
        );
        throw result.error;
    }
  }
}
