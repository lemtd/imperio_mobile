import 'package:empire/src/models/championship_model.dart';
import 'package:empire/src/models/sports_model.dart';
import 'package:empire/src/models/won_bet_model.dart';
import 'package:empire/src/services/championship_service.dart';
import 'package:empire/src/services/sports_service.dart';
import 'package:empire/src/services/won_bet_service.dart';
import 'package:empire/src/stores/tip_store.dart';
import 'package:empire/src/stores/won_bet_store.dart';
import 'package:empire/src/stores/bonus_store.dart';
import 'package:empire/src/stores/championship_store.dart';
import 'package:empire/src/stores/match_store.dart';
import 'package:empire/src/stores/sports_store.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final MatchStore matchStore;
  final SportsStore sportsStore;
  final ChampionshipStore championshipStore;
  final BonusStore bonusStore;
  final WonBetStore wonBetStore;
  final TipStore tipStore;
  final SportsService sportsService;
  final ChampionshipService championshipService;
  final WonBetService wonBetService;
  
  _AppControllerBase(this.matchStore, this.sportsStore, this.championshipStore, this.bonusStore, this.wonBetStore, this.tipStore, this.sportsService, this.championshipService, this.wonBetService);

  @observable
  List<SportsModel> listSports = [];

  @observable
  List<ChampionshipModel> listChampionships = [];

  @observable
  List<WonBetModel> listWonBets = [];

  Future<void> initStore() async {
    await matchStore.fetchMatches();
    await sportsStore.fetchSports();
    await championshipStore.fetchChampionships();
    await bonusStore.fetchBonus();
    await wonBetStore.fetchWonBets();
    await tipStore.fetchTips();
  }

  Future<void> initValues() async {
    await setListSports();
    await setListChampionships();
    await setListWonBets();
  }

  @action
  Future<bool> setListSports() async {
    listSports = await sportsService.getSports();
    return true;
  }

  @action
  Future<bool> setListChampionships() async {
    listChampionships = await championshipService.getChampionships();
    return true;
  }

  @action
  Future<bool> setListWonBets() async {
    listWonBets = await wonBetService.getWonBets();
    return true;
  }
}