import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_bloc/presentation/theme/theme_cubit.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ThemeSwitcher(),
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Theme Switcher")),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.light),
                  child: Text("Light Theme"),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.dark),
                  child: Text("Dark Theme"),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ThemeCubit>().setTheme(ThemeMode.system),
                  child: Text("System Theme"),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
