import 'package:kanban/modules/kanban/models/comment.dart';

class BoardItemModel {
  int? id;
  String title;
  String description;
  List<Comment> comments;
  BoardItemModelTimeTrack boardItemModelTimeTrack;

  BoardItemModel({
    this.id,
    this.title = "",
    this.description = "",
    required this.boardItemModelTimeTrack,
    List<Comment>? comments,
  }) : comments = comments ?? [];

  factory BoardItemModel.fromJson(Map<String, dynamic> json) {
    return BoardItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      boardItemModelTimeTrack: BoardItemModelTimeTrack.fromJson(json['boardItemModelTimeTrack']),
      comments: List<Comment>.from(json['comments'].map((comment) => Comment.fromJson(comment))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'boardItemModelTimeTrack': boardItemModelTimeTrack.toJson(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  BoardItemModel copyWith({
    int? id,
    String? title,
    BoardItemModelTimeTrack? boardItemModelTimeTrack,
    bool? isTaskEnd,
    Duration? spendTime,
    String? description,
    DateTime? timerStartTime,
    List<Comment>? comments,
  }) {
    return BoardItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      boardItemModelTimeTrack: boardItemModelTimeTrack ?? this.boardItemModelTimeTrack,
      comments: comments ?? this.comments,
    );
  }
}

class BoardItemModelTimeTrack {
  Duration spendTime;
  DateTime? timerStartTime; // When the timer start
  DateTime? timerEndTime; // When the timer start
  bool isTimerRunning; // Whether the timer is running

  BoardItemModelTimeTrack({
    this.isTimerRunning = false,
    this.timerEndTime,
    this.spendTime = Duration.zero,
    this.timerStartTime,
  });

  factory BoardItemModelTimeTrack.fromJson(Map<String, dynamic> json) {
    return BoardItemModelTimeTrack(
      spendTime: Duration(seconds: json['spendTime']),
      isTimerRunning: json['isTimerRunning'],
      timerEndTime: json['timerEndTime'] != null ? DateTime.parse(json['timerEndTime']) : null,
      timerStartTime: json['timerStartTime'] != null ? DateTime.parse(json['timerStartTime']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'timerEndTime': timerEndTime?.toIso8601String(),
      'spendTime': spendTime.inSeconds,
      'isTimerRunning': isTimerRunning,
      'timerStartTime': timerStartTime?.toIso8601String(),
    };
  }

  BoardItemModelTimeTrack copyWith({
    Duration? spendTime,
    DateTime? timerStartTime,
    bool? isTimerRunning,
    DateTime? timerEndTime,
  }) {
    return BoardItemModelTimeTrack(
      spendTime: spendTime ?? this.spendTime,
      timerStartTime: timerStartTime ?? this.timerStartTime,
      timerEndTime: timerEndTime ?? this.timerEndTime,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
    );
  }

  BoardItemModelTimeTrack clone() {
    return BoardItemModelTimeTrack(
      spendTime: spendTime,
      timerStartTime: timerStartTime,
      isTimerRunning: isTimerRunning,
      timerEndTime: timerEndTime,
    );
  }
}
