import 'package:contactouaty/data/contact_option.dart';

class Contact {
  final int? id;
  final String name;
  final String job;
  final List<ContactOption> contactOptions;

  Contact(this.id, this.name, this.job, this.contactOptions);

  List<Map<String, dynamic>> contactOptionsToMap(
      List<ContactOption> contactOptions) {
    List<Map<String, dynamic>> contactOptionsListMaps =
        List.empty(growable: true);
    for (var option in contactOptions) {
      contactOptionsListMaps.add(option.toMap());
    }
    return contactOptionsListMaps;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'job': job,
      'contactOptions': contactOptionsToMap(contactOptions)
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      'id': id,
      'name': name,
      'job': job,
    };
  }

  factory Contact.fromJson(dynamic json) {
    var contactOptionsObjectsJson = json['contactOptions'] as List;
    List<ContactOption> contactOptionsObjects = contactOptionsObjectsJson
        .map((contactOptionsObject) =>
            ContactOption.fromJson(contactOptionsObject))
        .toList();

    return Contact(json['id'] as int?, json['name'] as String,
        json['job'] as String, contactOptionsObjects);
  }

  factory Contact.fromJson2(dynamic json) {
    return Contact(json['id'] as int?, json['name'] as String,
        json['job'] as String, [ContactOption("name", "url", "image")]);
  }

  @override
  String toString() {
    String stringContactOptions = "";
    for (var element in contactOptions) {
      if (element.url.isNotEmpty) {
        stringContactOptions += "$element,";
      }
    }
    return '{name: $name, job: $job, contactOptions: [ $stringContactOptions]}';
  }
}
