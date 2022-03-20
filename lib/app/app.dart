import 'package:chatter_solo_serfers/app/di/app_scope.dart';
import 'package:chatter_solo_serfers/common/widget/di.dart';
import 'package:chatter_solo_serfers/ui/screen/chat_screen.dart';
import 'package:flutter/material.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance [App].
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();
    _scope = AppScope();
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      factory: () {
        return _scope;
      },
      /// enter into screen with no navigation
      child: const ChatScreen(),
    );
  }
}
