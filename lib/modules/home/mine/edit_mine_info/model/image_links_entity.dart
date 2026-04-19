import 'package:youth/generated/json/succeed/image_links_entity.g.dart';
import 'dart:convert';
import 'package:youth/utils/extension/maps/maps.dart';
export 'package:youth/generated/json/succeed/image_links_entity.g.dart';

class ImageLinksEntity {
	String? url;
	String? key;

	ImageLinksEntity();

	factory ImageLinksEntity.fromJson(dynamic json) {
		if (Maps.isNotEmpty(json)) {
			return $ImageLinksEntityFromJson(json);
		}
		return ImageLinksEntity();
	}

	Map<String, dynamic> toJson() => $ImageLinksEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}