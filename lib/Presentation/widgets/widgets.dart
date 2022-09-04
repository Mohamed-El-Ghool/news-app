import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../Business%20Logic/Cubit/app_cubit.dart';
import '../Screens/web_view.dart';
import '../../Constants/constants.dart';
import '../../Data/Model/article_model.dart';

Widget buildListItem(context, {required ArticleModel article}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(url: article.url)));
    },
    child: Container(
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: GridTile(
        child: FadeInImage(
          placeholder: const AssetImage('Assets/loading.gif'),
          image: NetworkImage('${article.urlToImage}'),
          placeholderFit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) =>
              const Image(image: AssetImage('Assets/news.png')),
          fit: BoxFit.cover,
          fadeInDuration: const Duration(seconds: 1),
        ),
        footer: Container(
          height: 90,
          color: lightMode
              ? Colors.teal.withOpacity(0.8)
              : Colors.blueGrey.withOpacity(0.8),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${article.title}',
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
              Text(
                '${article.description}',
                style: Theme.of(context).textTheme.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildArticlesList(context, List<ArticleModel> articles) {
  return ConditionalBuilder(
    condition: articles.isNotEmpty,
    builder: (context) => RefreshIndicator(
      color: lightMode ? Colors.teal : Colors.blueGrey,
      strokeWidth: 3,
      displacement: 100,
      onRefresh: () {
        return BlocProvider.of<NewsCubit>(context).updateList();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildListItem(context, article: articles[index]),
        ),
        itemCount: articles.length,
      ),
    ),
    fallback: (context) =>
        NewsCubit.isSearching && searchTextEditingController.text.isEmpty
            ? Container()
            : Center(
                child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('Assets/loading2.json')),
              ),
  );
}
