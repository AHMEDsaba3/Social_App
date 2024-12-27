class MessageModel {
  String? text;
  String? senderId;
  String? receiverID;
  String? dateTime;

  MessageModel({
    this.text,
    this.senderId,
    this.receiverID,
    this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json){
    text = json['text'];
    senderId = json['senderId'];
    receiverID = json['receiverID'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverID': receiverID,
      'dateTime': dateTime,
    };
  }
}