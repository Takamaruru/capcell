import 'dart:io';

import 'package:capcell/grid_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}

/// This method initializes macos_window_utils and styles the window.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> main() async {
  if (!kIsWeb) {
    if (Platform.isMacOS) {
      await _configureMacosWindowUtils();
      runApp(const MacosUIGalleryApp());
    } else if (Platform.isWindows) {
      runApp(const MyApp());
    }
  }
}

class MacosUIGalleryApp extends StatelessWidget {
  const MacosUIGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return MacosApp(
          title: 'macos_ui Widget Gallery',
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          home: WidgetGallery(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
    );
  }
}

class MacOShome extends StatefulWidget {
  const MacOShome({super.key});

  @override
  State<MacOShome> createState() => _MacOShomeState();
}

class _MacOShomeState extends State<MacOShome> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: pageIndex,
            scrollController: scrollController,
            itemSize: SidebarItemSize.large,
            onChanged: (i) {
              setState(() => pageIndex = i);
            },
            items: const [
              SidebarItem(label: Text('Page One')),
              SidebarItem(label: Text('Page Two')),
            ],
          );
        },
      ),
      endSidebar: Sidebar(
        startWidth: 200,
        minWidth: 200,
        maxWidth: 300,
        shownByDefault: false,
        builder: (context, _) {
          return const Center(child: Text('End Sidebar'));
        },
      ),
      child: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("すべてのプロジェクト", style: TextStyle(fontSize: 30)),
        centerTitle: false,
      ),
      body: const GridPage(),
    );
  }
}

class WidgetGallery extends StatefulWidget {
  const WidgetGallery({super.key});

  @override
  State<WidgetGallery> createState() => _WidgetGalleryState();
}

class _WidgetGalleryState extends State<WidgetGallery> {
  int pageIndex = 0;

  late final searchFieldController = TextEditingController();

  List<PlatformMenu> menuBarItems() {
    return [
      PlatformMenu(
        label: 'File',
        menus: [
          PlatformMenuItem(label: 'New', onSelected: () {}),
          PlatformMenuItem(label: 'Open', onSelected: () {}),
        ],
      ),
      PlatformMenu(
        label: 'Edit',
        menus: [
          PlatformMenuItem(label: 'Undo', onSelected: () {}),
          PlatformMenuItem(label: 'Redo', onSelected: () {}),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: menuBarItems(),
      child: MacosWindow(
        sidebar: Sidebar(
          top: MacosSearchField(
            placeholder: 'Search',
            controller: searchFieldController,
            onResultSelected: (result) {
              switch (result.searchKey) {
                case 'Buttons':
                  setState(() {
                    pageIndex = 0;
                    searchFieldController.clear();
                  });
                  break;
                case 'Indicators':
                  setState(() {
                    pageIndex = 1;
                    searchFieldController.clear();
                  });
                  break;
                case 'Fields':
                  setState(() {
                    pageIndex = 2;
                    searchFieldController.clear();
                  });
                  break;
                case 'Colors':
                  setState(() {
                    pageIndex = 3;
                    searchFieldController.clear();
                  });
                  break;
                case 'Dialogs and Sheets':
                  setState(() {
                    pageIndex = 4;
                    searchFieldController.clear();
                  });
                  break;
                case 'Toolbar':
                  setState(() {
                    pageIndex = 6;
                    searchFieldController.clear();
                  });
                  break;
                case 'ResizablePane':
                  setState(() {
                    pageIndex = 7;
                    searchFieldController.clear();
                  });
                  break;
                case 'Selectors':
                  setState(() {
                    pageIndex = 8;
                    searchFieldController.clear();
                  });
                  break;
                default:
                  searchFieldController.clear();
              }
            },
            results: const [
              SearchResultItem('Buttons'),
              SearchResultItem('Indicators'),
              SearchResultItem('Fields'),
              SearchResultItem('Colors'),
              SearchResultItem('Dialogs and Sheets'),
              SearchResultItem('Toolbar'),
              SearchResultItem('ResizablePane'),
              SearchResultItem('Selectors'),
            ],
          ),
          minWidth: 200,
          builder: (context, scrollController) {
            return SidebarItems(
              currentIndex: pageIndex,
              onChanged: (i) {
                if (kIsWeb && i == 10) {
                  launchUrl(
                    Uri.parse(
                      'https://www.figma.com/file/IX6ph2VWrJiRoMTI1Byz0K/Apple-Design-Resources---macOS-(Community)?node-id=0%3A1745&mode=dev',
                    ),
                  );
                } else {
                  setState(() => pageIndex = i);
                }
              },
              scrollController: scrollController,
              itemSize: SidebarItemSize.large,
              items: const [
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.uiwindow_split_2x1),
                  label: Text('すべてのプロジェクト'),
                ),
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.uiwindow_split_2x1),
                  label: Text('共有中'),
                ),
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.uiwindow_split_2x1),
                  label: Text('Layout'),
                  section: true,
                  disclosureItems: [
                    SidebarItem(
                      leading: MacosIcon(CupertinoIcons.macwindow),
                      label: Text('Toolbar'),
                    ),
                  ],
                  expandDisclosureItems: true,
                ),
              ],
            );
          },
          bottom: const MacosListTile(
            leading: MacosIcon(CupertinoIcons.profile_circled),
            title: Text('Tim Apple'),
            subtitle: Text('tim@apple.com'),
          ),
        ),
        endSidebar: Sidebar(
          startWidth: 200,
          minWidth: 200,
          maxWidth: 300,
          shownByDefault: false,
          builder: (context, _) {
            return const Center(child: Text('End Sidebar'));
          },
        ),
        child: [
          CupertinoTabView(builder: (_) => const Home()),
          CupertinoTabView(builder: (_) => const Home()),
        ][pageIndex],
      ),
    );
  }
}
