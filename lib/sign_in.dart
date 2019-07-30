import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';




String userName;
String imageUrl;
String userID;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();
  

  AuthService() {
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> getCurrentUser() async {
    return _auth.currentUser();
  }



  Future<FirebaseUser> signInWithGoogle() async {
    loading.add(true);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    
    
    userName = user.displayName;
    imageUrl = user.photoUrl;
    userID = user.uid;

    if (userName.contains(" ")) {
    userName = userName.substring(0, userName.indexOf(" "));
  }

 
    updateUserData(user);
    loading.add(false);

    return user;
    /*  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  name = user.displayName;
  email = user.email;
  

  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user'; */
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastseen': DateTime.now(),
    }, merge: true);
  }
  void signOutGoogle() async {
    await googleSignIn.signOut();
    
    print("User Sign Out");
  }
}

final AuthService authService = AuthService();
