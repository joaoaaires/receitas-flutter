import 'dart:collection';

class Task {
  static Task _task;
  static Map<String, Future> _tasks = HashMap();

  factory Task() {
    _task ??= Task._internalConstructor();
    print(
      ">>>>>>>>> Iniciando Task Unica Vez. ${_task.hashCode}",
    );
    return _task;
  }

  Task._internalConstructor();

  void run({String cod, Future<Null> future}) async {
    Future<Null> futureTask = _tasks[cod];
    if (futureTask == null) {
//      print("UMA VEZ");
//      _tasks[cod] = future;
//      await future;
//      _tasks[cod].then((value) => null);
//      await future.then((value) => null);
    }
//    print(_tasks.length);
//    _tasks.remove(cod);
  }
}

