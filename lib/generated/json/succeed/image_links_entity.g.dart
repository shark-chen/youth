import 'package:youth/generated/json/convert/json_convert_content.dart';
import 'package:youth/modules/home/mine/edit_mine_info/model/image_links_entity.dart';

ImageLinksEntity $ImageLinksEntityFromJson(Map<String, dynamic> json) {
  final ImageLinksEntity imageLinksEntity = ImageLinksEntity();
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    imageLinksEntity.url = url;
  }
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    imageLinksEntity.key = key;
  }
  return imageLinksEntity;
}

Map<String, dynamic> $ImageLinksEntityToJson(ImageLinksEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['url'] = entity.url;
  data['key'] = entity.key;
  return data;
}

extension ImagelinksEntityExtension on ImageLinksEntity {
  ImageLinksEntity copyWith({
    String? url,
    String? key,
  }) {
    return ImageLinksEntity()
      ..url = url ?? this.url
      ..key = key ?? this.key;
  }
}