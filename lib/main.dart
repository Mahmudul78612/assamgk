import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/ask_ai_screen.dart';
import 'screens/more_screen.dart';
import 'screens/chapter_screen.dart';
import 'screens/topic_screen.dart';
import 'providers/chapter_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'models/chapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(prefs)),
        ChangeNotifierProvider(create: (_) => ChapterProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            title: 'Assam GK & Current Affairs',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('as'),
            ],
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/chapter':
                  final chapterId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (context) => ChapterScreen(chapterId: chapterId),
                  );
                case '/topic':
                  final topic = settings.arguments as Topic;
                  return MaterialPageRoute(
                    builder: (context) => TopicScreen(topic: topic),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  );
              }
            },
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AskAIScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Load chapters when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChapterProvider>().loadChapters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assam GK & Current Affairs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Ask AI',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
