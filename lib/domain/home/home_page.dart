import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/entity/diary.dart';
import 'package:flutter_application_1/service/auth.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/domain/calendar/calendar_page.dart';
import 'package:flutter_application_1/domain/menstruation/menstruation_page.dart';
import 'package:flutter_application_1/domain/record/record_page.dart';
import 'package:flutter_application_1/domain/settings/setting_page.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/atoms/text_color.dart';
import 'package:flutter_application_1/service/push_notification.dart';
import 'package:flutter_application_1/service/setting.dart';
import 'package:flutter_application_1/util/datetime/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/organisms/calendar/weekly/weekly_calendar.dart';

GlobalKey<_HomePageState> homeKey = GlobalKey();

class HomePage extends StatefulWidget {
  HomePage({required Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum HomePageTabType { record, menstruation, calendar, setting }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;
  int _selectedIndex = 0;
  HomePageTabType get _selectedTab {
    return HomePageTabType.values[_selectedIndex];
  }

  List<Diary> diaries = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: HomePageTabType.values.length,
        vsync: this,
        initialIndex: _selectedIndex);
    _tabController.addListener(_handleTabSelection);
    cacheOrAuth().then((auth) {
      requestNotificationPermissions();
      SettingService(DatabaseConnection(auth.uid)).fetch().then((setting) {
        if (setting.isOnReminder) {
          analytics.logEvent(name: "user_allowed_notification");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomePageTabType.values.length,
      child: Scaffold(
        backgroundColor: PilllColors.background,
        appBar: null,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, color: PilllColors.border)),
          ),
          child: Ink(
            color: PilllColors.bottomBar,
            child: SafeArea(
              child: TabBar(
                controller: _tabController,
                labelColor: PilllColors.secondary,
                labelStyle: TextStyle(fontSize: 12),
                indicatorColor: Colors.transparent,
                unselectedLabelColor: TextColor.gray,
                tabs: <Tab>[
                  Tab(
                    text: "ピル",
                    icon: SvgPicture.asset(
                        _tabController.index == HomePageTabType.record.index
                            ? "images/tab_icon_pill_enable.svg"
                            : "images/tab_icon_pill_disable.svg"),
                  ),
                  Tab(
                    text: "生理",
                    icon: SvgPicture.asset(_tabController.index ==
                            HomePageTabType.menstruation.index
                        ? "images/menstruation.svg"
                        : "images/menstruation_disable.svg"),
                  ),
                  Tab(
                    text: "カレンダー",
                    icon: SvgPicture.asset(
                        _tabController.index == HomePageTabType.calendar.index
                            ? "images/tab_icon_calendar_enable.svg"
                            : "images/tab_icon_calendar_disable.svg"),
                  ),
                  Tab(
                    text: "設定",
                    icon: SvgPicture.asset(
                        _tabController.index == HomePageTabType.setting.index
                            ? "images/tab_icon_setting_enable.svg"
                            : "images/tab_icon_setting_disable.svg"),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            RecordPage(),
            MenstruationPage(),
            CalendarPage(),
            SettingPage(),
            // SettingsPage(),
          ],
        ),
        floatingActionButton: Visibility(
          visible: _selectedTab == HomePageTabType.calendar,
          child: Container(
            padding: const EdgeInsets.only(right: 10, bottom: 32),
            child: FloatingActionButton(
              onPressed: () {
                switch (_selectedTab) {
                  case HomePageTabType.record:
                    break;
                  case HomePageTabType.menstruation:
                    break;
                  case HomePageTabType.calendar:
                    analytics.logEvent(name: "calendar_fab_pressed");
                    final date = today();
                    transitionToPostDiary(context, date, diaries);
                    break;
                  case HomePageTabType.setting:
                    break;
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: PilllColors.secondary,
            ),
          ),
        ),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {
      if (_selectedIndex != _tabController.index) {
        _selectedIndex = _tabController.index;
        _screenTracking();
      }
    });
  }

  selectTab(HomePageTabType tab) {
    if (_selectedTab == tab) {
      return;
    }
    _tabController.animateTo(tab.index);
  }

  @override
  void didPush() {
    _screenTracking();
    super.didPush();
  }

  @override
  void didPop() {
    _screenTracking();
    super.didPop();
  }

  void _screenTracking() {
    analytics.setCurrentScreen(
      screenName: "${HomePageTabType.values[_tabController.index].screenName}",
    );
  }
}

extension HomePageTabFunctions on HomePageTabType {
  Widget widget() {
    switch (this) {
      case HomePageTabType.record:
        return RecordPage();
      case HomePageTabType.menstruation:
        return MenstruationPage();
      case HomePageTabType.calendar:
        return CalendarPage();
      case HomePageTabType.setting:
        return SettingPage();
    }
  }

  String get screenName {
    switch (this) {
      case HomePageTabType.record:
        return "RecordPage";
      case HomePageTabType.menstruation:
        return "MenstruationPage";
      case HomePageTabType.calendar:
        return "CalendarPage";
      case HomePageTabType.setting:
        return "SettingsPage";
    }
  }
}
