class PlannedSlot {
  PlannedSlot({
    required this.day,
    required this.title,
    required this.subtitle,
    this.done = false,
  });

  final DateTime day;
  final String title;
  final String subtitle;
  bool done;
}
