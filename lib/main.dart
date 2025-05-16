import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/presentation/theme/theme_cubit.dart';
import 'package:flutter_clean_bloc/presentation/ui/core/loading_mask.dart';
import 'package:flutter_clean_bloc/service/app_initializer.dart';
import 'package:flutter_clean_bloc/service/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

import 'generated/codegen_loader.g.dart';
import 'presentation/common/app_constants.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/dark_theme.dart';
import 'presentation/theme/light_theme.dart';

void main() async {
  await AppInitializer.getInstance.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        AppConstants.enUS,
        AppConstants.viVN,
        AppConstants.jaJP
      ],
      path: AppConstants.assetTranslationPath,
      fallbackLocale: AppConstants.enUS,
      assetLoader: const CodegenLoader(),
      startLocale: AppConstants.enUS,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(
        ThemeMode.system,
        preferencesService: GetIt.instance.get<SharedPreferencesService>(),
      )..initialize(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: ThemeData.light().copyWith(
              splashFactory: NoSplash.splashFactory,
              extensions: <ThemeExtension<dynamic>>[
                LightTheme(),
              ],
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              splashFactory: NoSplash.splashFactory,
              extensions: <ThemeExtension<dynamic>>[
                DarkTheme(),
              ],
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: state,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppRouter.instance.router,
            builder: (context, child) {
              if (child == null) {
                return const SizedBox();
              } else {
                return LoadingMask(child: child);
              }
            },
          );
        }
      ),
    );
  }
}
