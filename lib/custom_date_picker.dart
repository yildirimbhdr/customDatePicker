import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onSelected;
  final DateTime? initialTime;
  final DateTime firstTime;
  final List<String>? months;
  final CustomDatePickerThemeData? theme;
  final double? radius;

  const CustomDatePicker(
      {Key? key,
      required this.onSelected,
      this.initialTime,
      required this.firstTime,
      this.months,
      this.theme,
      this.radius})
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedTime = DateTime.now();
  DateTime _startDateTime = DateTime.now();
  List<DateTime> _dates = [];
  Map<int, String> month = {};
  double radius = 5;

  @override
  void initState() {
    super.initState();
    _setMonth();
    if (widget.initialTime != null) {
      _selectedTime = widget.initialTime!;
      _startDateTime = widget.initialTime!;
    }
    _dates = getDaysInBeteween(
      _selectedTime,
      _selectedTime.add(
        const Duration(days: 5),
      ),
    );
    if (widget.radius != null) radius = widget.radius!;
  }

  _setMonth() {
    if (widget.months == null) {
      month = {
        1: "OCA",
        2: "ŞUB",
        3: "MAR",
        4: "NIS",
        5: "MAY",
        6: "HAZ",
        7: "TEM",
        8: "AGU",
        9: "EYL",
        10: "EKM",
        11: "KAS",
        12: "ARA"
      };
    } else {
      for (int i = 1; i < (widget.months?.length ?? 0); i++) {
        month[i] = widget.months?[i] ?? "";
      }
    }
  }

  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dates,
        const SizedBox(
          width: 10,
        ),
        button,
      ],
    );
  }

  _dateButton(DateTime e) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _selectedTime == e
                ? widget.theme?.selectedItemBackground ??
                    Theme.of(context).primaryColor
                : widget.theme?.unSelectedItemBackground ??
                    Theme.of(context).primaryColorLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(e.day.toString(),
                  style: _selectedTime == e
                      ? widget.theme?.selectedItemTextStyle
                      : widget.theme?.unSelectedItemTextStyle),
              Text(month[e.month] ?? "",
                  style: _selectedTime == e
                      ? widget.theme?.selectedItemTextStyle
                      : widget.theme?.unSelectedItemTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget get dates => Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: widget.theme?.backgroundColor ??
                Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          constraints: const BoxConstraints(
            minWidth: 225,
            minHeight: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.from(
              _dates
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        _selectedTime = e;
                        widget.onSelected(_selectedTime);
                        setState(() {});
                      },
                      child: _dateButton(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

  Widget get button => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.theme?.buttonBackgroundColor ??
              Theme.of(context).dialogBackgroundColor,
        ),
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () async {
            DateTime? time = await showDatePicker(
              context: context,
              initialDate: _startDateTime,
              useRootNavigator: true,
              firstDate: widget.firstTime,
              lastDate: DateTime(2035),
            );
            if (time != null) {
              _startDateTime = time;
              _selectedTime = _startDateTime;
              DateTime _time = _startDateTime.add(const Duration(days: 5));
              _dates = getDaysInBeteween(_startDateTime, _time);
            }
            widget.onSelected(_selectedTime);

            setState(() {});
          },
          child: Icon(
            Icons.date_range,
            color: widget.theme?.buttonItemColor ??
                Theme.of(context).primaryColorLight,
          ),
        ),
      );
}

class CustomDatePickerThemeData {
  final Color? selectedItemBackground;
  final Color? unSelectedItemBackground;
  final TextStyle? selectedItemTextStyle;
  final TextStyle? unSelectedItemTextStyle;
  final Color? backgroundColor;
  final Color? buttonBackgroundColor;
  final Color? buttonItemColor;
  CustomDatePickerThemeData(
      {this.selectedItemBackground,
      this.selectedItemTextStyle,
      this.unSelectedItemBackground,
      this.unSelectedItemTextStyle,
      this.backgroundColor,
      this.buttonBackgroundColor,
      this.buttonItemColor});
}
