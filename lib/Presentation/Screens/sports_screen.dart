import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Business%20Logic/Cubit/app_cubit.dart';
import '../../Business%20Logic/Cubit/app_states.dart';
import '../widgets/widgets.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsCubit>(context).getSportsArticles();
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        return buildArticlesList(context, NewsCubit.sportsArticles);
      },
    );
  }
}
