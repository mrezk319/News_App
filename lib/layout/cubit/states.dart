abstract class NewsStates {}
class NewsInitialState extends NewsStates{}
class changeCurrentIndex extends NewsStates{}

class NewsGetBusinessSuccess extends NewsStates{}
class NewsGetBusinessFailed extends NewsStates {
  final  String error;
  NewsGetBusinessFailed(this.error);
}

class NewsGetScienceSuccess extends NewsStates{}
class NewsGetScienceFailed extends NewsStates {
  final  String error;
  NewsGetScienceFailed(this.error);
}

class NewsLoadingSearch extends NewsStates{}
class NewsGetSportsSuccess extends NewsStates{}
class NewsGetSportsFailed extends NewsStates {
  final  String error;
  NewsGetSportsFailed(this.error);
}
class NewsGetSearchSuccess extends NewsStates{}
class NewsGetSearchFailed extends NewsStates {
  final  String error;
  NewsGetSearchFailed(this.error);
}

class InitializeState extends NewsStates{}
class ChangeModeState extends NewsStates{}