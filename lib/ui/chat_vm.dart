import 'package:chatter_solo_serfers/ui/chat_model.dart';
import 'package:chatter_solo_serfers/ui/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';


/// Factory for [CountryListScreenWidgetModel]
ChatVM ChatVMFactory(
    BuildContext context,
    ) {
  // final model = context.read<ChatModel>();
  final model = ChatModel();

  // final theme = context.read<ThemeWrapper>();
  return ChatVM(
      model,
    // theme
  );
}



/// Widget Model for [CountryListScreen]
class ChatVM
    extends WidgetModel<ChatScreen, ChatModel>
    implements IChatWidgetModel {
  // final ThemeWrapper _themeWrapper;

  // final _countryListState = EntityStateNotifier<Iterable<Country>>();
  // late TextStyle _countryNameStyle;

  // @override
  // ListenableState<EntityState<Iterable<Country>>> get countryListState =>
  //     _countryListState;

  // @override
  // TextStyle get countryNameStyle => _countryNameStyle;

  ChatVM(
       ChatModel model,
      // this._themeWrapper,
      ) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    // _loadCountryList();
    // _countryNameStyle =
    //     _themeWrapper.getTextTheme(context).headline4 ?? AppTypography.title3;
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);

    // if (error is DioError &&
    //     (error.type == DioErrorType.connectTimeout ||
    //         error.type == DioErrorType.receiveTimeout)) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Connection troubles')));
    // }
  }

  // Future<void> _loadCountryList() async {
  //   final previousData = _countryListState.value?.data;
  //   _countryListState.loading(previousData);
  //
  //   try {
  //     final res = await model.loadCountries();
  //     _countryListState.content(res);
  //   } on Exception catch (e) {
  //     _countryListState.error(e, previousData);
  //   }
  // }

  @override
  void diplay() {
    print("da");
   }

  @override
  void diplay2() {
    print("da");
  }

  @override
  List<String> list = ["1","2"];

  @override
  bool chatMode = true;

  @override
  Query<Map<String, dynamic>> chat = FirebaseFirestore.instance.collection("daaaazzxczqwqe").orderBy("time") ;

  @override
  Stream stream = FirebaseFirestore.instance.collection("daaaazzxczqwqe").orderBy("time").snapshots() ;
}

/// Interface of [ChatWm]
abstract class IChatWidgetModel extends IWidgetModel {
  void diplay(){
    print("da");
  }
  void diplay2(){
    print("da2");
  }
  Query<Map<String, dynamic>> chat = FirebaseFirestore.instance.collection("daaaazzxczqwqe").orderBy("time") ;

  late Stream stream;
  late List<String> list;
  late bool chatMode;

// ListenableState<EntityState<Iterable<Country>>> get countryListState;
  //
  // TextStyle get countryNameStyle;
}