import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../Business%20Logic/Cubit/app_states.dart';
import '../../Business%20Logic/Cubit/app_cubit.dart';
import '../../Constants/constants.dart';
import '../Screens/sports_screen.dart';
import '../Screens/business_screen.dart';
import '../Screens/science_screen.dart';
import '../Screens/search_screen.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  late NewsCubit newsCubit;
  HomeLayout({Key? key}) : super(key: key);
  Widget buildSearchField() {
    return TextField(
      controller: searchTextEditingController,
      decoration: const InputDecoration(
        hintText: 'Search',
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      style: TextStyle(
          color: lightMode ? Colors.teal : Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.bold),
      onChanged: (value) {
        if (value.isNotEmpty && value != ' ') {
          newsCubit.getSearchReturnArticles(value);
        }
      },
    );
  }

  Widget buildAppbarLeading(context) {
    void stopSearch() {
      searchTextEditingController.clear();
      newsCubit.changeIsSearching(false);
    }

    void startSearch() {
      ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
        onRemove: stopSearch,
      ));
      newsCubit.changeIsSearching(true);
    }

    if (NewsCubit.isSearching) {
      return IconButton(
          onPressed: () {
            searchTextEditingController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
          ));
    } else {
      return IconButton(
          onPressed: () {
            startSearch();
          },
          icon: const Icon(
            Icons.search,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    newsCubit = BlocProvider.of<NewsCubit>(context);
    List<Widget> screens = [
      const BusinessScreen(),
      const SportScreen(),
      const ScienceScreen(),
      const SearchScreen(),
    ];
    List<String> appBarTitles = [
      'Business News',
      'Sports News',
      'Science News',
    ];
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: ((context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: buildAppbarLeading(context),
            title: NewsCubit.isSearching
                ? buildSearchField()
                : Text(
                    appBarTitles[NewsCubit.currentIndex],
                  ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FlutterSwitch(
                    value: !lightMode,
                    width: 46,
                    height: 23,
                    padding: 2,
                    activeColor: Colors.blueGrey,
                    inactiveColor: Colors.teal,
                    activeIcon: const Icon(
                      Icons.dark_mode,
                    ),
                    inactiveIcon: const Icon(
                      Icons.light_mode,
                    ),
                    onToggle: (value) {
                      SystemChrome.setSystemUIOverlayStyle(
                        Theme.of(context).appBarTheme.systemOverlayStyle!,
                      );
                      newsCubit.changeThemeMode();
                    }),
              ),
            ],
          ),
          body: NewsCubit.isSearching
              ? screens[3]
              : screens[NewsCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsCubit.currentIndex,
            onTap: (index) {
              if (NewsCubit.isSearching) {
                newsCubit.changeIsSearching(false);
              }
              newsCubit.changeCurrentIndex(index);
            },

            // ignore: prefer_const_literals_to_create_immutables
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: 'Business'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.sports_football), label: 'Sport'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: 'Science'),
            ],
          ),
        );
      }),
    );
  }
}
