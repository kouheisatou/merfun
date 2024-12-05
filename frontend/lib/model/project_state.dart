import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_state.freezed.dart';

@freezed
class ProjectState with _$ProjectState {
  const factory ProjectState({
    @Default(0) String title,
    @Default(0) String image,
  }) = _ProjectState;
}