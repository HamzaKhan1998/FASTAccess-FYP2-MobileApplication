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
    this.subject5
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
    );
  }
}