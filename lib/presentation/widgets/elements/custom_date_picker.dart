import 'package:flutter/material.dart';
import 'package:reper/presentation/widgets/elements/custom_input.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final DateTime? date;
  final bool? showTitle;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final ValueChanged<DateTime> onDateChanged;

  const CustomDatePicker({
    super.key,
    required this.label,
    this.date,
    this.showTitle,
    this.validator,
    required this.onDateChanged,
    this.fillColor,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _buildDatePicker(context),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return SizedBox(
      height: 83,
      width: double.infinity,
      child: Stack(
        children: [
          CustomInput(
            initialValue: _formatDate(),
            validator: widget.validator,
            fillColor: widget.fillColor,
          ),
          GestureDetector(
            onTap: () async {
              final DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2100));
              if (newDate != null) {
                setState(() {
                  selectedDate = newDate;
                });
                widget.onDateChanged(newDate);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return widget.showTitle == false || widget.showTitle == null
        ? const SizedBox()
        : Column(
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
  }

  String _formatDate() {
    if (selectedDate == null) {
      return 'Fecha';
    } else {
      return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    }
  }
}
