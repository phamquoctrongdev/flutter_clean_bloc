import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_bloc/data/core/api_result.dart';
import 'package:flutter_clean_bloc/data/repository/country/country_repository.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:flutter_clean_bloc/presentation/ui/home/home_cubit.dart';
import 'package:flutter_clean_bloc/presentation/ui/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CountryResponse>(),
  MockSpec<CountryRepository>(),
])
Future<void> main() async {
  late final MockCountryRepository mockRepository;
  setUpAll(() {
    mockRepository = MockCountryRepository();
  });
  blocTest(
    'Test HomeCubit initialize state',
    setUp: () {
      final mockResponseSuccess = ApiResult<List<CountryResponse>>.success(
        [
          MockCountryResponse(),
          MockCountryResponse(),
        ],
      );
      provideDummy(mockResponseSuccess);
      when(
        mockRepository.fetchAllCountries(),
      ).thenAnswer(
        (_) async {
          return mockResponseSuccess;
        },
      );
    },
    build: () => HomeCubit(repository: mockRepository)..initialize(),
    act: (cubit) => cubit.state,
    expect: () => [
      isA<HomeState>().having(
        (state) => state.countries.length,
        'List of country has 2 items',
        equals(2),
      ),
    ],
  );
}
