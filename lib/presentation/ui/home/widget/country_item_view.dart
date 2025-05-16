import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_bloc/data/response/country/country_response.dart';
import 'package:flutter_clean_bloc/presentation/ui/core/app_text.dart';

class CountryItemView extends StatelessWidget {
  const CountryItemView({
    super.key,
    required this.country,
  });

  final CountryResponse country;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.5,
            ),
            blurRadius: 5,
          )
        ]
      ),
      child: Row(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: country.flags.png,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                AppText(text: country.name.common),
                AppText(text: country.name.official),
              ],
            ),
          )
        ],
      ),
    );
  }
}
