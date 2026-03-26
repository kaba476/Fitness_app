String shortFrenchWeekday(DateTime d) {
  const names = ['lun.', 'mar.', 'mer.', 'jeu.', 'ven.', 'sam.', 'dim.'];
  return names[d.weekday - 1];
}

String plannedDayLabel(DateTime d) {
  return '${shortFrenchWeekday(d)} ${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
}

bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
