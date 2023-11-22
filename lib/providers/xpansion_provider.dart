import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'xpansion_provider.g.dart';

@riverpod
class XpansionState extends _$XpansionState {
  @override
  bool build() {
    return true;
  }

  void setStart(bool newState) {
    state = newState;
  }
}

@riverpod
class XpansionState0 extends _$XpansionState0 {
  @override
  bool build() {
    return true;
  }

  void setStart(bool newState) {
    state = newState;
  }
}
