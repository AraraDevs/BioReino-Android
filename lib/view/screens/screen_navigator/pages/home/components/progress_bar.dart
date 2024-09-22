part of home_page;

class ProgressBar extends StatelessWidget {
  const ProgressBar(this._percent, {super.key});

  final double _percent;
  double get percent {
    if (_percent == 0) {
      return 0;
    } else if (_percent < 10) {
      return 10;
    } else {
      return _percent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              Container(
                width: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: fromBrightnessColor(
                      context, Colors.black12, Colors.white12),
                ),
              ),
              Container(
                width: (210 * percent) / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      BRColors.greenDark,
                      BRColors.greenLight,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "${_percent.toStringAsFixed(0)}%",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 0.001,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
