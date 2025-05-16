import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/data/repository/country/country_repository.dart';
import 'package:flutter_clean_bloc/presentation/common/app_extension.dart';
import 'package:flutter_clean_bloc/presentation/ui/home/home_state.dart';
import 'package:flutter_clean_bloc/presentation/ui/home/widget/country_item_view.dart';
import 'package:get_it/get_it.dart';

import 'home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.openLoadingMask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeCubit(
          repository: GetIt.instance.get<CountryRepository>(),
        )..initialize(),
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.status == HomeStatus.loading) {
              context.openLoadingMask();
            } else {
              context.closeLoadingMask();
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.countries.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (context, index) => CountryItemView(
                        country: state.countries[index],
                      ),
                      itemCount: state.countries.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 32.0,
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
