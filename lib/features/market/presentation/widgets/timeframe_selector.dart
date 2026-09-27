import 'package:flutter/material.dart';

class TimeframeSelector extends StatelessWidget {
  final String selectedTimeframe;
  final ValueChanged<String> onChanged;

  const TimeframeSelector({
    super.key,
    required this.selectedTimeframe,
    required this.onChanged,
  });

  static const List<String> timeframes = [
    '1m',
    '5m',
    '15m',
    '1H',
    '1D',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: timeframes.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 8);
        },
        itemBuilder: (
          context,
          index,
        ) {
          final timeframe =
              timeframes[index];

          final selected =
              timeframe ==
                  selectedTimeframe;

          return GestureDetector(
            onTap: () {
              onChanged(timeframe);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context)
                        .colorScheme
                        .primary
                    : Colors.grey
                        .withOpacity(0.12),
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Text(
                timeframe,
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}