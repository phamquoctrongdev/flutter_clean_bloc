import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/presentation/common/app_extension.dart';
import 'package:flutter_clean_bloc/presentation/ui/core/app_text.dart';
import 'package:flutter_clean_bloc/presentation/ui/search/search_bloc.dart';
import 'package:flutter_clean_bloc/presentation/ui/search/search_event.dart';
import 'package:flutter_clean_bloc/presentation/ui/search/search_state.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repository/country/country_repository.dart';
import '../home/widget/country_item_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  bool isSearching = false;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.openLoadingMask());
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SearchBloc(
          repository: GetIt.instance.get<CountryRepository>(),
        )..add(InitialSearchEvent()),
        child: BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state.isLoading) {
              context.openLoadingMask();
            } else {
              context.closeLoadingMask();
            }
          },
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  spacing: 16.0,
                  children: [
                    SearchBar(
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          if (value.isEmpty) {
                            isSearching = false;
                          } else {
                            isSearching = true;
                          }
                          setState(() {});
                          if (!isSearching) {
                            return;
                          }
                          context.read<SearchBloc>().add(OnSearchEvent(value));
                        });
                      },
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 16.0,
                        children: [
                          AppText(
                              text:
                                  'Result: ${isSearching ? state.countriesByKeyword.length : state.countries.length}'),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => CountryItemView(
                                country: isSearching
                                    ? state.countriesByKeyword[index]
                                    : state.countries[index],
                              ),
                              itemCount: isSearching
                                  ? state.countriesByKeyword.length
                                  : state.countries.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 32.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
