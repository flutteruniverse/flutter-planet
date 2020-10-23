import 'package:notifications/services/rss_service.dart';
import 'package:notifications/services/telegram_service.dart';

void main(List<String> arguments) async {
  final rssService = RssService();
  final telegramService = TelegramService();
  await telegramService.initBot();
}
