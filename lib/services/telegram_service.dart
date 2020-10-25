import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../config/info_values.dart';
import 'secret_service.dart';

class TelegramService {
  final TeleDart teledart =
      TeleDart(Telegram(SecretService.flavorService.telegramApiKey), Event());
  Future<void> initBot() async {
    await teledart.start();
  }

  /// Send message to Telegram group @universoflutter
  /// with link and title episode
  Future<void> sendMessage(String message) async {
    await teledart.telegram.sendMessage(InfoValues.TELEGRAM_CHANNEL, message);
  }
}
