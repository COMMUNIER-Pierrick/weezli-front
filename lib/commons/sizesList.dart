import 'package:weezli/model/PackageSize.dart';

String? sizesList(List<PackageSize> list) {
  String? sizes;
  for (PackageSize size in list) {
    if (sizes != null)
      sizes = sizes + ", " + size.name;
    else
      sizes = size.name;
  }
  return sizes;
}
