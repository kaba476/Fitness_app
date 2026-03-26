import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/planned_slot.dart';
import '../theme/app_theme.dart';
import '../utils/date_format_fr.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key, required this.state});

  final FitnessAppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slots = state.weekSlots;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      itemCount: slots.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Planning',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '7 prochains jours (démo)',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: 20),
              _WeekSummaryRow(slots: slots),
              const SizedBox(height: 24),
              Text(
                'Détail',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        }

        final slot = slots[i - 1];
        final today = isSameDate(slot.day, DateTime.now());

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: ListTile(
              onTap: () => state.toggleSlotDone(i - 1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: today
                      ? AppColors.mint.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.06),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${slot.day.day}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    Text(
                      shortFrenchWeekday(slot.day),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: today
                            ? AppColors.mint
                            : Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      slot.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration:
                            slot.done ? TextDecoration.lineThrough : null,
                        color: slot.done
                            ? Colors.white.withValues(alpha: 0.45)
                            : null,
                      ),
                    ),
                  ),
                  if (today)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.coral.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Aujourd’hui',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.coral,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  '${plannedDayLabel(slot.day)} · ${slot.subtitle}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              trailing: Icon(
                slot.done
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: slot.done
                    ? AppColors.mint
                    : Colors.white.withValues(alpha: 0.35),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WeekSummaryRow extends StatelessWidget {
  const _WeekSummaryRow({required this.slots});

  final List<PlannedSlot> slots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: slots.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final slot = slots[index];
          final day = slot.day;
          final done = slot.done;
          final today = isSameDate(day, DateTime.now());

          return Container(
            width: 64,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: today
                  ? AppColors.mint.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: today
                    ? AppColors.mint.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shortFrenchWeekday(day),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${day.day}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  done ? Icons.check_rounded : Icons.more_horiz_rounded,
                  size: 18,
                  color: done
                      ? AppColors.mint
                      : Colors.white.withValues(alpha: 0.38),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
