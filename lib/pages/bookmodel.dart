import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String author;
  String author2;
  String author3;
  String author4;
  String image;
  String image2;
  String image3;
  String image4;
  // String text;
  String judul;
  String judul2;
  String judul3;
  String judul4;
  String halaman;
  String halaman2;
  String halaman3;
  String halaman4;
  // String yt;
  // String baner;
  // double rating;
  // int startColor;
  // int endColor;

  Book({
    required this.image,
    required this.image2,
    required this.image3,
    required this.image4,
    // required this.text,
    required this.judul,
    required this.judul2,
    required this.judul3,
    required this.judul4,
    required this.author,
    required this.author2,
    required this.author3,
    required this.author4,
    required this.halaman,
    required this.halaman2,
    required this.halaman3,
    required this.halaman4,
    // required this.rating,
    // required this.yt,
    // required this.baner,
    // required this.startColor,
    // required this.endColor
  });

  Map<String, dynamic> tojson() {
    return {
      'image': image,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'author': author,
      'author2': author2,
      'author3': author3,
      'author4': author4,
      // 'text': text,
      'judul': judul,
      'judul2': judul2,
      'judul3': judul3,
      'judul4': judul4,
      'halaman': halaman,
      'halaman2': halaman2,
      'halaman3': halaman3,
      'halaman4': halaman4,
      // 'star': rating,
      // 'yt': yt,
      // 'baner': baner,
      // 'startColor': startColor,
      // 'endColor': endColor,
    };
  }

  factory Book.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Book(
      image: json['image'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      // text: json['text'],
      judul: json['judul'],
      judul2: json['judul2'],
      judul3: json['judul3'],
      judul4: json['judul4'],
      author: json['author'],
      author2: json['author2'],
      author3: json['author3'],
      author4: json['author4'],
      halaman: json['halaman'],
      halaman2: json['halaman2'],
      halaman3: json['halaman3'],
      halaman4: json['halaman4'],
      // rating: json['rating'],
      // yt: json['yt'],
      // baner: json['baner'],
      // startColor: json['startColor'],
      // endColor: json['endColor']
    );
  }
}
