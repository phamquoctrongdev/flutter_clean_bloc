import 'package:flutter_clean_bloc/data/core/api_result.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';

abstract class CountryRepository {
  Future<ApiResult<List<CountryResponse>>> fetchAllCountries();

  Future<ApiResult<List<CountryResponse>>> search(String keyword);
}
