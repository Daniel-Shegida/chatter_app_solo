import 'package:elementary/elementary.dart';

import '../../service/bloc.dart';
import '../../service/rep/flutterFireRep.dart';
import '../../utils/dialog_controller.dart';
import '../../utils/error_handler.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final ErrorHandler _errorHandler;
  late final ProfileBloc _profileBloc;
  // late final ICitiesRepository _mockCitiesRepository;
  // late final IInterestsRepository _mockInterestsRepository;
  late final DialogController _dialogController;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  ProfileBloc get profileBloc => _profileBloc;

  @override
  DialogController get dialogController => _dialogController;

  /// Create an instance [AppScope].
  AppScope() {
    ChatRepository rep = ChatRepository();
    _errorHandler = DefaultErrorHandler();
    _profileBloc = ProfileBloc(chatRepository: rep);
    _dialogController = const DialogController();
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;


  /// Bloc for working with profile states.
  ProfileBloc get profileBloc;


  /// Controller for show dialogs.
  DialogController get dialogController;
}