import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/l10n/l10n.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimeTrackingWidget extends StatefulWidget {
  const TimeTrackingWidget({super.key, required this.taskTimer, required this.onChange});
  final BoardItemModelTimeTrack taskTimer;

  final Function(BoardItemModelTimeTrack) onChange;

  @override
  TimeTrackingWidgetState createState() => TimeTrackingWidgetState();
}

class TimeTrackingWidgetState extends State<TimeTrackingWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  bool isTaskEnd = false;
  bool isTimerRun = false;
  late BoardItemModelTimeTrack taskTimerClone;

  _init() {
    // check is time start
    //if is Timer running calc difference
    if (taskTimerClone.isTimerRunning && taskTimerClone.timerStartTime != null) {
      // calculate timer
      final DateTime timeStartTask = taskTimerClone.timerStartTime!;
      final DateTime timeNow = DateTime.now().add(taskTimerClone.spendTime);
      final difference = timeNow.difference(timeStartTask).inSeconds;

      _stopWatchTimer.setPresetSecondTime(difference);
      taskTimerClone.spendTime = Duration(seconds: difference);
      _stopWatchTimer.onStartTimer();
      _stopWatchTimer.secondTime.listen((value) {
        taskTimerClone.spendTime = Duration(seconds: _stopWatchTimer.secondTime.value);
      });
    } else if (!taskTimerClone.isTimerRunning && taskTimerClone.timerStartTime != null) {
      _stopWatchTimer.setPresetSecondTime(taskTimerClone.spendTime.inSeconds);
      _stopWatchTimer.secondTime.listen((value) {
        taskTimerClone.spendTime = Duration(seconds: _stopWatchTimer.secondTime.value);
      });
    }
    setState(() {
      isTaskEnd = taskTimerClone.timerEndTime == null ? false : true;
      isTimerRun = _stopWatchTimer.isRunning;
    });
  }

  _onStartTime() {
    if (!taskTimerClone.isTimerRunning) {
      _stopWatchTimer.onStartTimer();
      taskTimerClone.timerStartTime = DateTime.now();
      taskTimerClone.isTimerRunning = true;
      _stopWatchTimer.secondTime.listen((value) {
        taskTimerClone.spendTime = Duration(seconds: _stopWatchTimer.secondTime.value);
        widget.onChange(taskTimerClone);
      });
      setState(() {
        isTimerRun = _stopWatchTimer.isRunning;
      });
    }
  }

  _onPauseTime() {
    taskTimerClone.isTimerRunning = false;
    taskTimerClone.timerStartTime = DateTime.now();
    taskTimerClone.spendTime = Duration(seconds: _stopWatchTimer.secondTime.value);
    _stopWatchTimer.onStopTimer();
    widget.onChange(taskTimerClone);
    setState(() {
      isTimerRun = _stopWatchTimer.isRunning;
      isTimerRun = _stopWatchTimer.isRunning;
    });
  }

  _onRestTime() {
    // clear task timer
    taskTimerClone.isTimerRunning = false;
    taskTimerClone.spendTime = Duration.zero;
    taskTimerClone.timerStartTime = null;
    taskTimerClone.timerEndTime = null;
    _stopWatchTimer.clearPresetTime();
    _stopWatchTimer.onResetTimer();
    widget.onChange(taskTimerClone);
    setState(() {
      isTaskEnd = false;
      isTimerRun = _stopWatchTimer.isRunning;
    });
  }

  _onEndTask() {
    taskTimerClone.isTimerRunning = false;
    taskTimerClone.timerStartTime = null;
    taskTimerClone.spendTime = Duration(seconds: _stopWatchTimer.secondTime.value);
    taskTimerClone.timerEndTime = DateTime.now();
    _stopWatchTimer.onStopTimer();
    widget.onChange(taskTimerClone);
    setState(() {
      isTaskEnd = true;
      isTimerRun = _stopWatchTimer.isRunning;
    });
  }

  @override
  void initState() {
    taskTimerClone = widget.taskTimer.clone();
    super.initState();
    _init();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(children: [
            Text(context.localizations.time_track,
                style: TextStyle(fontSize: 18, color: context.read<AppBloc>().state.themeName == "dark" ? Colors.white : null))
          ]),

          /// Display stop watch time
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snap) {
              final value = snap.data!;
              final displayTime = StopWatchTimer.getDisplayTime(value, hours: true, milliSecond: false);
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  displayTime,
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold, color: context.read<AppBloc>().state.themeName == "dark" ? Colors.white : null),
                ),
              );
            },
          ),

          /// Button
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: isTaskEnd
                      ? null
                      : isTimerRun
                          ? null
                          : _onStartTime,
                  child: Text(context.localizations.start),
                ),
                ElevatedButton(
                  onPressed: isTaskEnd ? null : _onPauseTime,
                  child: Text(context.localizations.pause),
                ),
                ElevatedButton(
                  onPressed: _onRestTime,
                  child: Text(context.localizations.rest),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .7,
            child: ElevatedButton(
              onPressed: isTaskEnd ? null : _onEndTask,
              child: Text(
                context.localizations.end_task,
              ),
            ),
          ),
          isTaskEnd
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Text(
                          style: const TextStyle(color: Color.fromARGB(255, 150, 54, 47), fontSize: 15),
                          "${context.localizations.the_task_was_ended_in} ${DateFormat('yyyy-MM-dd – kk:mm').format(taskTimerClone.timerEndTime!)} "),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
