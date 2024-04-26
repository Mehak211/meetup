import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/resources/firestore_methods.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  List<String> participants = [];
  final _jitsiMeetPlugin = JitsiMeet();
  bool audioMuted = true;
  bool videoMuted = true;
  bool screenShareOn = false;

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": false,
          "startWithVideoMuted": false,
        },
        featureFlags: {
          FeatureFlags.addPeopleEnabled: true,
          FeatureFlags.welcomePageEnabled: true,
          FeatureFlags.preJoinPageEnabled: true,
          FeatureFlags.resolution: FeatureFlagVideoResolutions.resolution720p,
          FeatureFlags.audioMuteButtonEnabled: true,
          FeatureFlags.audioOnlyButtonEnabled: true,
          FeatureFlags.calenderEnabled: true,
          FeatureFlags.callIntegrationEnabled: true,
          FeatureFlags.carModeEnabled: true,
          FeatureFlags.closeCaptionsEnabled: true,
          FeatureFlags.conferenceTimerEnabled: true,
          FeatureFlags.chatEnabled: true,
          FeatureFlags.filmstripEnabled: true,
          FeatureFlags.fullScreenEnabled: true,
          FeatureFlags.helpButtonEnabled: true,
          FeatureFlags.inviteEnabled: true,
          FeatureFlags.androidScreenSharingEnabled: true,
          FeatureFlags.speakerStatsEnabled: true,
          FeatureFlags.kickOutEnabled: true,
          FeatureFlags.liveStreamingEnabled: true,
          FeatureFlags.lobbyModeEnabled: true,
          FeatureFlags.meetingNameEnabled: true,
          FeatureFlags.meetingPasswordEnabled: true,
          FeatureFlags.notificationEnabled: true,
          FeatureFlags.overflowMenuEnabled: true,
          FeatureFlags.pipEnabled: true,
          FeatureFlags.pipWhileScreenSharingEnabled: true,
          FeatureFlags.preJoinPageHideDisplayName: true,
          FeatureFlags.raiseHandEnabled: true,
          FeatureFlags.reactionsEnabled: true,
          FeatureFlags.recordingEnabled: true,
          FeatureFlags.replaceParticipant: true,
          FeatureFlags.securityOptionEnabled: true,
          FeatureFlags.serverUrlChangeEnabled: true,
          FeatureFlags.settingsEnabled: true,
          FeatureFlags.tileViewEnabled: true,
          FeatureFlags.videoMuteEnabled: true,
          FeatureFlags.videoShareEnabled: true,
          FeatureFlags.toolboxEnabled: true,
        },
        userInfo: JitsiMeetUserInfo(
            displayName: name,
            email: _authMethods.user.email,
            avatar: _authMethods.user.photoURL),
      );

      await _jitsiMeetPlugin.join(options);
      _firestoreMethods.addToMeetingHistory(roomName);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
