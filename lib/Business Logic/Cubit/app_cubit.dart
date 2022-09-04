import 'package:bloc/bloc.dart';
import '../../Data/Source/cache_helper.dart';
import '../../Business%20Logic/Cubit/app_states.dart';
import '../../Constants/constants.dart';
import '../../Data/Model/article_model.dart';
import '../../Data/Repository/repository.dart';

class NewsCubit extends Cubit<NewsStates> {
  ArticlesRepository? articlesRepository;
  NewsCubit() : super(InitialState()) {
    articlesRepository = ArticlesRepository();
  }

  static int currentIndex = 0;
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  static bool isSearching = false;
  void changeIsSearching(bool isSearch) {
    isSearching = isSearch;
    emit(IsSearchingState());
  }

  void changeThemeMode() {
    lightMode = !lightMode;
    CacheHelper.setData(key: 'lightMode', value: lightMode).then((vlaue) {
      emit(ThemeModeState());
    });
  }

  String defaultImage =
      'https://img.freepik.com/free-photo/network-connection-graphic-overlay-background-computer-screen_53876-120776.jpg';
  List<ArticleModel> mappingArticles(List articles) {
    return articles.map<ArticleModel>((article) {
      return ArticleModel(
          source: article['source'] ?? {},
          author: article['author'] ?? '',
          title: article['title'],
          description: article['description'] ?? article['title'],
          url: article['url'],
          urlToImage: article['urlToImage'] ?? defaultImage,
          publishedAt: article['publishedAt'],
          content: article['content'] ?? '');
    }).toList();
  }

  String endPoint = 'v2/top-headlines'; //path
  String searchEndPoint = 'v2/everything';
  bool refrech = false;
  static List<ArticleModel> businessArticles = [];
  void getBusinessArticles() {
    if (businessArticles.isEmpty || refrech) {
      refrech = false;
      Map<String, dynamic> queryParameters = {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'bb9100eec6db4a97ae699950d59fec7d'
      };
      emit(BusinessArticlesIsLoadingState());
      articlesRepository!
          .getArticles(endPoint: endPoint, queryParameters: queryParameters)
          .then((artticls) {
        businessArticles = mappingArticles(artticls);
        emit(BusinessArticlesLoadedState());
      });
    } else {
      emit(BusinessArticlesLoadedState());
    }
  }

  static List<ArticleModel> sportsArticles = [];
  void getSportsArticles() {
    if (sportsArticles.isEmpty || refrech) {
      refrech = false;
      Map<String, dynamic> queryParameters = {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'bb9100eec6db4a97ae699950d59fec7d'
      };
      emit(SportsArticlesIsLoadingState());
      articlesRepository!
          .getArticles(endPoint: endPoint, queryParameters: queryParameters)
          .then((artticls) {
        sportsArticles = mappingArticles(artticls);
        emit(SportsArticlesLoadedState());
      });
    } else {
      emit(SportsArticlesLoadedState());
    }
  }

  static List<ArticleModel> scienceArticles = [];
  void getScienceArticles() {
    refrech = false;
    if (scienceArticles.isEmpty || refrech) {
      Map<String, dynamic> queryParameters = {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'bb9100eec6db4a97ae699950d59fec7d'
      };
      emit(ScienceArticlesIsLoadingState());
      articlesRepository!
          .getArticles(endPoint: endPoint, queryParameters: queryParameters)
          .then((artticls) {
        scienceArticles = mappingArticles(artticls);
        emit(ScienceArticlesLoadedState());
      });
    } else {
      emit(ScienceArticlesLoadedState());
    }
  }

  static List<ArticleModel> searchReturnArticles = [];
  void getSearchReturnArticles(String value) {
    refrech = false;
    Map<String, dynamic> queryParameters = {
      'q': value,
      'apiKey': 'bb9100eec6db4a97ae699950d59fec7d'
    };
    emit(ReturnFromSearchIsLoadingState());
    articlesRepository!
        .getArticles(endPoint: searchEndPoint, queryParameters: queryParameters)
        .then((artticls) {
      searchReturnArticles = mappingArticles(artticls);
      emit(ReturnFromSearchLoadedState());
    });
  }

  Future<void> updateList() async {
    refrech = true;
    emit(UpdatingArticlesListState());
    if (isSearching) {
      searchReturnArticles.clear();
      getSearchReturnArticles(searchTextEditingController.text);
    } else {
      switch (currentIndex) {
        case 0:
          businessArticles.clear();
          getBusinessArticles();
          break;
        case 1:
          sportsArticles.clear();
          getSportsArticles();
          break;
        case 2:
          scienceArticles.clear();
          getScienceArticles();
          break;
      }
    }
  }
}
