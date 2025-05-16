import 'package:flutter_clean_bloc/data/core/api_endpoint.dart';
import 'package:flutter_clean_bloc/data/core/api_result.dart';
import 'package:flutter_clean_bloc/data/repository/country/country_repository.dart';

import '../../core/api_client.dart';
import '../../response/country/country_response.dart';

class CountryRepositoryImpl implements CountryRepository {
  final ApiClient client;

  CountryRepositoryImpl(this.client);

  @override
  Future<ApiResult<List<CountryResponse>>> fetchAllCountries() {
    return client.request(
        endpoint: APIEndpoint.allCountries,
        method: ApiMethod.get,
        decoder: (response) => (response.data as List)
            .map((element) => CountryResponse.fromJson(element))
            .toList());
  }

  @override
  Future<ApiResult<List<CountryResponse>>> search(String keyword) {
    return client.request(
      endpoint: '${APIEndpoint.search}/$keyword',
      method: ApiMethod.get,
      decoder: (response) => (response.data as List)
          .map((element) => CountryResponse.fromJson(element))
          .toList(),
    );
  }
}
