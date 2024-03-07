import 'package:flutter/material.dart';
import 'package:touresco/providers/view_models/transferred_trips_view_model.dart';
import 'package:touresco/utils/constants.dart';

class TransferredTripsFilter extends StatefulWidget {
    TransferredTripsFilter(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.vm})
      : super(key: key);

  final String value;
  final List<DropdownMenuItemASD> items;
  final Function(String?) onChanged;
  final TransferredTripsViewModel vm;

  @override
  State<TransferredTripsFilter> createState() => _TransferredTripsFilterState();
}

class _TransferredTripsFilterState extends State<TransferredTripsFilter> {
  var currentIndex = 0 ;

  @override
  Widget build(BuildContext context) {

     return Wrap(

      children: [
        for(var i = 0 ; i<widget.items.length;i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
            child: InkWell(
              onTap: (){
                widget.onChanged(widget.items[i].value);
                setState(() {
                  currentIndex=i;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color:currentIndex == i ? kPrimaryColor:Colors.transparent,
                        width: 1
                    )
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                child:Text(
                  widget.items[i].child,
                  style: TextStyle(
                      color: currentIndex == i ? kPrimaryColor : Colors.black,
                      fontWeight: currentIndex == i ?FontWeight.w500:FontWeight.normal,
                      fontSize: 15,
                  ),

                ),
              ),
            ),
          ),


      ],
    );
  }
}