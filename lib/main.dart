// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Business%20Logic/Cubit/app_cubit.dart';
import 'package:news_app/Business%20Logic/Cubit/app_states.dart';
import 'package:news_app/Constants/constants.dart';
import 'package:news_app/Data/Source/cache_helper.dart';
import 'package:news_app/Data/Source/news_api.dart';
import 'Presentation/Layouts/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DieoHeleper.createDio();
  await CacheHelper.createInstance();
  if (CacheHelper.getData(key: 'lightMode') != null) {
    lightMode = CacheHelper.getData(key: 'lightMode')!;
  }
  Bloc.observer = MyBlocObserver();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit(),
      child: BlocBuilder<NewsCubit, NewsStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData(),
            darkTheme: themeData(),
            themeMode: lightMode ? ThemeMode.light : ThemeMode.dark,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}

ThemeData themeData() {
  const Color generalColorInLightMode = Colors.teal;
  const Color generalColorInDarkMode = Colors.blueGrey;
  AppBarTheme appBarTheme() {
    return lightMode
        ? (AppBarTheme(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundColorInLightTheme,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: backgroundColorInDarkTheme,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarDividerColor: backgroundColorInDarkTheme,
            ),
            backgroundColor: backgroundColorInLightTheme,
            centerTitle: true,
            iconTheme:
                const IconThemeData(color: generalColorInLightMode, size: 25),
            titleTextStyle: const TextStyle(
              color: generalColorInLightMode,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
          ))
        : (AppBarTheme(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundColorInDarkTheme,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: backgroundColorInLightTheme,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: backgroundColorInLightTheme,
            ),
            backgroundColor: backgroundColorInDarkTheme,
            foregroundColor: generalColorInDarkMode,
            centerTitle: true,
            iconTheme:
                const IconThemeData(color: generalColorInDarkMode, size: 25),
            titleTextStyle: const TextStyle(
              color: generalColorInDarkMode,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
          ));
  }

  BottomNavigationBarThemeData bottomNavigationBarThemeData() {
    return lightMode
        ? BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: backgroundColorInLightTheme,
            selectedItemColor: generalColorInLightMode,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          )
        : BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: backgroundColorInDarkTheme,
            selectedItemColor: generalColorInDarkMode,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          );
  }

  TextTheme textTheme() {
    return lightMode
        ? const TextTheme(
            bodyText1: TextStyle(
                fontSize: 17,
                height: 1,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            caption: TextStyle(height: 1, fontSize: 14, color: Colors.black),
          )
        : const TextTheme(
            bodyText1: TextStyle(
                fontSize: 17,
                height: 1,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            caption: TextStyle(height: 1, fontSize: 14, color: Colors.black),
          );
  }

  return ThemeData(
    appBarTheme: appBarTheme(),
    scaffoldBackgroundColor:
        lightMode ? backgroundColorInLightTheme : backgroundColorInDarkTheme,
    bottomNavigationBarTheme: bottomNavigationBarThemeData(),
    textTheme: textTheme(),
  );
}
