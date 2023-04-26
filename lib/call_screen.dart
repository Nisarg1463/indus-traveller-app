// ignore_for_file: unused_field, prefer_typing_uninitialized_variables

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:indus_traveller/backend.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  final channel;
  final username;
  const CallScreen(this.channel, this.username, {Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _joined = false;
  int _remoteUid = 0;

  late RtcEngine engine;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Get microphone permission
    await [Permission.microphone, Permission.bluetoothConnect].request();

    // Create RTC client instance
    RtcEngineContext context =
        RtcEngineContext('a2c04255fbe0486dabf46a35c3c328da');
    engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel $uid');
          setState(
            () {
              _joined = true;
            },
          );
        },
        userJoined: (int uid, int elapsed) {
          print('userJoined $uid');
          setState(
            () {
              _remoteUid = uid;
            },
          );
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline $uid');
          setState(
            () {
              _remoteUid = 0;
            },
          );
        },
      ),
    );
    String token = await generateToken(widget.username, widget.channel);
    if (token == 'error') {
      endCall();
      return;
    }
    print(token);
    await engine.joinChannel(token, widget.channel, null, 0);
  }

  void endCall() {
    print('ended');
    engine.leaveChannel();
    leaveChannel(widget.username, widget.channel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(
                Icons.call_end,
                color: Colors.red,
              ),
              onPressed: () {
                endCall();
              },
            ),
          )
        ],
      ),
    );
  }
}
