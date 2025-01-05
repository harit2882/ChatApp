enum MessageStatus {
  not('not'),
  sent('sent'),
  received('received'),
  seen('seen');

  const MessageStatus(this.type);

  final String type;
}

extension ConvertMsgStatus on String {
  MessageStatus toEnumStatus() {
    switch (this) {
      case 'not':
        return MessageStatus.not;
      case 'sent':
        return MessageStatus.sent;
      case 'received':
        return MessageStatus.received;
      case 'seen':
        return MessageStatus.seen;
      default:
        return MessageStatus.not;
    }
  }
}

// enum MessageStatus{
//
//   not,sent,received,seen;
//
// }