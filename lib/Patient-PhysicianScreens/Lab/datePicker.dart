import 'package:flutter/material.dart';
import 'package:medcore/Utiils/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../Utiils/common_widgets.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePicker();
}

class _DatePicker extends State<DatePicker> {
  //String _range;

  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // / The argument value will return the changed date as [DateTime] when the
    // / widget [SfDateRangeSelectionMode] set as single.
    // /
    // / The argument value will return the changed dates as [List<DateTime>]
    // / when the widget [SfDateRangeSelectionMode] set as multiple.
    // /
    // / The argument value will return the changed range as [PickerDateRange]
    // / when the widget [SfDateRangeSelectionMode] set as range.
    // /
    // / The argument value will return the changed ranges as
    // / [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    // / multi range.
    setState(() {
      // if (args.value is PickerDateRange) {
      //   _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
      //       // ignore: lines_longer_than_80_chars
      //       ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      // } else {
      _rangeCount = args.value.length.toString();
      //   }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        height: 380,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              //  height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text('Selected range: $_range'),
                  Text(
                    'Selected ranges count: $_rangeCount',
                    style: const TextStyle(
                        color: ColorResources.grey777, fontSize: 14),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 10,
              right: 0,
              bottom: 20,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.multiRange,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
                maxDate: DateTime.now(),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: Row(
                children: [
                  Button(() {
                    Navigator.pop(context);
                  }, "Cancel", ColorResources.orange.withOpacity(0.9),
                      ColorResources.white),
                  const SizedBox(
                    width: 10,
                  ),
                  Button(() {
                    Navigator.pop(context);
                  }, "Save", ColorResources.orange.withOpacity(0.9),
                      ColorResources.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
