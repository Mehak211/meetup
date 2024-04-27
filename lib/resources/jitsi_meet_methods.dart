import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/resources/firestore_methods.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final tokenText = TextEditingController();
  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;

  void createMeeting({
    required String roomName,
    //required String token,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      // token = '1234';
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      Map<String, Object> featureFlags = {};
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: name,
        userEmail: _authMethods.user.email,
        userAvatarUrl: _authMethods.user.photoURL,
        serverUrl: "https://easyconference.uibk.ac.at",

        //token: token,
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
        },
        featureFlags: featureFlags,
      );
      var listeners = JitsiMeetingListener(
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      );

      await JitsiMeetWrapper.joinMeeting(options: options, listener: listeners);
      _firestoreMethods.addToMeetingHistory(roomName);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
