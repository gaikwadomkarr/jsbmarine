import 'package:flutter/material.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';

const String appName = "PrimePGs";

// Server Strings and URL's
String TOKEN = "";
String TOKEN_EXPIRES = "";
String REFRESH_TOKEN = "";
String REFRESH_TOKEN_EXPIRES = "";
String FILE_URL = "";
// String BASEURL = DataConstants.url;
const String BASEURL = "https://mjpbillingapi.jsbmarine.com";
// const String BASEURL="https://dev-api.core.primepg.penpenny.xyz/";

//const String singInUrl="/auth/signin";
const String singInUrl = "/Token";
const String checkTabUser = '/api/v1/Login/CheckTabuser';
const String insertSingleBill = '/api/v1/Bill/InsertBillEntry';
const String insertBulkBill = '/api/v1/Bill/InsertBillEntrys';
const String getBranch = '/api/v1/Branch/GetBranch';
const String newReading = "New Reading";
const String allEntries = "All Entries";
const String logout = "Logout";

const List<String> meterStatusList = [
  "Normal Billing",
  "Leak",
  "Lock",
  "Tamper",
  "No Use",
  "Meter Stop",
];
const List<String> allmeterStatusList = [
  "All",
  "Normal Billing",
  "Leak",
  "Lock",
  "Tamper",
  "No Use",
  "Meter Stop",
];

const List<String> meterStatusNoList = ["1", "2", "3", "4", "5", "6"];
const List<String> allmeterStatusNoList = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
];

// Important folder paths

const meterReadingDir = "MeterReading";
const picturesDir = "Pictures";
