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
    try {
      final _message = await teledart.telegram
          .sendMessage(InfoValues.TELEGRAM_CHANNEL, message);

      if (_message != null && _message.date_.day == DateTime.now().day) {
        print('Send Telegram message');
        return;
      }
      print('Telegram message empty');
    } catch (e) {
      print('Error to send Telegram message: $e');
    }
  }
}
