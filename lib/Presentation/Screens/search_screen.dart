import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/constants.dart';
import '../../Business%20Logic/Cubit/app_cubit.dart';
import '../../Business Logic/Cubit/app_states.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        if (state is UpdatingArticlesListState) {
          BlocProvider.of<NewsCubit>(context)
              .getSearchReturnArticles(searchTextEditingController.text);
        }
        return buildArticlesList(context, NewsCubit.searchReturnArticles);
      },
    );
  }
}
