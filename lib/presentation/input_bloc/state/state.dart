abstract class InputState{}
class LoadingInput extends InputState{}
class Show extends InputState{
  bool timer;
  Show(this.timer);
}