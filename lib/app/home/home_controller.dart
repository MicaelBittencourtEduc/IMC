import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  Future<SharedPreferences> sharedRepository = SharedPreferences.getInstance();

  @observable
  double peso = 0;

  @observable
  double altura = 0;

  @observable
  double resultado = 0;

  @observable
  String status = '';

  @observable
  String image = 'assets/images/boneco_1.png';

  @observable
  bool isLoading;

  @observable
  List<String> listData = [];

  List<String> listImages = [
    'assets/images/boneco_1.png',
    'assets/images/boneco_2.png',
    'assets/images/boneco_3.png',
    'assets/images/boneco_4.png',
    'assets/images/boneco_5.png',
    'assets/images/boneco_6.png',
  ];
  var dateNow = DateFormat("dd/MM/yyyy")
      .format(DateTime.parse(DateTime.now().toString()));

  _HomeControllerBase() {
    getListData();
  }

  getListData() async {
    await sharedRepository.then((onValue) {
      listData = onValue.getStringList('list-imc') ?? [];
    });
  }

  @action
  calculaIMC() async {
    if(altura > 0 && peso > 0){
      resultado = peso / (altura * altura);
    }
    return resultado;
  }

  @action
  verificaSituacao() {
    if (resultado < 16) {
      status = 'Magreza grave';
      image = listImages[0];
    } else if (resultado >= 16 && resultado < 17) {
      status = 'Magreza moderada';
      image = listImages[0];
    } else if (resultado >= 17 && resultado < 18.5) {
      status = 'Magreza leve';
      image = listImages[1];
    } else if (resultado >= 18.5 && resultado < 25) {
      status = 'Saudável';
      image = listImages[2];
    } else if (resultado >= 25 && resultado < 30) {
      status = 'Sobrepeso';
      image = listImages[3];
    } else if (resultado >= 30 && resultado < 35) {
      status = 'Obesidade Grau I';
      image = listImages[4];
    } else if (resultado >= 35 && resultado < 40) {
      status = 'Obesidade Grau II (severa)';
      image = listImages[5];
    } else if (resultado >= 40) {
      status = 'Obesidade Grau III (mórbida)';
      image = listImages[5];
    } else {
      status = 'Valores fora de parâmetros';
    }
  }

  @action
  setListData() async {
    await sharedRepository.then((onValue) {
      listData.add(
          '{"altura": "$altura", "peso": "$peso", "status": "$status", "date": "$dateNow"}');
      onValue.setStringList('list-imc', listData);
    });
  }

  cleanListData() async {
    await sharedRepository.then((onValue) {
      onValue.remove('list-imc');
    });
  }
/*
  @action
  init() async {
    List listLocal = await sharedRepository.readData();
    print('LISTA:: $listLocal');
    if (listLocal == null) {
      listData = [];
    } else {
      listData = listLocal;
    }
    isLoading = false;
  }
  */
}
