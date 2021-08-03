import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/Network/local/shared_helper.dart';
import 'package:news_app/shared/Network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  get error => null;

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNav = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_sharp), label: "Bussiness"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball_sharp), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];

  List pages = [
    Business(),
    Sports(),
    Science(),
  ];
  List<String> titleNames = [
    "Business",
    "Sports",
    "Science",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 1)
      getSports();
    else if (index == 2) getSciences();
    emit(changeCurrentIndex());
  }

  List<dynamic> business = [];

  void getBusiess() {
    if (business.length == 0) {
      DioHelper.getData(queries: {
        'category': 'business',
        'country': 'eg',
        'apiKey': 'afe009d8d0d944d2936f28de8b92bd7a'
      }, path: 'v2/top-headlines')
          .then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetBusinessFailed(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccess());
    }
  }

  List<dynamic> science = [];

  void getSciences() {
    if (science.length == 0) {
      DioHelper.getData(queries: {
        'category': 'science',
        'country': 'eg',
        'apiKey': 'afe009d8d0d944d2936f28de8b92bd7a'
      }, path: 'v2/top-headlines')
          .then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetScienceFailed(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccess());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      DioHelper.getData(queries: {
        'category': 'sports',
        'country': 'eg',
        'apiKey': 'afe009d8d0d944d2936f28de8b92bd7a'
      }, path: 'v2/top-headlines')
          .then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSportsFailed(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccess());
    }
  }

  List<dynamic> search =[];

  void getSearch(value) {
    emit(NewsLoadingSearch());
    print(value);
      DioHelper.getData(queries: {
        'q': '$value',
        'apiKey': 'afe009d8d0d944d2936f28de8b92bd7a'
      }, path: 'v2/everything')
          .then((value) {
        search = value.data['articles'];
        emit(NewsGetSearchSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSearchFailed(error.toString()));
      });
  }

  bool isDark = true;

  void changeMode({bool? fromshared}) {
    if(fromshared != null){
      isDark = fromshared;
      emit(ChangeModeState());
    }else {
      isDark = !isDark;
      SharedHelper.putBoolean(key: 'isDark', val: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }
}
