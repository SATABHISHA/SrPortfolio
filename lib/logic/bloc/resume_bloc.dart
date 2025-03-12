import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/resume_model.dart';
import '../../data/repositories/resume_repository.dart';

abstract class ResumeEvent {}

class LoadResume extends ResumeEvent {}

abstract class ResumeState {}

class ResumeLoading extends ResumeState {}

class ResumeLoaded extends ResumeState {
  final ResumeModel resume;
  ResumeLoaded(this.resume);
}

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  final ResumeRepository _repository;

  ResumeBloc(this._repository) : super(ResumeLoading()) {
    on<LoadResume>((event, emit) async {
      var resume = await _repository.fetchResume();
      emit(ResumeLoaded(resume));
    });
  }
}
