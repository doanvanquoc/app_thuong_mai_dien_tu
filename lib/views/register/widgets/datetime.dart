import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeBirthDay extends StatefulWidget {
  const DateTimeBirthDay(
      {Key? key, required this.controller, required this.datetime})
      : super(key: key);
  final String datetime;
  final TextEditingController controller;

  @override
  State<DateTimeBirthDay> createState() => _DateTimeBirthDayState();
}

class _DateTimeBirthDayState extends State<DateTimeBirthDay> {
  bool isIconPressed = false;
  late FocusNode _focusNode;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isIconPressed = _focusNode.hasFocus;
      });
    });

    // Parse the initial date and set the selected date with a default if parsing fails
    if (widget.datetime != 'Ngày sinh') {
      try {
        DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(widget.datetime);
        _selectedDate = _validateDate(parsedDate);
      } catch (e) {
        print('Parsing initial date error: $e');
        _selectedDate = _validateDate(DateTime.now());
      }
    } else {
      _selectedDate = _validateDate(DateTime.now());
    }
  }

  DateTime _validateDate(DateTime date) {
    // Ensure the date is within the specified range
    if (date.isBefore(DateTime(1900, 1, 1))) {
      return DateTime(1900, 1, 1);
    } else if (date.isAfter(DateTime(2023, 12, 31))) {
      return DateTime(2023, 12, 31);
    } else {
      return date;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _chonNgay(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime: _selectedDate,
            minimumYear: 1900,
            maximumYear: 2023,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              final ngayDaDinhDang = DateFormat('dd/MM/yyyy').format(newDate);
              setState(() {
                widget.controller.text = ngayDaDinhDang;
                _selectedDate = newDate;
              });
            },
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != currentDate) {
      // Handle the selected date here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 45, top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          width: 2,
          color: Colors.grey[200]!,
        ),
        color: Colors.grey[200]!,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.controller.text.isNotEmpty
                  ? widget.controller.text
                  : widget.datetime,
              style: TextStyle(
                color: widget.controller.text.isNotEmpty
                    ? Colors.black
                    : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _chonNgay(context);
            },
            icon: Icon(
              Icons.date_range_outlined,
              color: isIconPressed ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
