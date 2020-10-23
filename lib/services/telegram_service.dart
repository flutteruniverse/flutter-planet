import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'secret_service.dart';

class TelegramService {
  final TeleDart teledart =
      TeleDart(Telegram(SecretService.flavorService.telegramApiKey), Event());
  Future<void> initBot() async {
    await teledart.start();
  }

  Future<void> sendMessage() async {
    await teledart.telegram.sendMessage('@universoflutter', 'Test');
  }
}
