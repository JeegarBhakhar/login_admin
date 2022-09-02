class Floor {
  String? id;
  String? floor;

  Floor({
    required this.id,
    required this.floor,
  });
  factory Floor.fromJson(Map<String, dynamic> json) {
    return Floor(
      id: json['id'],
      floor: json['floor'],
    );
  }
}

class Admin {
  String? id;
  String? username;
  String? password;

  Admin({
    required this.id,
    required this.username,
    required this.password,
  });
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

class Event {
  String? id;
  String? event;

  Event({
    required this.id,
    required this.event,
  });
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      event: json['event_name'],
    );
  }
}

class TblNote {
  String? id;
  String? wings;

  TblNote({
    required this.id,
    required this.wings,
  });
  factory TblNote.fromJson(Map<String, dynamic> json) {
    return TblNote(
      id: json['id'],
      wings: json['wing'],
    );
  }
}

class MUser {
  String? id;
  String? username;
  String? password;

  MUser({
    required this.id,
    required this.username,
    required this.password,
  });
  factory MUser.fromJson(Map<String, dynamic> json) {
    return MUser(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

class PayerTbl {
  String? id;
  String? floorId;
  String? floorName;
  String? payerMobileNamber;
  String? payerName;
  String? wingId;
  String? wingName;
  PayerTbl({
    required this.id,
    required this.floorId,
    required this.floorName,
    required this.payerMobileNamber,
    required this.payerName,
    required this.wingId,
    required this.wingName,
  });
  factory PayerTbl.fromJson(Map<String, dynamic> json) {
    return PayerTbl(
        id: json['id'],
        floorId: json['floor_id'],
        floorName: json['floor_name'],
        payerMobileNamber: json['payer_mobile_number'],
        payerName: json['payer_name'],
        wingId: json['wing_id'],
        wingName: json['wing_name']);
  }
}

class AddDonte {
  String? id;
  String? eventId;
  String? eventName;
  String? floorId;
  String? floorName;
  String? payerMobileNamber;
  String? payerName;
  String? wingId;
  String? wingName;
  String? amount;
  String? comment;
  AddDonte({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.floorId,
    required this.floorName,
    required this.payerMobileNamber,
    required this.payerName,
    required this.wingId,
    required this.wingName,
    required this.amount,
    required this.comment,
  });
  factory AddDonte.fromJson(Map<String, dynamic> json) {
    return AddDonte(
      id: json['id'],
      eventId: json['event_id'],
      eventName: json['event_name'],
      floorId: json['floor_id'],
      floorName: json['floor_name'],
      payerMobileNamber: json['payer_mobile_number'],
      payerName: json['payer_name'],
      wingId: json['wing_id'],
      wingName: json['wing_name'],
      amount: json['amount'],
      comment: json['comment'],
    );
  }
}
