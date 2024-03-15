// To parse this JSON data, do
//
//     final commentaires = commentairesFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'Commentaires.g.dart';

Commentaires commentairesFromJson(String str) => Commentaires.fromJson(json.decode(str));

String commentairesToJson(Commentaires commentaires) => json.encode(commentaires.toJson());

class CommentairesModel {
    Commentaires commentaires;

    CommentairesModel({
        required this.commentaires,
    });

    factory CommentairesModel.fromJson(Map<String, dynamic> json) => CommentairesModel(
        commentaires: Commentaires.fromJson(json["commentaires"]),
    );

    Map<String, dynamic> toJson() => {
        "commentaires": commentaires.toJson(),
    };
}

@JsonSerializable()
class Commentaires {
    String? content;
    String? repasId;

    Commentaires({
        this.content,
        this.repasId,
    });

    factory Commentaires.fromJson(Map<String, dynamic> json) => _$CommentairesFromJson(json);

    Map<String, dynamic> toJson() => _$CommentairesToJson(this);
}
