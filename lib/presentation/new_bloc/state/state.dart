import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';

abstract class ListState{}
class LoadingState extends ListState{}
class ShowDataState extends ListState{
  final List<Entity> data;
  ShowDataState(this.data);
}
class RefreshDataState extends ListState{
  final List<int> indexInserted;
  final List<int> indexRemoved;
  RefreshDataState(this.indexInserted,this.indexRemoved);
}
class RemoveSingleMessageState extends ListState{
  final int indexRemoved;
  final Message message;
  RemoveSingleMessageState(this.message,this.indexRemoved);
}
class RemoveSingleMessageStateWithOutAnimation extends ListState{
  final int indexRemoved;
  final Message message;
  RemoveSingleMessageStateWithOutAnimation(this.message,this.indexRemoved);
}