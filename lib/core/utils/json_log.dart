import 'dart:convert';
import 'dart:developer';

void jsonLog(dynamic object) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyString = encoder.convert(object);
  log(prettyString);
}
// For Converting Model Objects to Json String