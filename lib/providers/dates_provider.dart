import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dates_provider.g.dart';

@riverpod
class DateState extends _$DateState {
  @override
  String build() {
    return "";
  }

  void setDate(String newState) {
    state = newState;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
}

@riverpod
class EndTimeState extends _$EndTimeState {
  @override
  String build() {
    return "";
  }

  void setEnd(String newState) {
    state = newState;
  }
}
