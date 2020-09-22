import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class User {
  final String id;
  final String profileName;
  final String username;
  final String url;
  final String email;
  final String bio;
  final String subject1;
  final String subject2;
  final String subject3;
  final String subject4;
  final String subject5;
  final String timing1;
  final String timing2;
  final String timing3;
  final String timing4;
  final String timing5;
  final String room1;
  final String room2;
  final String room3;
  final String room4;
  final String room5;

  User({
    this.id,
    this.profileName,
    this.username,
    this.url,
    this.email,
    this.bio,
    this.subject1,
    this.subject2,
    this.subject3,
    this.subject4,
    this.subject5,
    this.timing1,
    this.timing2,
    this.timing3,
    this.timing4,
    this.timing5,
    this.room1,
    this.room2,
    this.room3,
    this.room4,
    this.room5,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      email: doc['email'],
      username: doc['username'],
      url: doc['url'],
      profileName: doc['profileName'],
      bio: doc['bio'],
      subject1: doc['subject1'],
      subject2: doc['subject2'],
      subject3: doc['subject3'],
      subject4: doc['subject4'],
      subject5: doc['subject5'],
      timing1: doc['timing1'],
      timing2: doc['timing2'],
      timing3: doc['timing3'],
      timing4: doc['timing4'],
      timing5: doc['timing5'],
      room1: doc['room1'],
      room2: doc['room2'],
      room3: doc['room3'],
      room4: doc['room4'],
      room5: doc['room5'],
    );
  }
}