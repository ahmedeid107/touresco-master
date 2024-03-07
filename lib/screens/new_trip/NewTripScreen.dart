// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/countryId.dart';
import 'package:touresco/screens/dashbord/dashbord.dart';
import 'package:touresco/screens/main_nav/main_nav.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import '../../models/car_type_model.dart';
import '../../models/location_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transfer_provider.dart';
import '../../providers/view_models/take_role_view_model.dart';
import '../../services/service_collector.dart';
import '../../utils/theme.dart';
import 'componant/text_form_field_widget.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({
    Key? key,
  }) : super(key: key);

  // final TripDetailsModel model;

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  int _currentstep = 0;

  // var dropdownvalueTime = '30 m';
  // var itemsTime = [
  //   '30 m',
  //   '35 m',
  // ];
  List<CarSizeModel> carSizes = [];
  final TextEditingController itinerariesController = TextEditingController();
  final TextEditingController documentNumber = TextEditingController();
  var selectedUserId = "";
  List<DistrictModel> districts = [];

  //first type
  var requestType = "-1";
  var tripType = "-1";
  var carType = "1";
  var carSize = "";
  var city = "";
  var region = "";
  var flightNumberController = TextEditingController();
  var noteController = TextEditingController();
  var commisuoneController = TextEditingController();
  var phoneController = TextEditingController();
  var touristNameController = TextEditingController();
  var nationalityController = TextEditingController();
  var princController = TextEditingController();
  var dataTravleController = TextEditingController();
  var searchDriver = TextEditingController();
  var ismAlSha5isa = TextEditingController();

  List<CarTypeModel> _carModels = [];

  List<CarTypeModel> get carModels => [..._carModels];
  List<Country> country = [];

  bool isTheFlightTransferable = true;
  bool expensesPriceDetails = false;
  var listItemControllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];

  List<CityModel> cities = [];

  var passListItemControllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];
  var listExpItemControllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];

  @override
  void initState() {
    // TODO: implement initState
    ServiceCollector.getInstance()
        .metaDataService
        .getAllCarType()
        .then((value) {
      setState(() {
        _carModels = value;
      });
    });

    ServiceCollector.getInstance().metaDataService.getCities().then((value) {
      setState(() {
        cities = value;
        city = cities[0].id;
      });
    });
    // s+
    ServiceCollector.getInstance().metaDataService.getCountryes().then((value) {
      print("AAAAAAAAAAA221AAA ${value}");
      setState(() {
        country.addAll(value);
      });
    });

    ServiceCollector.getInstance().authService.getAllSize("1").then((value) {
      setState(() {
        carSizes = value;
        if (value.isNotEmpty) {
          carSize = value[value.length - 1].id;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return ChangeNotifierProvider.value(
      value: TransferProvider(),
      child: Consumer<TransferProvider>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F8F8),
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  String userId =
                      Provider.of<AuthProvider>(context, listen: false).user.id;

                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .syncNotificationProfileNew(userId);
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              leadingWidth: 40,
              title: Text(
                lang.createTrip,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
            body: Theme(
              data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Colors.blue,
                      background: Colors.red,
                      secondary: Colors.green,
                    ),
              ),
              child: Stepper(
                steps: [
                  Step(
                    title: Text(lang.basicInformation),
                    state: StepState.indexed,
                    isActive: _currentstep == 0 ||
                        _currentstep == 1 ||
                        _currentstep == 2,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.requestType,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: ScreenConfig.getRuntimeHeightByRatio(4),
                        ),
                        Container(
                          height: ScreenConfig.getRuntimeHeightByRatio(50),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton(
                            underline: Container(),
                            value: requestType,
                            dropdownColor: Colors.white,
                            icon: const Expanded(
                              child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(Icons.arrow_drop_down)),
                            ),
                            items: vm.requestTypes,
                            onChanged: (newValue) {
                              setState(() {
                                requestType = newValue.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: ScreenConfig.getRuntimeHeightByRatio(16),
                        ),
                        Text(
                          lang.tripType,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: ScreenConfig.getRuntimeHeightByRatio(4),
                        ),
                        Container(
                          height: ScreenConfig.getRuntimeHeightByRatio(50),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton(
                            underline: Container(),
                            value: tripType,
                            dropdownColor: Colors.white,
                            icon: const Expanded(
                              child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(Icons.arrow_drop_down)),
                            ),
                            items: vm.menuItems,
                            onChanged: (newValue) {
                              setState(() {
                                tripType = newValue.toString();
                              });
                            },
                          ),
                        ),
                        requestType != "2"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        requestType != "2"
                            ? Text(
                                lang.vehicleCapacity3,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        requestType != "2"
                            ? SizedBox(
                                height: ScreenConfig.getRuntimeHeightByRatio(4),
                              )
                            : Container(),
                        requestType != "2"
                            ? Container(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(50),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: DropdownButton(
                                    underline: Container(),
                                    isExpanded: true,
                                    value: carType,
                                    dropdownColor: Colors.white,
                                    items: carModels
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id,
                                        child: Text(e.carType),
                                      );
                                    }).toList(),
                                    onChanged: (v) async {
                                      setState(() {
                                        carType = v.toString();
                                        carSize = "";
                                      });
                                      vm.getAllCarSizes(v.toString()).then(
                                        (value) {
                                          carSizes = value;
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              carSize =
                                                  value[value.length - 1].id;
                                            });
                                          }
                                        },
                                      );
                                    }),
                              )
                            : Container(),
                        //---
                        requestType != "2"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        requestType != "2"
                            ? Text(
                                lang.carSize,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        requestType != "2"
                            ? SizedBox(
                                height: ScreenConfig.getRuntimeHeightByRatio(4),
                              )
                            : Container(),
                        requestType != "2"
                            ? Container(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(50),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: carSizes.isNotEmpty
                                    ? DropdownButton(
                                        underline: Container(),
                                        isExpanded: true,
                                        value: carSize != ""
                                            ? carSize
                                            : carSizes[0].id,
                                            dropdownColor: Colors.white,
                                        items: carSizes
                                            .map<DropdownMenuItem<String>>(
                                                (e) => DropdownMenuItem<String>(
                                                      value: e.id,
                                                      child: Text(
                                                        e.carSeat,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ))
                                            .toList(),
                                        onChanged: (value) {
                                          carSize = value.toString();
                                          // vm.setCarSize = value;
                                        })
                                    : Container(),
                              )
                            : Container(),
                        SizedBox(
                            height: ScreenConfig.getRuntimeHeightByRatio(10)),
                        tripType == "0"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        tripType == "0"
                            ? Text(
                                lang.flightNumber,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        tripType == "0"
                            ? const SizedBox(
                                height: 4,
                              )
                            : Container(),
                        tripType == "0"
                            ? TextFormFieldWidget(
                                hint: "",
                                type: TextInputType.text,
                                controller: flightNumberController,
                              )
                            : Container(),

                        //
                        tripType == "0"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        tripType == "0"
                            ? Text(
                                lang.ismAlSha5isa,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        tripType == "0"
                            ? const SizedBox(
                                height: 4,
                              )
                            : Container(),
                        tripType == "0"
                            ? TextFormFieldWidget(
                                hint: "",
                                type: TextInputType.text,
                                controller: ismAlSha5isa,
                              )
                            : Container(),
                        //8888
                        requestType == "1"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        requestType == "1"
                            ? Text(
                                lang.city,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        requestType == "1"
                            ? const SizedBox(
                                height: 4,
                              )
                            : Container(),
                        cities.isNotEmpty
                            ? requestType == "1"
                                ? _buildDropListCities(vm, lang)
                                : Container()
                            : Container(),
                        //-8-

                        requestType == "1"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        districts.isNotEmpty
                            ? requestType == "1"
                                ? Text(
                                    lang.region,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container()
                            : Container(),
                        districts.isNotEmpty
                            ? requestType == "1"
                                ? const SizedBox(
                                    height: 4,
                                  )
                                : Container()
                            : Container(),
                        //****
                        districts.isNotEmpty
                            ? requestType == "1"
                                ? _buildDropListDistrict(vm, lang)
                                : Container()
                            : Container(),

                        //-8-
                        requestType == "2"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        requestType == "2"
                            ? Text(
                                lang.searchWayes,
                                style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        requestType == "2"
                            ? SizedBox(
                                height:
                                    ScreenConfig.getRuntimeHeightByRatio(16),
                              )
                            : Container(),
                        requestType == "2"
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length % 2 != 0) {
                                      vm.searchForDrivers(value);
                                    }
                                  },
                                  controller: searchDriver,
                                  keyboardType: TextInputType.text,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    counter: Container(),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: kPrimaryColor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return lang.thisFieldIsRequired;
                                    }
                                    return null;
                                  },
                                ),
                              )
                            : Container(),
                        requestType == "2"
                            ? vm.searchResults.isEmpty
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : SizedBox(
                                    height: 160,
                                    child: ListView.builder(
                                      itemCount: vm.searchResults.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedUserId =
                                                  vm.searchResults[index].id;
                                              searchDriver.text =
                                                  vm.searchResults[index].name;
                                              vm.searchResults.clear();
                                            });
                                          },
                                          child: ListTile(
                                            leading: const CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                  'assets/images/img_user.png'),
                                            ),
                                            title: Text(
                                              vm.searchResults[index].name,
                                              style: textTitle(
                                                  kTitleBlackTextColor),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                            : Container(),
                      ],
                    ),
                  ),
                  Step(
                      title: Text(lang.tracks),
                      state: StepState.indexed,
                      content: SingleChildScrollView(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemBuilder: (context, index) {
                            return buildStep2(
                              context: context,
                              index: index,
                              textEditingControllerTravel:
                                  listItemControllers[index][0],
                              textEditingControllerTime:
                                  listItemControllers[index][1],
                              textEditingControllerDate:
                                  listItemControllers[index][2],
                              textEditingControllerresidence:
                                  listItemControllers[index][3],
                              textEndPoint: listItemControllers[index][4],
                            );
                          },
                          itemCount: listItemControllers.length,
                        ),
                      ),
                      isActive: _currentstep == 1 || _currentstep == 2),
                  Step(
                    title: Text(lang.tripPassengers),
                    state: StepState.indexed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.phonenum,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormFieldWidget(
                          hint: "*****0566",
                          type: TextInputType.text,
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        SingleChildScrollView(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemBuilder: (context, index) {
                              return buildStep3Pass(
                                context: context,
                                index: index,
                                textEditingControllerName:
                                    passListItemControllers[index][0],
                                textEditingControllerNumber:
                                    passListItemControllers[index][1],
                                textEditingControllerNatonality:
                                    passListItemControllers[index][2],
                              );
                            },
                            itemCount: passListItemControllers.length,
                          ),
                        ),
                        // Text(
                        //   lang.touristName,
                        //   style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   height: 4,
                        // ),
                        // TextFormFieldWidget(
                        //   hint: "",
                        //   type: TextInputType.name,
                        //   controller: touristNameController,
                        // ),
                        // Text("طباعه اسم الزائر"),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   lang.touristNationality,
                        //   style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   height: 4,
                        // ),
                        // TextFormFieldWidget(
                        //   hint: "",
                        //   type: TextInputType.name,
                        //   controller: nationalityController,
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                      ],
                    ),
                    isActive: _currentstep == 2,
                  ),
                  step4(lang)
                ],
                type: StepperType.vertical,
                currentStep: _currentstep,
                onStepTapped: (step) {
                  if (_currentstep > step) {
                    setState(() {
                      _currentstep = step;
                    });
                  }
                  if (step == 1) {
                    //اذا كان رحلة محددة
                    if (requestType == "2") {
                      //اذا كان مش مختار سايق
                      if (selectedUserId == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(lang.fillData)));
                      } else {
                        setState(() {
                          _currentstep = step;
                        });
                      }
                    }
                    if (requestType == "1" || requestType == "0") {
                      if (tripType == "0") {
                        if (flightNumberController.text.isEmpty ||
                            ismAlSha5isa.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(lang.fillData)));
                        } else {
                          setState(() {
                            _currentstep = step;
                          });
                        }
                      } else {
                        setState(() {
                          _currentstep++;
                        });
                      }
                    }
                  } else if (step == 2) {
                    if (listItemControllers[listItemControllers.length - 1]
                                [0]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1]
                                [1]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1][2]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1][4]
                            .text
                            .isNotEmpty) {
                      setState(() {
                        _currentstep = step;
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(lang.fillData)));
                    }
                  } else if (step == 3) {
                    if (
                        passListItemControllers[
                                passListItemControllers.length - 1][0]
                            .text
                            .isNotEmpty) {
                      setState(() {
                        _currentstep = step;
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(lang.fillData)));
                    }
                  }
                },
                onStepCancel: () {
                  // Navigator.pop(context);
                },
                physics: const BouncingScrollPhysics(),
                onStepContinue: () {
                  if (_currentstep == 0) {
                    if (requestType == "2") {
                      if (selectedUserId == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(lang.fillData)));
                      } else {
                        setState(() {
                          _currentstep++;
                        });
                      }
                    }
                    if (requestType == "1" || requestType == "0") {
                      if (tripType.toString() == "0") {
                        if (flightNumberController.text.isEmpty ||
                            ismAlSha5isa.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(lang.fillData)));
                        } else {
                          setState(() {
                            _currentstep++;
                          });
                        }
                      } else {
                        setState(() {
                          _currentstep++;
                        });
                      }
                    }
                  } else if (_currentstep == 1) {
                    if (listItemControllers[listItemControllers.length - 1]
                                [0]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1]
                                [1]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1][2]
                            .text
                            .isNotEmpty &&
                        listItemControllers[listItemControllers.length - 1][4]
                            .text
                            .isNotEmpty) {
                      setState(() {
                        _currentstep++;
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(lang.fillData)));
                    }
                  } else if (_currentstep == 2) {
                    if (
                        passListItemControllers[
                                passListItemControllers.length - 1][0]
                            .text
                            .isNotEmpty) {
                      setState(() {
                        _currentstep++;
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(lang.fillData)));
                    }
                  } else if (_currentstep == 3) {
                    if (princController.text != "" &&
                        dataTravleController.text != "") {
                      if (expensesPriceDetails) {
                        if (listExpItemControllers.last[0].text.isNotEmpty &&
                            listExpItemControllers.last[1].text.isNotEmpty &&
                            listExpItemControllers.last[2].text.isNotEmpty) {
                          var list = [];
                          var preslist = [];
                          listItemControllers.forEach((element) {
                            list.add({
                              "place": element[0].text,
                              "latlong": element[3].text,
                              "time": element[1].text,
                              "date": element[2].text,
                            });
                          });
                          passListItemControllers.forEach((element) {
                            preslist.add({
                              "name": element[0].text,
                              "docNumber": element[1].text,
                              "nationality": element[2].text,
                            });
                            print(
                                "SSSSSSSSSSSSSSSSSSSSSSSS ${element[2].text}");
                          });

                          List<Map<String, dynamic>> outlaies = [];
                          listExpItemControllers.forEach((element) {
                            outlaies.add({
                              "Outlay_Name": element[0].text,
                              "Outlay_Amount": element[1].text,
                              "Outlay_Type": element[2].text,
                            });
                          });

                          vm
                              .sendTripData(
                                  tripType: tripType,
                                  trip_direction: "1",
                                  isTheFlightTransferable:
                                      isTheFlightTransferable,
                                  touristName: touristNameController.text,
                                  requestType: requestType,
                                  passngerpassport: "123",
                                  note: noteController.text,
                                  expensesPriceDetails: expensesPriceDetails,
                                  nationality: "1",
                                  price: princController.text,
                                  timeTravle: "",
                                  ismSha5sa: ismAlSha5isa.text,
                                  dateTravle: dataTravleController.text,
                                  phoneToCommunity: phoneController.text,
                                  city: city,
                                  press: preslist,
                                  district: region,
                                  driverID: selectedUserId,
                                  ways: list,
                                  flightNumber: flightNumberController.text,
                                  carSize: carSize,
                                  carType: carType,
                                  outlaies: outlaies,
                                  user_id: Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .user
                                      .id)
                              .then((value) {
                            if (value == true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainNav(
                                          index: 1,
                                        )),
                              );
                            } else {
                              String laang = ServiceCollector.getInstance()
                                  .currentLanguage;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(laang == 'en'
                                    ? 'An error occur please try again later'
                                    : 'حدث خطأ ما يرجى المحاولة في وقت اخر'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(lang.fillData)));
                        }
                      } else {
                        var list = [];
                        var preslist = [];

                        listItemControllers.forEach((element) {
                          list.add({
                            "place": element[0].text,
                            "endPoint": element[4].text,
                            "latlong": element[3].text,
                            "time": element[1].text,
                            "date": element[2].text,
                          });
                          print("##${element[2].text}");
                        });
                        passListItemControllers.forEach((element) {
                          preslist.add({
                            "name": element[0].text,
                            "docNumber": element[1].text,
                            "nationality": element[2].text,
                          });
                        });

                        List<Map<String, dynamic>> outlaies = [];
                        listExpItemControllers.forEach((element) {
                          outlaies.add({
                            "Outlay_Name": element[0].text,
                            "Outlay_Amount": element[1].text,
                            "Outlay_Type": element[2].text,
                          });
                        });
                        vm
                            .sendTripData(
                                tripType: tripType,
                                trip_direction: "1",
                                isTheFlightTransferable:
                                    isTheFlightTransferable,
                                touristName: touristNameController.text,
                                requestType: requestType,
                                passngerpassport: "123",
                                note: noteController.text,
                                expensesPriceDetails: expensesPriceDetails,
                                nationality: "1",
                                price: princController.text,
                                timeTravle: "",
                                ismSha5sa: ismAlSha5isa.text,
                                dateTravle: dataTravleController.text,
                                phoneToCommunity: phoneController.text,
                                city: city,
                                press: preslist,
                                district: region,
                                driverID: selectedUserId,
                                ways: list,
                                flightNumber: flightNumberController.text,
                                carSize: carSize,
                                carType: carType,
                                outlaies: outlaies,
                                user_id: Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .user
                                    .id)
                            .then((value) {
                          print("AASS DD ${value}");
                          if (value == true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashbord()));
                          } else {
                            String laang =
                                ServiceCollector.getInstance().currentLanguage;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(laang == 'en'
                                  ? 'An error occur please try again later'
                                  : 'حدث خطأ ما يرجى المحاولة في وقت اخر'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      }

                      // send trip to api
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(lang.fillData)));
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStep2({
    required BuildContext context,
    required int index,
    required TextEditingController textEditingControllerTravel,
    required TextEditingController textEditingControllerTime,
    required TextEditingController textEditingControllerDate,
    required TextEditingController textEditingControllerresidence,
    required TextEditingController textEndPoint,
  }) {
    var lang = AppLocalizations.of(context)!;
    return Consumer<TransferProvider>(
      builder: (context, vm, child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenConfig.getRuntimeHeightByRatio(16),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.itineraries,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: textEditingControllerTravel,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: lang.example1,
                              ),
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return lang.thisFieldIsRequired;
                                }
                                return null;
                              },
                            ))
                      ],
                    )),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenConfig.getRuntimeHeightByRatio(8),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.endTrack,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: textEndPoint,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: lang.example1,
                              ),
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return lang.thisFieldIsRequired;
                                }
                                return null;
                              },
                            ))
                      ],
                    )),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),

                // Row(
                //   children: [
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             lang.residence,
                //             style: const TextStyle(
                //               fontSize: 15,
                //               color: Colors.white,
                //             ),
                //           ),
                //           InkWell(
                //             onTap: () async {
                //               var latString = await Navigator.push(context,
                //                   MaterialPageRoute(builder: (context) {
                //                 return MapSample(
                //                   latLang: textEditingControllerresidence.text,
                //                 );
                //               }));
                //               setState(() {
                //                 textEditingControllerresidence.text =
                //                     latString ?? "";
                //               });
                //             },
                //             child: Container(
                //                 height: 45,
                //                 decoration: BoxDecoration(
                //                     color: Colors.white,
                //                     borderRadius: BorderRadius.circular(5)),
                //                 child: TextFormField(
                //                   keyboardType: TextInputType.text,
                //                   enabled: false,
                //                   decoration: InputDecoration(
                //                       border: InputBorder.none,
                //                       prefixIcon: const Icon(
                //                         Icons.location_on_outlined,
                //                       ),
                //                       hintText:
                //                           textEditingControllerresidence.text ==
                //                                   ""
                //                               ? lang.example2
                //                               : lang.palceChoose,
                //                       hintStyle: const TextStyle(fontSize: 15)),
                //                   validator: (value) {
                //                     if (value?.isEmpty == true) {
                //                       return lang.thisFieldIsRequired;
                //                     }
                //                     return null;
                //                   },
                //                 )),
                //           )
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.departureTime,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () async {
                                var selectedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );
                                textEditingControllerTime.text =
                                    selectedTime != null
                                        ? selectedTime.format(context)
                                        : "";
                              },
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: textEditingControllerTime,
                                    keyboardType: TextInputType.text,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "",
                                        prefixIcon:
                                            Icon(Icons.access_time_outlined)),
                                    validator: (value) {
                                      if (value?.isEmpty == true) {
                                        return lang.thisFieldIsRequired;
                                      }
                                      return null;
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.tripStartDate,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () async {
                                DateTime selectedDate = DateTime.now();
                                var firstDate = index > 0
                                    ? listItemControllers[index - 1][2].text ==
                                            ""
                                        ? DateTime.now()
                                        : DateTime(
                                            int.parse(
                                              listItemControllers[index - 1][2]
                                                  .text
                                                  .toString()
                                                  .split("/")[2],
                                            ),
                                            int.parse(
                                              listItemControllers[index - 1][2]
                                                  .text
                                                  .toString()
                                                  .split("/")[1],
                                            ),
                                            int.parse(
                                                listItemControllers[index - 1]
                                                        [2]
                                                    .text
                                                    .toString()
                                                    .split("/")[0]))
                                    : DateTime.now();
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        selectedDate.day >= firstDate.day
                                            ? selectedDate
                                            : firstDate,
                                    firstDate: firstDate,
                                    lastDate: DateTime(2026, 05));
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                    textEditingControllerDate.text =
                                        DateFormat("dd/MM/yyyy").format(picked);
                                  });
                                }
                              },
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: textEditingControllerDate,
                                    keyboardType: TextInputType.text,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "",
                                        prefixIcon: Icon(
                                            Icons.calendar_month_outlined)),
                                    validator: (value) {
                                      if (value?.isEmpty == true) {
                                        return lang.thisFieldIsRequired;
                                      }
                                      return null;
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              listItemControllers.length - 1 == index
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print(
                                "ASDASDSAD ${listItemControllers[listItemControllers.length - 1][0].text.isNotEmpty}");
                            if (listItemControllers[
                                        listItemControllers.length - 1][0]
                                    .text
                                    .isNotEmpty &&
                                listItemControllers[
                                        listItemControllers.length - 1][1]
                                    .text
                                    .isNotEmpty &&
                                listItemControllers[
                                        listItemControllers.length - 1][2]
                                    .text
                                    .isNotEmpty) {
                              setState(() {
                                add();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(lang.fillData)));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 1,
                                )),
                            child: Row(
                              children: [
                                Text(
                                  lang.addANewPath,
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.add_rounded,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        index != 0
                            ? Container(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      delete();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1,
                                        )),
                                    child: Row(
                                      children: [
                                        Text(
                                          lang.delete,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  : Container()
            ],
          ),
        ]);
      },
    );
  }

  Widget buildStep3Pass({
    required BuildContext context,
    required int index,
    required TextEditingController textEditingControllerName,
    required TextEditingController textEditingControllerNumber,
    required TextEditingController textEditingControllerNatonality,
  }) {
    var lang = AppLocalizations.of(context)!;
    return Consumer<TransferProvider>(
      builder: (context, vm, child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenConfig.getRuntimeHeightByRatio(16),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.touristName,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              controller: textEditingControllerName,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "",
                              ),
                              validator: (value) {
                                if (value?.isEmpty == true) {
                                  return lang.thisFieldIsRequired;
                                }
                                return null;
                              },
                            ))
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.documentNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: textEditingControllerNumber,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "",
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return lang.thisFieldIsRequired;
                            }
                            return null;
                          },
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.touristNationality,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          underline: Container(),
                          value: textEditingControllerNatonality.text == ""
                              ? "1"
                              : textEditingControllerNatonality.text,
                          icon: Icon(Icons.arrow_drop_down),
                          items: country
                              .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem<String>(
                                        value: e.country_ID,
                                        child: Text(
                                          ServiceCollector.getInstance()
                                                      .currentLanguage ==
                                                  'en'
                                              ? e.English_Nationality
                                              : e.Arabic_Nationality,
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              textEditingControllerNatonality.text =
                                  newValue.toString();
                            });
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              passListItemControllers.length - 1 == index
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (passListItemControllers[
                                    passListItemControllers.length - 1][0]
                                .text
                                .isNotEmpty) {
                              setState(() {
                                addPass();
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(lang.fillData)));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 1,
                                )),
                            child: Row(
                              children: [
                                Text(
                                  lang.addNewPassinger,
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.add_rounded,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        index != 0
                            ? Container(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      deletePass();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1,
                                        )),
                                    child: Row(
                                      children: [
                                        Text(
                                          lang.delete,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  : Container()
            ],
          ),
        ]);
      },
    );
  }

  Step step4(lang) {
    return Step(
      title: Text(lang.theLastStep),
      state: StepState.complete,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          //thePrice
          Text(
            lang.thePrice,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormFieldWidget(
            hint: "",
            type: TextInputType.number,
            controller: princController,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            lang.flightDueDate,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {
              DateTime selectedDate = DateTime.now();
              final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030));
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                  dataTravleController.text =
                      DateFormat("dd/MM/yyyy").format(picked);
                });
              }
            },
            child: TextFormFieldWidget(
              hint: "",
              isEnable: false,
              type: TextInputType.number,
              controller: dataTravleController,
              icon: Icons.calendar_month_outlined,
            ),
          ),

          // response time
          // const SizedBox(
          //   height: 12,
          // ),
          // Text(
          //   lang.responseTime,
          //   style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(
          //   height: 4,
          // ),
          // Container(
          //   height: ScreenConfig.getRuntimeHeightByRatio(50),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.white,
          //   ),
          //   padding: const EdgeInsets.symmetric(horizontal: 8),
          //   child: DropdownButton(
          //     underline: Container(),
          //     value: dropdownvalueTime,
          //     icon: const Expanded(
          //       child: Align(
          //           alignment: AlignmentDirectional.centerEnd,
          //           child: Icon(Icons.arrow_drop_down)),
          //     ),
          //     items: itemsTime.map((String items) {
          //       return DropdownMenuItem(
          //         value: items,
          //         child: Text(items),
          //       );
          //     }).toList(),
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         dropdownvalueTime = newValue!;
          //       });
          //     },
          //   ),
          // ),

          // notes
          const SizedBox(
            height: 12,
          ),
          Text(
            lang.note,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          TextFormFieldWidget(
            hint: '',
            type: TextInputType.multiline,
            controller: noteController,
            isMulti: true,
          ),

          const SizedBox(
            height: 12,
          ),

          // Row(
          //   children: [
          //     Text(
          //       lang.isTheFlightTransferable,
          //       style:
          //           const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          //     ),
          //     Spacer(),
          //     Checkbox(
          //       value: isTheFlightTransferable,
          //       activeColor: kPrimaryColor,
          //       onChanged: (value) {
          //         setState(() {
          //           isTheFlightTransferable = value!;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                lang.expensesPriceDetails,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Checkbox(
                activeColor: kPrimaryColor,
                value: expensesPriceDetails,
                onChanged: (value) {
                  setState(() {
                    listExpItemControllers.clear();
                    addExpenc(context);
                    expensesPriceDetails = value!;
                  });
                },
              ),
            ],
          ),

          //-- expensesPriceDetails
          expensesPriceDetails
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(.8),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.transferScreenName,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 46,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextFormField(
                                            controller:
                                                listExpItemControllers[index]
                                                    [0],
                                            keyboardType: TextInputType.name,
                                            decoration: const InputDecoration(
                                              hintText: '',
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              isDense: true,
                                              filled: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.transferScreenPrice,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 46,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: TextFormField(
                                            controller:
                                                listExpItemControllers[index]
                                                    [1],
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: '',
                                              border: InputBorder.none,
                                              fillColor: Colors.white,
                                              isDense: true,
                                              filled: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.paymentType,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        _buildPaymentTypeSelector(lang, index),
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Container(
                                        //         height: 46,
                                        //         decoration: const BoxDecoration(
                                        //             color: Colors
                                        //                 .white,
                                        //             borderRadius: BorderRadius.only(
                                        //                 topRight:
                                        //                     Radius.circular(
                                        //                         8),
                                        //                 bottomRight:
                                        //                     Radius.circular(8))),
                                        //         alignment:
                                        //             Alignment
                                        //                 .center,
                                        //         child:
                                        //             TextFormField(
                                        //           controller: vm
                                        //                   .listItemControllers[
                                        //               index][2],
                                        //           keyboardType:
                                        //               TextInputType
                                        //                   .datetime,
                                        //           decoration: InputDecoration(
                                        //               hintText: vm.listItemControllers[index][2].text.isEmpty
                                        //                   ? ServiceCollector.getInstance().currentLanguage == 'en'
                                        //                       ? "not set"
                                        //                       : "لم يتم اختيار التاريخ "
                                        //                   : vm.listItemControllers[index][2].text,
                                        //               border: InputBorder.none,
                                        //               fillColor: Colors.white,
                                        //               isDense: true,
                                        //               filled: true,
                                        //               enabled: false),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       height: 46,
                                        //       padding: const EdgeInsets
                                        //               .symmetric(
                                        //           horizontal:
                                        //               6),
                                        //       decoration: const BoxDecoration(
                                        //           color: Colors
                                        //               .white,
                                        //           borderRadius: BorderRadius.only(
                                        //               topLeft:
                                        //                   Radius.circular(
                                        //                       8),
                                        //               bottomLeft:
                                        //                   Radius.circular(
                                        //                       8))),
                                        //       alignment: Alignment
                                        //           .centerLeft,
                                        //       child: InkWell(
                                        //         onTap: () {
                                        //           vm.setPaymentDatePrice(
                                        //               context,
                                        //               index);
                                        //         },
                                        //         child: Text(
                                        //           lang.select,
                                        //           style: textTitle(
                                        //               Colors
                                        //                   .black),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      listExpItemControllers.length - 1 == index
                                          ? InkWell(
                                              onTap: () {
                                                if (listExpItemControllers
                                                        .last[0]
                                                        .text
                                                        .isNotEmpty &&
                                                    listExpItemControllers
                                                        .last[1]
                                                        .text
                                                        .isNotEmpty &&
                                                    listExpItemControllers
                                                        .last[2]
                                                        .text
                                                        .isNotEmpty) {
                                                  addExpenc(context);
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg: 'en' == 'en'
                                                        ? 'please fill data'
                                                        : 'املأ البيانات',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      lang.addNewMony,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    const Icon(
                                                      Icons.add_rounded,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      listExpItemControllers.isNotEmpty &&
                                              index != 0
                                          ? InkWell(
                                              onTap: () {
                                                deleteExpenc();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: Colors.red,
                                                      width: 1,
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      lang.delete,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ]),
                          ),
                        ]);
                  },
                  itemCount: listExpItemControllers.length,
                )
              : Container(),
        ],
      ),
      isActive: _currentstep == 3,
    );
  }

  void add() {
    listItemControllers.add([
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ]);
  }

  void addPass() {
    passListItemControllers.add([
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ]);
  }

  void deletePass() {
    passListItemControllers.removeLast();
  }

  void delete() {
    listItemControllers.removeLast();
  }

  void addExpenc(context) {
    setState(() {
      listExpItemControllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
      listExpItemControllers.last[2].text = "1";
    });
  }

  final List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        value: '1',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Instant Payment'
            : 'دفع فوري')),
    DropdownMenuItem(
        value: '2',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Pay when paying for the flight'
            : 'دفع عند تسديد الرحلة')),
  ];

  Container _buildPaymentTypeSelector(AppLocalizations? lang, int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
            underline: Container(),
            isExpanded: true,
            value: listExpItemControllers[index][2].text.isEmpty
                ? "1"
                : listExpItemControllers[index][2].text,
            items: menuItems,
            onChanged: (value) {
              print(value);
              setState(() {
                listExpItemControllers[index][2].text = value.toString();
              });
              print(listExpItemControllers[index][2].text);
            }),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
    );
  }

  void deleteExpenc() {
    setState(() {
      listExpItemControllers.removeLast();
    });
  }

  Padding _buildDropListDistrict(TransferProvider vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectDistrict,
            style: textTitle(kPrimaryColor),
          ),
          Expanded(
            child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                hint: Text(
                    ServiceCollector.getInstance().currentLanguage == 'en'
                        ? 'Select District'
                        : 'اختر المنطقة'),
                value: region,
                items: districts
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.districtName),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    region = value.toString();
                  });
                }),
          )
        ],
      ),
    );
  }

  Padding _buildDropListCities(TransferProvider vm, AppLocalizations? lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            lang!.selectCity,
            style: textTitle(kPrimaryColor),
          ),
          Expanded(
            child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: city,
                hint: Text(
                    ServiceCollector.getInstance().currentLanguage == 'en'
                        ? 'Select City'
                        : 'اختر المدينة'),
                items: cities
                    .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem<String>(
                              value: e.id,
                              child: Text(e.cityName),
                            ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    city = value.toString();
                  });
                  syncDistricts(value as String);
                }),
          )
        ],
      ),
    );
  }

  void syncDistricts(String cityId) async {
    region = "";
    districts = [].cast<DistrictModel>();

    ServiceCollector.getInstance()
        .metaDataService
        .getDistricts(cityId)
        .then((value) {
      setState(() {
        districts = value;
        setState(() {
          region = districts[0].id;
        });
      });
    });
  }
}
