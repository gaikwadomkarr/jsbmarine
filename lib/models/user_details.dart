class UserDetails {
  String? userID;
  String? name;
  String? branchID;
  String? message;

  UserDetails({this.userID, this.name, this.branchID, this.message});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    name = json['Name'];
    branchID = json['BranchID'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['Name'] = this.name;
    data['BranchID'] = this.branchID;
    data['Message'] = this.message;
    return data;
  }
}
