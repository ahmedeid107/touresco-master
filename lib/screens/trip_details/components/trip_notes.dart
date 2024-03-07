import 'package:flutter/material.dart';
import 'package:touresco/components/exbandable_item_default.dart';
import 'package:touresco/providers/view_models/trip_details_view_model.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripNotes extends StatefulWidget {
    TripNotes({Key? key, required this.vm ,required this.isType}) : super(key: key);
  final TripDetailsViewModel vm;
bool ? isType;
  @override
  State<TripNotes> createState() => _TripNotesState();
}

class _TripNotesState extends State<TripNotes> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1), () {
      if (widget.isType==true) {
        widget.vm.isExpandableNotes = true;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return ExpandableItemDefault(
        mainTitle: lang!.notes,
        isCurrentExpand: widget.vm.isExpandableNotes,
        expandableWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: ServiceCollector.getInstance().currentLanguage == 'en'
                ? Alignment.topLeft
                : Alignment.topRight,
            child: Text(widget.vm.trip.tripNotes),
          ),
        ),
        reverseExpandableList: () {
          widget.vm.isExpandableNotes = !widget.vm.isExpandableNotes;
        });
  }
}
