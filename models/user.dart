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
  final String timing11;
  final String timing22;
  final String timing33;
  final String timing44;
  final String timing55;
  final String room11;
  final String room22;
  final String room33;
  final String room44;
  final String room55;
  final int day1;
  final int day2;
  final int day3;
  final int day4;
  final int day5;
  final int day11;
  final int day22;
  final int day33;
  final int day44;
  final int day55;

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
    this.timing11,
    this.timing22,
    this.timing33,
    this.timing44,
    this.timing55,
    this.room11,
    this.room22,
    this.room33,
    this.room44,
    this.room55,
    this.day1,
    this.day2,
    this.day3,
    this.day4,
    this.day5,
    this.day11,
    this.day22,
    this.day33,
    this.day44,
    this.day55,
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
      timing11: doc['timing11'],
      timing22: doc['timing22'],
      timing33: doc['timing33'],
      timing44: doc['timing44'],
      timing55: doc['timing55'],
      room11: doc['room11'],
      room22: doc['room22'],
      room33: doc['room33'],
      room44: doc['room44'],
      room55: doc['room55'],
      day1: doc['day1'],
      day2: doc['day2'],
      day3: doc['day3'],
      day4: doc['day4'],
      day5: doc['day5'],
      day11: doc['day11'],
      day22: doc['day22'],
      day33: doc['day33'],
      day44: doc['day44'],
      day55: doc['day55'],
    );

  }
}