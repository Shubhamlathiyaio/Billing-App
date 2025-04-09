import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:number_to_words/number_to_words.dart';

String perOf(double per, double amount) => ((per / 100) * amount).toStringAsFixed(2);

double rxStringToDouble(RxString value) {
  return double.tryParse(value.value) ?? 0.0;
}

String getAmountInWords(int amount) {
  return '${NumberToWord().convert('en-in', amount).toUpperCase()} ONLY';
}