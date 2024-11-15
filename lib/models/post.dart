import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final date;
  final String profileImg;
  final String postUrl;
  final likes;

  const Post(
      {required this.description,
      required this.uid,
      required this.postId,
      required this.username,
      required this.date,
      required this.profileImg,
      required this.postUrl,
      required this.likes});

  //this function will convert the above arguments to json
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "postId": postId,
        "profileImg": profileImg,
        "description": description,
        "postUrl": postUrl,
        "date": date,
        "likes": likes
      };

  //With this function we're taking in a document snapshot and returning a user model so that we don't have to write snapshot['username'] all the time
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        username: snapshot['username'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        profileImg: snapshot['profileImg'],
        description: snapshot['description'],
        postUrl: snapshot['postUrl'],
        date: snapshot['date'],
        likes: snapshot['likes']);
  }
}
