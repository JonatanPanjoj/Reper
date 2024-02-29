import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:reper/config/theme/app_font_styles.dart';
import 'package:reper/config/utils/utils.dart';
import 'package:reper/domain/entities/entities.dart';
import 'package:reper/presentation/providers/database/repositories/repertory_repository_provider.dart';

class AddRepertoryEventScreen extends ConsumerStatefulWidget {
  final Repertory repertory;

  const AddRepertoryEventScreen({super.key, required this.repertory});

  @override
  AddRepertoryEventScreenState createState() => AddRepertoryEventScreenState();
}

class AddRepertoryEventScreenState
    extends ConsumerState<AddRepertoryEventScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? currentDate;
  TimeOfDay? currentTime;
  String? selectedTime;
  String? selectedDate;
  bool timeChanged = false;

  @override
  void initState() {
    if (widget.repertory.event != null) {
      selectedDate = formatDate(widget.repertory.event!);
      selectedTime = formatTimeFromTimeStamp(widget.repertory.event!);
      currentTime = TimeOfDay(
        hour: widget.repertory.event!.toDate().hour,
        minute: widget.repertory.event!.toDate().minute,
      );
      currentDate = widget.repertory.event!.toDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evento'),
        shadowColor: Colors.transparent,
        actions: [
          (currentDate != null && currentTime != null && timeChanged)
              ? TextButton(
                  onPressed: () async {
                    final DateTime combinedDate = DateTime(
                      currentDate!.year,
                      currentDate!.month,
                      currentDate!.day,
                      currentTime!.hour,
                      currentTime!.minute,
                    );
                    if (currentDate != null) {
                      await ref
                          .read(repertoryRepositoryProvider)
                          .updateRepertory(
                            repertory: widget.repertory.copyWith(
                              event: Timestamp.fromDate(combinedDate),
                            ),
                          );
                    }
                    // ignore: use_build_context_synchronously
                    context.pop();
                  },
                  child: const Text('Guardar'))
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 20,
                      decoration: BoxDecoration(
                          color: colors.colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(width: 25),
                    Text(
                      (selectedDate != null && selectedTime != null)
                          ? '$selectedDate, $selectedTime'
                          : 'Aún no tienes un evento registrado',
                      style: bold14,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SpinKitPumpingHeart (
                duration: const Duration(seconds: 5),
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/img/rippy-logo.png',
                    width: size.width * 0.35,
                    height: size.width * 0.35,
                  );
                }
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '¿Cuándo usaras tu repertorio?',
                  style: bold20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Selecciona una fecha y hora',
                  textAlign: TextAlign.center,
                  style: normal14.copyWith(color: colors.dividerColor),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                icon: const Icon(Icons.history_toggle_off_sharp),
                label: Text(selectedTime ?? 'Selecciona una hora'),
                onPressed: () async {
                  currentTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (currentTime != null) {
                    timeChanged = true;

                    selectedTime = formatTimeFromTimeOfDay(currentTime!);
                    setState(() {});
                  }
                },
              ),
              CalendarDatePicker(
                initialDate: widget.repertory.event?.toDate(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2200),
                currentDate: currentDate,
                onDateChanged: (date) {
                  currentDate = date;
                  if (currentDate != null) {
                    timeChanged = true;
                    selectedDate = formatDate(Timestamp.fromDate(currentDate!));
                    setState(() {});
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '* Te llegará una notificación un día antes de la fecha del uso del repertorio',
                  textAlign: TextAlign.start,
                  style: normal12.copyWith(color: colors.dividerColor),
                ),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
