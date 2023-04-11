import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:link_life_one/models/local_objects/m_gyosya.dart';
import 'package:link_life_one/models/local_objects/m_kbn.dart';
import 'package:link_life_one/models/local_objects/m_syohin.dart';
import 'package:link_life_one/models/local_objects/m_tant.dart';
import 'package:link_life_one/models/local_objects/t_koji.dart';
import 'package:link_life_one/models/local_objects/t_koji_check.dart';
import 'package:link_life_one/models/local_objects/t_koji_file_path.dart';
import 'package:link_life_one/models/local_objects/t_kojimsai.dart';
import 'package:link_life_one/models/local_objects/t_tirasi.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/shared/cache_notifier.dart';
import 'package:provider/provider.dart';
import 'screen/login_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(MGyosyaAdapter());
  Hive.registerAdapter(MSyohinAdapter());
  Hive.registerAdapter(MTantAdapter());
  Hive.registerAdapter(MKBNAdapter());
  Hive.registerAdapter(TKojiAdapter());
  Hive.registerAdapter(TKojiCheckAdapter());
  Hive.registerAdapter(TKojiFilePathAdapter());
  Hive.registerAdapter(TKojimsaiAdapter());
  Hive.registerAdapter(TTirasiAdapter());
  runApp(ChangeNotifierProvider(
      create: (_) => CacheNotifier(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(810, 1080),
        builder: (context, _) => MaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              navigatorObservers: [routeObserver],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: const Locale('ja', 'JP'),
              supportedLocales: const [Locale('ja', 'JP')],
              home: const LoginPage(),
            ));
    ;
  }
}
