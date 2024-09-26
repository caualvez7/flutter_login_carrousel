import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
  with TickerProviderStateMixin {
  
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: _pageViewController,
          onPageChanged: _handlePageViewChanged,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assests/woman-training-workout-gym 1.png"),
                  fit: BoxFit.cover,
                ),
              ), 
            ),
            
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assests/woman-training-workout-gym 2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text('Second Page', style: textTheme.titleLarge),  
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assests/woman-training-workout-gym 3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text('Third Page', style: textTheme.titleLarge),  
              ),
            ),
          ]
        ),

        
        PageIndicator(
          currentPageIndex: _currentPageIndex,
          tabController: _tabController,
          onUpdateCurrentPageIndex: _handlePageViewChanged,
          handleNextPage: _nextPage,
        ),  
      ],
    );
  }

  void _nextPage() {
    _pageViewController.animateToPage(
      (_currentPageIndex+1)%3,
      duration: const Duration(milliseconds: 400), 
      curve: Curves.easeInOut
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex%3;
    setState(() {
      _currentPageIndex = currentPageIndex%3;
    });
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.handleNextPage,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final void Function() handleNextPage;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
          TextButton(
              onPressed: handleNextPage, 
              child: Text("Próximo")
            )
        ],
      ),
    );
  }
  
}


