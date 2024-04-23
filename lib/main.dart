import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/di.dart';
import 'data/data_source/local_data_source.dart';
import 'presentation/common/logic/cubit/language_app/language_app_cubit.dart';
import 'presentation/common/logic/cubit/theme/theme_cubit.dart';
import 'presentation/resources/language_manager.dart';
import 'presentation/resources/routes_manager.dart';
import 'presentation/resources/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await EasyLocalization.ensureInitialized();
  final storage =
      await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  await LocalDataSourceImpl().requestPermission(Permission.storage);
  await LocalDataSourceImpl().requestPermission(Permission.manageExternalStorage);
  await LocalDataSourceImpl().createFolder();
  await initAppModule();
  HydratedBlocOverrides.runZoned(
      () => runApp(EasyLocalization(
            child: BlocProvider<LanguageAppCubit>(
              create: (_) => LanguageAppCubit(),
              child: BlocBuilder<LanguageAppCubit, LanguageType>(
                builder: (context, state) {
                  return const MyApp();
                },
              ),
            ),
            supportedLocales: const [arabicLocale, englishLocale],
            path: assetPathLocalistions,
          )),
      storage: storage);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteGenerator _routeGenerator = RouteGenerator();

  @override
  void didChangeDependencies() async {
    var languageApp = context.read<LanguageAppCubit>().state;
    if (languageApp == LanguageType.arabic) {
      context.setLocale(arabicLocale);
    } else {
      context.setLocale(englishLocale);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(480, 800),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
            child: BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: state ? ThemeMode.dark : ThemeMode.light,
                  darkTheme: MyThemes.darkTheme,
                  theme: MyThemes.lightTheme,
                  onGenerateRoute: _routeGenerator.getRoute,
                  initialRoute: Routes.mainRoute,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                );
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    _routeGenerator.dispose();
    super.dispose();
  }
}
