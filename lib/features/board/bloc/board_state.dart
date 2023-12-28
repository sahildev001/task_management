part of 'board_cubit.dart';

@immutable
abstract class BoardState {}

class BoardInitial extends BoardState {}
class UpdateTaskBoardState extends BoardState {}
