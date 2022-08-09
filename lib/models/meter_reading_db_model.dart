class MeterReadingRecord {
  int? id;
  String? deviceId;
  String? scanDate;
  int? meterReading;
  int? barcode;
  String? miterNumber;
  int? userID;
  int? branchID;
  String? latitude;
  String? longitude;
  String? locationName;
  String? imageBase64;
  String? meterImage;
  String? uploadStatus;
  int? meterStatus;

  MeterReadingRecord(
      {this.id,
      this.deviceId,
      this.scanDate,
      this.meterReading,
      this.barcode,
      this.miterNumber,
      this.userID,
      this.branchID,
      this.latitude,
      this.longitude,
      this.locationName,
      this.imageBase64,
      this.meterImage,
      this.meterStatus,
      this.uploadStatus});

  MeterReadingRecord.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    deviceId = json['deviceId'];
    scanDate = json['scanDate'];
    meterReading = json['meterReading'];
    barcode = json['barcode'];
    miterNumber = json['miterNumber'];
    userID = json['userID'];
    branchID = json['branchID'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationName = json['locationName'];
    imageBase64 = json['imageBase64'];
    meterImage = json['meterImage'];
    meterStatus = json['meterStatus'];
    uploadStatus = json['uploadStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['scanDate'] = scanDate;
    data['meterReading'] = meterReading;
    data['barcode'] = barcode;
    data['miterNumber'] = miterNumber;
    data['userID'] = userID;
    data['branchID'] = branchID;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['locationName'] = locationName;
    data['imageBase64'] = imageBase64;
    data['meterImage'] = meterImage;
    data['meterStatus'] = meterStatus;
    data['uploadStatus'] = uploadStatus;
    return data;
  }
}
