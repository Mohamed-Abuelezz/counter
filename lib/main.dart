import 'package:camera/camera.dart';
import 'package:counter/Providers/auth/loginProvider.dart';
import 'package:counter/Providers/auth/reportHistoryProvider.dart';
import 'package:counter/Providers/auth/reportProvider.dart';
import 'package:counter/Providers/themeProvider.dart';
import 'package:counter/Screens/loginScreen.dart';
import 'package:counter/Screens/navigation/navigationScreen.dart';
import 'package:counter/Screens/reportsHistory/reportsHistoryScreen.dart';
import 'package:counter/Screens/splash/splashScreen.dart';
import 'package:counter/helpers/mySharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MySharedPreference().initSharedPref();
  // runApp(MyApp());
  //WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<ReportHistoryProvider>(
          create: (context) => ReportHistoryProvider(),
        ),
        ChangeNotifierProvider<ReportProvider>(
          create: (context) => ReportProvider(),
        ),

        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),


        
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        if (MySharedPreference().getSharedPref()!.getInt('primary_color') !=
            null) {
          themeProvider.setSelectedPrimaryColor(Color(
              MySharedPreference().getSharedPref()!.getInt('primary_color')!));
        }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'cairo',
              scaffoldBackgroundColor: Colors.grey[150],
              primaryColor: themeProvider.primaryColor,
              useMaterial3: false,
              cardTheme: CardTheme(color: Colors.white),
              //  primarySwatch: getMaterialColor(const Color(0xffE5FF7D)),
            ),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }

  MaterialColor getMaterialColor(Color color) {
    final Map<int, Color> shades = {
      50: const Color.fromRGBO(27, 3, 48, .1),
      100: const Color.fromRGBO(27, 3, 48, .2),
      200: const Color.fromRGBO(27, 3, 48, .3),
      300: const Color.fromRGBO(27, 3, 48, .4),
      400: const Color.fromRGBO(27, 3, 48, .5),
      500: const Color.fromRGBO(27, 3, 48, .6),
      600: const Color.fromRGBO(27, 3, 48, .7),
      700: const Color.fromRGBO(27, 3, 48, .8),
      800: const Color.fromRGBO(27, 3, 48, .9),
      900: const Color.fromRGBO(27, 3, 48, 1),
    };
    return MaterialColor(color.value, shades);
  }
}
