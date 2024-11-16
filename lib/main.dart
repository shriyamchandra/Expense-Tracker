import 'package:finance_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(254, 90, 59, 181),
);
final kDarkColorScheme=ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125),);
void main() {
  // to lock the orientation of the device

  // WidgetsFlutterBinding.ensureInitialized(); // to ensure locking the orientation first
  // // then apply the UI
  // SystemChrome.setPreferredOrientations([ // to set the orientation of the device
  //   DeviceOrientation.portraitUp,
  // ]
  // ).then((fn){
  //
  // });
  runApp(
    MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            )
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        cardTheme: CardTheme(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge:  TextStyle(fontWeight: FontWeight.normal,color: kColorScheme.onSecondaryContainer,fontSize: 15),
        ),


        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,


        ),

      ),
      home: const Expenses(),
    ),
  );
}
