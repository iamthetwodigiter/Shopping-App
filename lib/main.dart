import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/features/products/presentation/pages/products_catalogue_page.dart';

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 216, 229),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 255, 216, 229),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.pink,
        ),
      ),
      home: ProductsCataloguePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
