// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome`
  String get welcome {
    return Intl.message(
      'welcome',
      name: 'welcome',
      desc: 'Sign In Screen ##########',
      args: [],
    );
  }

  /// `Login with your email`
  String get loginWithAccount {
    return Intl.message(
      'Login with your email',
      name: 'loginWithAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Keep me logged in`
  String get keepLogged {
    return Intl.message(
      'Keep me logged in',
      name: 'keepLogged',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Signup Here`
  String get signupHere {
    return Intl.message(
      'Signup Here',
      name: 'signupHere',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email is empty`
  String get emailIsEmpty {
    return Intl.message(
      'Email is empty',
      name: 'emailIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password is empty`
  String get passwordIsEmpty {
    return Intl.message(
      'Password is empty',
      name: 'passwordIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signup {
    return Intl.message(
      'SignUp',
      name: 'signup',
      desc: 'Explore Screen ##########',
      args: [],
    );
  }

  /// `Trip Type: `
  String get tripType {
    return Intl.message(
      'Trip Type: ',
      name: 'tripType',
      desc: '',
      args: [],
    );
  }

  /// `How to travel direction :`
  String get travelDirction {
    return Intl.message(
      'How to travel direction :',
      name: 'travelDirction',
      desc: '',
      args: [],
    );
  }

  /// `Reservation screen and role removal`
  String get reservationScreenAndRoleRemoval {
    return Intl.message(
      'Reservation screen and role removal',
      name: 'reservationScreenAndRoleRemoval',
      desc: '',
      args: [],
    );
  }

  /// `Step 1`
  String get step122 {
    return Intl.message(
      'Step 1',
      name: 'step122',
      desc: '',
      args: [],
    );
  }

  /// `Step 2`
  String get step222 {
    return Intl.message(
      'Step 2',
      name: 'step222',
      desc: '',
      args: [],
    );
  }

  /// `Step 3`
  String get step322 {
    return Intl.message(
      'Step 3',
      name: 'step322',
      desc: '',
      args: [],
    );
  }

  /// `Step 4`
  String get step422 {
    return Intl.message(
      'Step 4',
      name: 'step422',
      desc: '',
      args: [],
    );
  }

  /// `Direction to the point`
  String get getLocation {
    return Intl.message(
      'Direction to the point',
      name: 'getLocation',
      desc: '',
      args: [],
    );
  }

  /// `View locations`
  String get viewLocations {
    return Intl.message(
      'View locations',
      name: 'viewLocations',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get location {
    return Intl.message(
      'location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Maps`
  String get map {
    return Intl.message(
      'Maps',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Choose the source`
  String get selectPath {
    return Intl.message(
      'Choose the source',
      name: 'selectPath',
      desc: '',
      args: [],
    );
  }

  /// `Full Name:`
  String get fullname {
    return Intl.message(
      'Full Name:',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number:`
  String get phoneNumber {
    return Intl.message(
      'Phone Number:',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number 2 (Optional):`
  String get phoneNumber2 {
    return Intl.message(
      'Phone Number 2 (Optional):',
      name: 'phoneNumber2',
      desc: '',
      args: [],
    );
  }

  /// `Car Liscense Number:`
  String get carLiscenseNumber {
    return Intl.message(
      'Car Liscense Number:',
      name: 'carLiscenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Driver License Id:`
  String get driverLicenseId {
    return Intl.message(
      'Driver License Id:',
      name: 'driverLicenseId',
      desc: '',
      args: [],
    );
  }

  /// `Car Plate Number:`
  String get carNumber {
    return Intl.message(
      'Car Plate Number:',
      name: 'carNumber',
      desc: '',
      args: [],
    );
  }

  /// `License End Date:`
  String get licenseEndDate {
    return Intl.message(
      'License End Date:',
      name: 'licenseEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Not Set`
  String get notset {
    return Intl.message(
      'Not Set',
      name: 'notset',
      desc: '',
      args: [],
    );
  }

  /// `album`
  String get album {
    return Intl.message(
      'album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `camera`
  String get camera {
    return Intl.message(
      'camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Car Type:`
  String get carType {
    return Intl.message(
      'Car Type:',
      name: 'carType',
      desc: '',
      args: [],
    );
  }

  /// `Car Size:`
  String get carSize {
    return Intl.message(
      'Car Size:',
      name: 'carSize',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Select Car Type`
  String get selectCarType {
    return Intl.message(
      'Select Car Type',
      name: 'selectCarType',
      desc: '',
      args: [],
    );
  }

  /// `Select Car Size`
  String get selectCarSize {
    return Intl.message(
      'Select Car Size',
      name: 'selectCarSize',
      desc: '',
      args: [],
    );
  }

  /// `I agree to your `
  String get agreeTo {
    return Intl.message(
      'I agree to your ',
      name: 'agreeTo',
      desc: '',
      args: [],
    );
  }

  /// `Select Office`
  String get selectOffice {
    return Intl.message(
      'Select Office',
      name: 'selectOffice',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Select delete`
  String get selectDelete {
    return Intl.message(
      'Select delete',
      name: 'selectDelete',
      desc: '',
      args: [],
    );
  }

  /// `Search In Offices`
  String get searchInOffices {
    return Intl.message(
      'Search In Offices',
      name: 'searchInOffices',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `New Trips`
  String get explore {
    return Intl.message(
      'New Trips',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Price: `
  String get price {
    return Intl.message(
      'Price: ',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Response Time: `
  String get startAt {
    return Intl.message(
      'Response Time: ',
      name: 'startAt',
      desc: '',
      args: [],
    );
  }

  /// `Trip Owner: `
  String get tripOwner {
    return Intl.message(
      'Trip Owner: ',
      name: 'tripOwner',
      desc: '',
      args: [],
    );
  }

  /// `Show Details`
  String get showDetails {
    return Intl.message(
      'Show Details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Available Trips: `
  String get availableTrips {
    return Intl.message(
      'Available Trips: ',
      name: 'availableTrips',
      desc: '',
      args: [],
    );
  }

  /// `There are no trips for you at this moment, please check if you have take a role`
  String get noUserTripsMsg {
    return Intl.message(
      'There are no trips for you at this moment, please check if you have take a role',
      name: 'noUserTripsMsg',
      desc: '',
      args: [],
    );
  }

  /// `Take a role`
  String get takeARole {
    return Intl.message(
      'Take a role',
      name: 'takeARole',
      desc: '',
      args: [],
    );
  }

  /// ` JD`
  String get jd {
    return Intl.message(
      ' JD',
      name: 'jd',
      desc: '',
      args: [],
    );
  }

  /// `Commission: `
  String get commission {
    return Intl.message(
      'Commission: ',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `Trip Classification: `
  String get tripClassification {
    return Intl.message(
      'Trip Classification: ',
      name: 'tripClassification',
      desc: '',
      args: [],
    );
  }

  /// `Number of passengers: `
  String get numberOfPassengers {
    return Intl.message(
      'Number of passengers: ',
      name: 'numberOfPassengers',
      desc: '',
      args: [],
    );
  }

  /// `Number of days: `
  String get numberOfDays {
    return Intl.message(
      'Number of days: ',
      name: 'numberOfDays',
      desc: '',
      args: [],
    );
  }

  /// `Search for by name`
  String get searchForDriver {
    return Intl.message(
      'Search for by name',
      name: 'searchForDriver',
      desc: 'Search Nav Screen ##########',
      args: [],
    );
  }

  /// `No search result`
  String get searchNoResult {
    return Intl.message(
      'No search result',
      name: 'searchNoResult',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get generalInformation {
    return Intl.message(
      'General Information',
      name: 'generalInformation',
      desc: 'Trip Details Screen ##########',
      args: [],
    );
  }

  /// `Trip Price: `
  String get tripPrice {
    return Intl.message(
      'Trip Price: ',
      name: 'tripPrice',
      desc: '',
      args: [],
    );
  }

  /// `Phone: `
  String get phone {
    return Intl.message(
      'Phone: ',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Time To Response: `
  String get timeToResponse {
    return Intl.message(
      'Time To Response: ',
      name: 'timeToResponse',
      desc: '',
      args: [],
    );
  }

  /// `Trip Date Added: `
  String get tripDateAdded {
    return Intl.message(
      'Trip Date Added: ',
      name: 'tripDateAdded',
      desc: '',
      args: [],
    );
  }

  /// `Payment Date: `
  String get paymentDate {
    return Intl.message(
      'Payment Date: ',
      name: 'paymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Payment: `
  String get payment {
    return Intl.message(
      'Payment: ',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Name of the airline and flight number :`
  String get flightNumber {
    return Intl.message(
      'Name of the airline and flight number :',
      name: 'flightNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sign Name: `
  String get signName {
    return Intl.message(
      'Sign Name: ',
      name: 'signName',
      desc: '',
      args: [],
    );
  }

  /// `Trip Program`
  String get tripProgram {
    return Intl.message(
      'Trip Program',
      name: 'tripProgram',
      desc: '',
      args: [],
    );
  }

  /// `Start Point: `
  String get startPoint {
    return Intl.message(
      'Start Point: ',
      name: 'startPoint',
      desc: '',
      args: [],
    );
  }

  /// `End Point: `
  String get endPoint {
    return Intl.message(
      'End Point: ',
      name: 'endPoint',
      desc: '',
      args: [],
    );
  }

  /// `Date: `
  String get date {
    return Intl.message(
      'Date: ',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Additional amounts`
  String get tripExpenses {
    return Intl.message(
      'Additional amounts',
      name: 'tripExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Passengers`
  String get tripPassengers {
    return Intl.message(
      'Passengers',
      name: 'tripPassengers',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get takeTrip {
    return Intl.message(
      'Agree',
      name: 'takeTrip',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `none`
  String get none {
    return Intl.message(
      'none',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Name: `
  String get name {
    return Intl.message(
      'Name: ',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `   Passport: `
  String get passport {
    return Intl.message(
      '   Passport: ',
      name: 'passport',
      desc: '',
      args: [],
    );
  }

  /// `   Nationality: `
  String get nationality {
    return Intl.message(
      '   Nationality: ',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Amount: `
  String get amount {
    return Intl.message(
      'Amount: ',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Added Date: `
  String get addedDate {
    return Intl.message(
      'Added Date: ',
      name: 'addedDate',
      desc: '',
      args: [],
    );
  }

  /// `Completed At: `
  String get completedAt {
    return Intl.message(
      'Completed At: ',
      name: 'completedAt',
      desc: '',
      args: [],
    );
  }

  /// `End Trip`
  String get endTrip {
    return Intl.message(
      'End Trip',
      name: 'endTrip',
      desc: '',
      args: [],
    );
  }

  /// `Get Paid`
  String get getPaid {
    return Intl.message(
      'Get Paid',
      name: 'getPaid',
      desc: '',
      args: [],
    );
  }

  /// `Payment Completed`
  String get paymentCompleted {
    return Intl.message(
      'Payment Completed',
      name: 'paymentCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get canceltextButton {
    return Intl.message(
      'Cancel',
      name: 'canceltextButton',
      desc: '',
      args: [],
    );
  }

  /// `Note: `
  String get note {
    return Intl.message(
      'Note: ',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Add New Expenses`
  String get addNewExpenses {
    return Intl.message(
      'Add New Expenses',
      name: 'addNewExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Field is empty`
  String get fieldIsEmpty {
    return Intl.message(
      'Field is empty',
      name: 'fieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Trip`
  String get transferTrip {
    return Intl.message(
      'Transfer Trip',
      name: 'transferTrip',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get transfer {
    return Intl.message(
      'Transfer',
      name: 'transfer',
      desc: '',
      args: [],
    );
  }

  /// `#id: `
  String get id {
    return Intl.message(
      '#id: ',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Trip is completed at`
  String get tripIsEnd {
    return Intl.message(
      'Trip is completed at',
      name: 'tripIsEnd',
      desc: '',
      args: [],
    );
  }

  /// `Preparing the file ...`
  String get preparingTheFile {
    return Intl.message(
      'Preparing the file ...',
      name: 'preparingTheFile',
      desc: '',
      args: [],
    );
  }

  /// `Is able to transfer: `
  String get isAbleToTransfer {
    return Intl.message(
      'Is able to transfer: ',
      name: 'isAbleToTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Trip`
  String get cancelTrip {
    return Intl.message(
      'Cancel Trip',
      name: 'cancelTrip',
      desc: '',
      args: [],
    );
  }

  /// `Delegate phone : `
  String get phonenum {
    return Intl.message(
      'Delegate phone : ',
      name: 'phonenum',
      desc: '',
      args: [],
    );
  }

  /// `Start Time: `
  String get startTime {
    return Intl.message(
      'Start Time: ',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `Trip Number`
  String get tripNumber {
    return Intl.message(
      'Trip Number',
      name: 'tripNumber',
      desc: '',
      args: [],
    );
  }

  /// `Send Notification`
  String get sendNotification {
    return Intl.message(
      'Send Notification',
      name: 'sendNotification',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to public role`
  String get transferToPublicRole {
    return Intl.message(
      'Transfer to public role',
      name: 'transferToPublicRole',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to driver`
  String get transferToPrivateRole {
    return Intl.message(
      'Transfer to driver',
      name: 'transferToPrivateRole',
      desc: '',
      args: [],
    );
  }

  /// `Search Result`
  String get searchResult {
    return Intl.message(
      'Search Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `You have to select driver`
  String get youHaveToSelectDriverS {
    return Intl.message(
      'You have to select driver',
      name: 'youHaveToSelectDriverS',
      desc: '',
      args: [],
    );
  }

  /// `Program `
  String get program {
    return Intl.message(
      'Program ',
      name: 'program',
      desc: '',
      args: [],
    );
  }

  /// `Chat trip number`
  String get chatTripNumber {
    return Intl.message(
      'Chat trip number',
      name: 'chatTripNumber',
      desc: '',
      args: [],
    );
  }

  /// `Trip Start Date:`
  String get tripStartDate {
    return Intl.message(
      'Trip Start Date:',
      name: 'tripStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Trips`
  String get trips {
    return Intl.message(
      'Trips',
      name: 'trips',
      desc: '',
      args: [],
    );
  }

  /// `General Role`
  String get generalRole {
    return Intl.message(
      'General Role',
      name: 'generalRole',
      desc: 'Take Role Screen ##########',
      args: [],
    );
  }

  /// `We advise you to renew your role again`
  String get advise {
    return Intl.message(
      'We advise you to renew your role again',
      name: 'advise',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Press Button to take general role`
  String get hintGeneralTakeRole {
    return Intl.message(
      'Press Button to take general role',
      name: 'hintGeneralTakeRole',
      desc: '',
      args: [],
    );
  }

  /// `Take General Role`
  String get takeGeneralRole {
    return Intl.message(
      'Take General Role',
      name: 'takeGeneralRole',
      desc: '',
      args: [],
    );
  }

  /// `Daily reservation according to the location`
  String get specificRole {
    return Intl.message(
      'Daily reservation according to the location',
      name: 'specificRole',
      desc: '',
      args: [],
    );
  }

  /// `Book on the agenda for future trips`
  String get saveCCB {
    return Intl.message(
      'Book on the agenda for future trips',
      name: 'saveCCB',
      desc: '',
      args: [],
    );
  }

  /// `Select City & District`
  String get selectCityAndDistrict {
    return Intl.message(
      'Select City & District',
      name: 'selectCityAndDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Select City: `
  String get selectCity {
    return Intl.message(
      'Select City: ',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Select District: `
  String get selectDistrict {
    return Intl.message(
      'Select District: ',
      name: 'selectDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Current Role`
  String get currentRole {
    return Intl.message(
      'Current Role',
      name: 'currentRole',
      desc: '',
      args: [],
    );
  }

  /// `Remove General Role`
  String get removeGeneralRole {
    return Intl.message(
      'Remove General Role',
      name: 'removeGeneralRole',
      desc: '',
      args: [],
    );
  }

  /// `Take Specific Role`
  String get takeSpecificRole {
    return Intl.message(
      'Take Specific Role',
      name: 'takeSpecificRole',
      desc: '',
      args: [],
    );
  }

  /// `Click button to remove your role`
  String get hasSpecificRoleHint {
    return Intl.message(
      'Click button to remove your role',
      name: 'hasSpecificRoleHint',
      desc: '',
      args: [],
    );
  }

  /// `Remove Specific Role`
  String get removeSpecificRole {
    return Intl.message(
      'Remove Specific Role',
      name: 'removeSpecificRole',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get archived {
    return Intl.message(
      'Archived',
      name: 'archived',
      desc: '',
      args: [],
    );
  }

  /// `There are no`
  String get thereAreNo {
    return Intl.message(
      'There are no',
      name: 'thereAreNo',
      desc: '',
      args: [],
    );
  }

  /// `dashboared`
  String get dashboared {
    return Intl.message(
      'dashboared',
      name: 'dashboared',
      desc: 'Profile Screen ##########',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get payments {
    return Intl.message(
      'Finance',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `Take or delete a role`
  String get booking {
    return Intl.message(
      'Take or delete a role',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get account {
    return Intl.message(
      'My account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `chats`
  String get chatsGroups {
    return Intl.message(
      'chats',
      name: 'chatsGroups',
      desc: '',
      args: [],
    );
  }

  /// `Delete my account`
  String get deleteAccount {
    return Intl.message(
      'Delete my account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `Transferred trips`
  String get transferredTrips {
    return Intl.message(
      'Transferred trips',
      name: 'transferredTrips',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Document number:`
  String get documentNumber {
    return Intl.message(
      'Document number:',
      name: 'documentNumber',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Tourist nationality :`
  String get touristNationality {
    return Intl.message(
      'Tourist nationality :',
      name: 'touristNationality',
      desc: '',
      args: [],
    );
  }

  /// `The price :`
  String get thePrice {
    return Intl.message(
      'The price :',
      name: 'thePrice',
      desc: '',
      args: [],
    );
  }

  /// `Flight due date :`
  String get flightDueDate {
    return Intl.message(
      'Flight due date :',
      name: 'flightDueDate',
      desc: '',
      args: [],
    );
  }

  /// `response time :`
  String get responseTime {
    return Intl.message(
      'response time :',
      name: 'responseTime',
      desc: '',
      args: [],
    );
  }

  /// `Is the flight transferable ?`
  String get isTheFlightTransferable {
    return Intl.message(
      'Is the flight transferable ?',
      name: 'isTheFlightTransferable',
      desc: '',
      args: [],
    );
  }

  /// `Visitor name:`
  String get touristName {
    return Intl.message(
      'Visitor name:',
      name: 'touristName',
      desc: '',
      args: [],
    );
  }

  /// `Delete a role`
  String get deleteARole {
    return Intl.message(
      'Delete a role',
      name: 'deleteARole',
      desc: '',
      args: [],
    );
  }

  /// `Representative or establishment phone`
  String get representativeEstablishmentPhone {
    return Intl.message(
      'Representative or establishment phone',
      name: 'representativeEstablishmentPhone',
      desc: '',
      args: [],
    );
  }

  /// `Update profile data`
  String get updateProfileData {
    return Intl.message(
      'Update profile data',
      name: 'updateProfileData',
      desc: '',
      args: [],
    );
  }

  /// `Business owner dashboard`
  String get ownerDashboard {
    return Intl.message(
      'Business owner dashboard',
      name: 'ownerDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Name of the financial entry?`
  String get nameFinancial {
    return Intl.message(
      'Name of the financial entry?',
      name: 'nameFinancial',
      desc: 'Finance Screen ##########',
      args: [],
    );
  }

  /// `Step 1`
  String get step1 {
    return Intl.message(
      'Step 1',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `Step 2`
  String get step2 {
    return Intl.message(
      'Step 2',
      name: 'step2',
      desc: '',
      args: [],
    );
  }

  /// `You do not have any finances yet`
  String get youDontHaveFinances {
    return Intl.message(
      'You do not have any finances yet',
      name: 'youDontHaveFinances',
      desc: '',
      args: [],
    );
  }

  /// `Financial Record`
  String get financialRecord {
    return Intl.message(
      'Financial Record',
      name: 'financialRecord',
      desc: '',
      args: [],
    );
  }

  /// `You searched for `
  String get youSearchedFor {
    return Intl.message(
      'You searched for ',
      name: 'youSearchedFor',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle capacity :`
  String get vehicleCapacity {
    return Intl.message(
      'Vehicle capacity :',
      name: 'vehicleCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle category :`
  String get vehicleCapacity3 {
    return Intl.message(
      'Vehicle category :',
      name: 'vehicleCapacity3',
      desc: '',
      args: [],
    );
  }

  /// `Place :`
  String get itineraries {
    return Intl.message(
      'Place :',
      name: 'itineraries',
      desc: '',
      args: [],
    );
  }

  /// `As: Amman - Acaba`
  String get example1 {
    return Intl.message(
      'As: Amman - Acaba',
      name: 'example1',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `location (optional) :`
  String get residence {
    return Intl.message(
      'location (optional) :',
      name: 'residence',
      desc: '',
      args: [],
    );
  }

  /// `Day :`
  String get day {
    return Intl.message(
      'Day :',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Add a new path`
  String get addANewPath {
    return Intl.message(
      'Add a new path',
      name: 'addANewPath',
      desc: '',
      args: [],
    );
  }

  /// `Total trips piece: `
  String get totalTripsPrice {
    return Intl.message(
      'Total trips piece: ',
      name: 'totalTripsPrice',
      desc: '',
      args: [],
    );
  }

  /// `Total expenses: `
  String get totalExpenses {
    return Intl.message(
      'Total expenses: ',
      name: 'totalExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashbord {
    return Intl.message(
      'Dashboard',
      name: 'dashbord',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle rating :`
  String get vehicleRating {
    return Intl.message(
      'Vehicle rating :',
      name: 'vehicleRating',
      desc: '',
      args: [],
    );
  }

  /// `Total commission: `
  String get totalCommissions {
    return Intl.message(
      'Total commission: ',
      name: 'totalCommissions',
      desc: '',
      args: [],
    );
  }

  /// `time ago`
  String get passedOn {
    return Intl.message(
      'time ago',
      name: 'passedOn',
      desc: '',
      args: [],
    );
  }

  /// `No location selected`
  String get example2 {
    return Intl.message(
      'No location selected',
      name: 'example2',
      desc: '',
      args: [],
    );
  }

  /// `Departure time:`
  String get departureTime {
    return Intl.message(
      'Departure time:',
      name: 'departureTime',
      desc: '',
      args: [],
    );
  }

  /// `Add expenses`
  String get addMony {
    return Intl.message(
      'Add expenses',
      name: 'addMony',
      desc: '',
      args: [],
    );
  }

  /// `Add new expenses`
  String get addNewMony {
    return Intl.message(
      'Add new expenses',
      name: 'addNewMony',
      desc: '',
      args: [],
    );
  }

  /// `Total dues: `
  String get totalDues {
    return Intl.message(
      'Total dues: ',
      name: 'totalDues',
      desc: '',
      args: [],
    );
  }

  /// `Total receivables : `
  String get totalAmountDues {
    return Intl.message(
      'Total receivables : ',
      name: 'totalAmountDues',
      desc: '',
      args: [],
    );
  }

  /// `From driver`
  String get fromDriver {
    return Intl.message(
      'From driver',
      name: 'fromDriver',
      desc: '',
      args: [],
    );
  }

  /// `From office`
  String get fromOffice {
    return Intl.message(
      'From office',
      name: 'fromOffice',
      desc: '',
      args: [],
    );
  }

  /// `Personal profile`
  String get homepage {
    return Intl.message(
      'Personal profile',
      name: 'homepage',
      desc: '',
      args: [],
    );
  }

  /// `Transfer trips`
  String get transferFlights {
    return Intl.message(
      'Transfer trips',
      name: 'transferFlights',
      desc: '',
      args: [],
    );
  }

  /// `single trip`
  String get transferFlights2 {
    return Intl.message(
      'single trip',
      name: 'transferFlights2',
      desc: '',
      args: [],
    );
  }

  /// `New trips`
  String get newTrips {
    return Intl.message(
      'New trips',
      name: 'newTrips',
      desc: '',
      args: [],
    );
  }

  /// `role number`
  String get roleNumber {
    return Intl.message(
      'role number',
      name: 'roleNumber',
      desc: '',
      args: [],
    );
  }

  /// `Book a role`
  String get bookARole {
    return Intl.message(
      'Book a role',
      name: 'bookARole',
      desc: '',
      args: [],
    );
  }

  /// `If you want to delete your account,`
  String get deleteAccountText {
    return Intl.message(
      'If you want to delete your account,',
      name: 'deleteAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get clickHere {
    return Intl.message(
      'Delete Account',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// `Filtering`
  String get filtering {
    return Intl.message(
      'Filtering',
      name: 'filtering',
      desc: 'Finance Details Screen ##########',
      args: [],
    );
  }

  /// `From Date: `
  String get fromDate {
    return Intl.message(
      'From Date: ',
      name: 'fromDate',
      desc: '',
      args: [],
    );
  }

  /// `To Date: `
  String get toDate {
    return Intl.message(
      'To Date: ',
      name: 'toDate',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Filtered Result`
  String get filteredResult {
    return Intl.message(
      'Filtered Result',
      name: 'filteredResult',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid Trips`
  String get unpaidTrips {
    return Intl.message(
      'Unpaid Trips',
      name: 'unpaidTrips',
      desc: '',
      args: [],
    );
  }

  /// `Trip Price: `
  String get tripPriceDetails {
    return Intl.message(
      'Trip Price: ',
      name: 'tripPriceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Additional amounts :`
  String get expensesPriceDetails {
    return Intl.message(
      'Additional amounts :',
      name: 'expensesPriceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Commission: `
  String get commissionPriceDetails {
    return Intl.message(
      'Commission: ',
      name: 'commissionPriceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Trip Number: `
  String get financialTripSourceId {
    return Intl.message(
      'Trip Number: ',
      name: 'financialTripSourceId',
      desc: '',
      args: [],
    );
  }

  /// `All Data`
  String get allData {
    return Intl.message(
      'All Data',
      name: 'allData',
      desc: 'Archive Details Screen ##########',
      args: [],
    );
  }

  /// `Trip `
  String get trip {
    return Intl.message(
      'Trip ',
      name: 'trip',
      desc: '',
      args: [],
    );
  }

  /// `Total Result`
  String get totalResult {
    return Intl.message(
      'Total Result',
      name: 'totalResult',
      desc: '',
      args: [],
    );
  }

  /// `Display All`
  String get displayAll {
    return Intl.message(
      'Display All',
      name: 'displayAll',
      desc: '',
      args: [],
    );
  }

  /// `Search for trip`
  String get searchForTrip {
    return Intl.message(
      'Search for trip',
      name: 'searchForTrip',
      desc: '',
      args: [],
    );
  }

  /// `There is no Archive Data`
  String get thereIsNoArchive {
    return Intl.message(
      'There is no Archive Data',
      name: 'thereIsNoArchive',
      desc: '',
      args: [],
    );
  }

  /// `Abstract`
  String get abstract {
    return Intl.message(
      'Abstract',
      name: 'abstract',
      desc: '',
      args: [],
    );
  }

  /// `Archived Trips: `
  String get archivedTrips {
    return Intl.message(
      'Archived Trips: ',
      name: 'archivedTrips',
      desc: '',
      args: [],
    );
  }

  /// `Total Profit: `
  String get totalProfit {
    return Intl.message(
      'Total Profit: ',
      name: 'totalProfit',
      desc: '',
      args: [],
    );
  }

  /// `Transferred to: `
  String get transferredTo {
    return Intl.message(
      'Transferred to: ',
      name: 'transferredTo',
      desc: 'Transferred Screen ##########',
      args: [],
    );
  }

  /// `All notifications`
  String get notificationsGlobal {
    return Intl.message(
      'All notifications',
      name: 'notificationsGlobal',
      desc: '',
      args: [],
    );
  }

  /// `There are no data`
  String get thereAreNoData {
    return Intl.message(
      'There are no data',
      name: 'thereAreNoData',
      desc: '',
      args: [],
    );
  }

  /// `There are no notification`
  String get thereAreNoDatanOTI {
    return Intl.message(
      'There are no notification',
      name: 'thereAreNoDatanOTI',
      desc: '',
      args: [],
    );
  }

  /// `Delete Message`
  String get deleteMessage {
    return Intl.message(
      'Delete Message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this message from everyone?`
  String get doYouWantDeleteMessage {
    return Intl.message(
      'Do you want to delete this message from everyone?',
      name: 'doYouWantDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteTheAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteTheAccount',
      desc: '',
      args: [],
    );
  }

  /// `- Deletion terms`
  String get deletionTerms {
    return Intl.message(
      '- Deletion terms',
      name: 'deletionTerms',
      desc: '',
      args: [],
    );
  }

  /// `My Groups`
  String get myGroups {
    return Intl.message(
      'My Groups',
      name: 'myGroups',
      desc: 'Groups  Screen ##########',
      args: [],
    );
  }

  /// `Other Groups`
  String get otherGroups {
    return Intl.message(
      'Other Groups',
      name: 'otherGroups',
      desc: '',
      args: [],
    );
  }

  /// `There are no groups at this moment`
  String get thereAreNoGroups {
    return Intl.message(
      'There are no groups at this moment',
      name: 'thereAreNoGroups',
      desc: '',
      args: [],
    );
  }

  /// `Create New Group`
  String get createNewGroup {
    return Intl.message(
      'Create New Group',
      name: 'createNewGroup',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get groupName {
    return Intl.message(
      'Group Name',
      name: 'groupName',
      desc: '',
      args: [],
    );
  }

  /// `Create Group`
  String get createGroup {
    return Intl.message(
      'Create Group',
      name: 'createGroup',
      desc: '',
      args: [],
    );
  }

  /// `invite`
  String get invite {
    return Intl.message(
      'invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `Your have at least to invite one driver`
  String get youHaveToInviteUser {
    return Intl.message(
      'Your have at least to invite one driver',
      name: 'youHaveToInviteUser',
      desc: '',
      args: [],
    );
  }

  /// `View members`
  String get view {
    return Intl.message(
      'View members',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `leave`
  String get leave {
    return Intl.message(
      'leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Leave group`
  String get leaveGroupe {
    return Intl.message(
      'Leave group',
      name: 'leaveGroupe',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to leave the group ?`
  String get sureLeaveGroup {
    return Intl.message(
      'Are you sure to leave the group ?',
      name: 'sureLeaveGroup',
      desc: '',
      args: [],
    );
  }

  /// `Add Members`
  String get addMembers {
    return Intl.message(
      'Add Members',
      name: 'addMembers',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get members {
    return Intl.message(
      'Members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `NEW 🔥`
  String get newTex {
    return Intl.message(
      'NEW 🔥',
      name: 'newTex',
      desc: 'Notification  Screen ##########',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forgetPasswordTitle {
    return Intl.message(
      'Forget Password',
      name: 'forgetPasswordTitle',
      desc: 'Forget Password  Screen ##########',
      args: [],
    );
  }

  /// `- other information`
  String get learnAbout {
    return Intl.message(
      '- other information',
      name: 'learnAbout',
      desc: '',
      args: [],
    );
  }

  /// `You will lose all private data in this account .`
  String get learn0 {
    return Intl.message(
      'You will lose all private data in this account .',
      name: 'learn0',
      desc: '',
      args: [],
    );
  }

  /// `You will lose all private data in this account .`
  String get learn1 {
    return Intl.message(
      'You will lose all private data in this account .',
      name: 'learn1',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address associated with your account.`
  String get enterTheEmailAddress {
    return Intl.message(
      'Enter the email address associated with your account.',
      name: 'enterTheEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Financial obligations must be terminated .`
  String get term0 {
    return Intl.message(
      'Financial obligations must be terminated .',
      name: 'term0',
      desc: '',
      args: [],
    );
  }

  /// `All flights, including diverted ones, must be terminated .`
  String get term1 {
    return Intl.message(
      'All flights, including diverted ones, must be terminated .',
      name: 'term1',
      desc: '',
      args: [],
    );
  }

  /// `We will email you a link to reset your password`
  String get weWillEmailYou {
    return Intl.message(
      'We will email you a link to reset your password',
      name: 'weWillEmailYou',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a password recovery instruction to your email`
  String get weHaveSentPasswordRecovery {
    return Intl.message(
      'We have sent a password recovery instruction to your email',
      name: 'weHaveSentPasswordRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Type message here`
  String get typeMessageHere {
    return Intl.message(
      'Type message here',
      name: 'typeMessageHere',
      desc: '',
      args: [],
    );
  }

  /// `My Private Trips`
  String get myPrivateTrips {
    return Intl.message(
      'My Private Trips',
      name: 'myPrivateTrips',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updateProfile {
    return Intl.message(
      'Update profile',
      name: 'updateProfile',
      desc: 'Update Profile Screen ##########',
      args: [],
    );
  }

  /// `Reminder`
  String get eventNote {
    return Intl.message(
      'Reminder',
      name: 'eventNote',
      desc: '',
      args: [],
    );
  }

  /// `more than one trip`
  String get moreThanOneProgram {
    return Intl.message(
      'more than one trip',
      name: 'moreThanOneProgram',
      desc: '',
      args: [],
    );
  }

  /// `more than one batch`
  String get moreThanOneBatch {
    return Intl.message(
      'more than one batch',
      name: 'moreThanOneBatch',
      desc: '',
      args: [],
    );
  }

  /// `One batch`
  String get oneBatch {
    return Intl.message(
      'One batch',
      name: 'oneBatch',
      desc: '',
      args: [],
    );
  }

  /// `Diverted Trips`
  String get mytransferFlights {
    return Intl.message(
      'Diverted Trips',
      name: 'mytransferFlights',
      desc: '',
      args: [],
    );
  }

  /// `Communication phone :`
  String get persingerPhone {
    return Intl.message(
      'Communication phone :',
      name: 'persingerPhone',
      desc: '',
      args: [],
    );
  }

  /// `Type of Request :`
  String get requestType {
    return Intl.message(
      'Type of Request :',
      name: 'requestType',
      desc: '',
      args: [],
    );
  }

  /// `city :`
  String get city {
    return Intl.message(
      'city :',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Search by name, nickname or phone number :`
  String get searchWayes {
    return Intl.message(
      'Search by name, nickname or phone number :',
      name: 'searchWayes',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `A place has been chosen`
  String get palceChoose {
    return Intl.message(
      'A place has been chosen',
      name: 'palceChoose',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get updateData {
    return Intl.message(
      'Update Data',
      name: 'updateData',
      desc: '',
      args: [],
    );
  }

  /// `Sign number :`
  String get sign {
    return Intl.message(
      'Sign number :',
      name: 'sign',
      desc: '',
      args: [],
    );
  }

  /// `Activate business owner dashboared`
  String get activateAsOwner {
    return Intl.message(
      'Activate business owner dashboared',
      name: 'activateAsOwner',
      desc: '',
      args: [],
    );
  }

  /// `Profile data`
  String get profileData {
    return Intl.message(
      'Profile data',
      name: 'profileData',
      desc: '',
      args: [],
    );
  }

  /// `Travel notification`
  String get travelNotification {
    return Intl.message(
      'Travel notification',
      name: 'travelNotification',
      desc: '',
      args: [],
    );
  }

  /// `Trip chat notifications`
  String get chatNotification {
    return Intl.message(
      'Trip chat notifications',
      name: 'chatNotification',
      desc: '',
      args: [],
    );
  }

  /// `Finance notification`
  String get financeNotification {
    return Intl.message(
      'Finance notification',
      name: 'financeNotification',
      desc: '',
      args: [],
    );
  }

  /// `requested price`
  String get transferScreenPrice {
    return Intl.message(
      'requested price',
      name: 'transferScreenPrice',
      desc: '',
      args: [],
    );
  }

  /// `Expense description`
  String get transferScreenName {
    return Intl.message(
      'Expense description',
      name: 'transferScreenName',
      desc: '',
      args: [],
    );
  }

  /// `payment method`
  String get paymentType {
    return Intl.message(
      'payment method',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Create trip`
  String get createTrip {
    return Intl.message(
      'Create trip',
      name: 'createTrip',
      desc: '',
      args: [],
    );
  }

  /// `please fill data`
  String get fillData {
    return Intl.message(
      'please fill data',
      name: 'fillData',
      desc: '',
      args: [],
    );
  }

  /// `The name of the sign`
  String get ismAlSha5isa {
    return Intl.message(
      'The name of the sign',
      name: 'ismAlSha5isa',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Keep booking the role always and be efficient`
  String get saveCC {
    return Intl.message(
      'Keep booking the role always and be efficient',
      name: 'saveCC',
      desc: '',
      args: [],
    );
  }

  /// `Add another passenger`
  String get addNewPassinger {
    return Intl.message(
      'Add another passenger',
      name: 'addNewPassinger',
      desc: '',
      args: [],
    );
  }

  /// `Canceled flights`
  String get canceledFlights {
    return Intl.message(
      'Canceled flights',
      name: 'canceledFlights',
      desc: '',
      args: [],
    );
  }

  /// `Archived as driver`
  String get driverASD {
    return Intl.message(
      'Archived as driver',
      name: 'driverASD',
      desc: '',
      args: [],
    );
  }

  /// `Adjustment of the flight fare`
  String get abed {
    return Intl.message(
      'Adjustment of the flight fare',
      name: 'abed',
      desc: '',
      args: [],
    );
  }

  /// `Archived as owner`
  String get canceledFlight2 {
    return Intl.message(
      'Archived as owner',
      name: 'canceledFlight2',
      desc: '',
      args: [],
    );
  }

  /// `flight number :`
  String get flightNo {
    return Intl.message(
      'flight number :',
      name: 'flightNo',
      desc: '',
      args: [],
    );
  }

  /// `Excursions scheduled for this day`
  String get flightASD {
    return Intl.message(
      'Excursions scheduled for this day',
      name: 'flightASD',
      desc: '',
      args: [],
    );
  }

  /// `Explanation of expenses`
  String get notenote {
    return Intl.message(
      'Explanation of expenses',
      name: 'notenote',
      desc: '',
      args: [],
    );
  }

  /// `Presence reservation`
  String get inCity {
    return Intl.message(
      'Presence reservation',
      name: 'inCity',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get inArea {
    return Intl.message(
      'Area',
      name: 'inArea',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to archive the trip ?`
  String get askArchive {
    return Intl.message(
      'Would you like to archive the trip ?',
      name: 'askArchive',
      desc: '',
      args: [],
    );
  }

  /// `If you want to save the trip in the archive, press Yes`
  String get learnArchive {
    return Intl.message(
      'If you want to save the trip in the archive, press Yes',
      name: 'learnArchive',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `The insurance expiry date:`
  String get licenseEndDate3 {
    return Intl.message(
      'The insurance expiry date:',
      name: 'licenseEndDate3',
      desc: '',
      args: [],
    );
  }

  /// `Basic information`
  String get basicInformation {
    return Intl.message(
      'Basic information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `tracks`
  String get tracks {
    return Intl.message(
      'tracks',
      name: 'tracks',
      desc: '',
      args: [],
    );
  }

  /// `The last step`
  String get theLastStep {
    return Intl.message(
      'The last step',
      name: 'theLastStep',
      desc: '',
      args: [],
    );
  }

  /// `End track`
  String get endTrack {
    return Intl.message(
      'End track',
      name: 'endTrack',
      desc: '',
      args: [],
    );
  }

  /// `Driver name`
  String get driverName {
    return Intl.message(
      'Driver name',
      name: 'driverName',
      desc: '',
      args: [],
    );
  }

  /// `Trips Balance`
  String get tripsBalance {
    return Intl.message(
      'Trips Balance',
      name: 'tripsBalance',
      desc: '',
      args: [],
    );
  }

  /// `Available Trip Account`
  String get availableTripAccount {
    return Intl.message(
      'Available Trip Account',
      name: 'availableTripAccount',
      desc: '',
      args: [],
    );
  }

  /// `Booked Trip Account`
  String get bookedTripAccount {
    return Intl.message(
      'Booked Trip Account',
      name: 'bookedTripAccount',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get booked {
    return Intl.message(
      'Booked',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Trips Financial`
  String get tripsFinanical {
    return Intl.message(
      'Trips Financial',
      name: 'tripsFinanical',
      desc: '',
      args: [],
    );
  }

  /// `Trips Chat`
  String get tripsChat {
    return Intl.message(
      'Trips Chat',
      name: 'tripsChat',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
