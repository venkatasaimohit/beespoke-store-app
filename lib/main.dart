import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'home_container.dart';
import 'providers/product_provider.dart';
import 'providers/preference_provider.dart';
import 'providers/history_provider.dart';
import 'screens/product_feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('preferences');
  await Hive.openBox('history');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PreferenceProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beespoke Store',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomeContainer(),
      ),
    );
  }
}