import 'package:intl/intl.dart';

import '../i18n.dart';

extension I18nDateTimeExtentions on I18n {
  String formatDate(DateTime dateTime) => DateFormat.yMd().format(dateTime);

  String formatHours(DateTime dateTime) => DateFormat.Hm().format(dateTime);
}
