abstract class InputEvent{}
class TimerToggle extends InputEvent{}
class UserLoadedEvent extends InputEvent{}
class SubmitEvent extends InputEvent{
  String text;
  bool timer;
  SubmitEvent(this.text,this.timer);
}