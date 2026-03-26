class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.setsDetail,
    required this.muscleGroup,
    this.done = false,
  });

  final String id;
  final String name;
  final String setsDetail;
  final String muscleGroup;
  bool done;
}
