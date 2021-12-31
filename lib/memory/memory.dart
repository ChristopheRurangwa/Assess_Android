import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_info/memory_info.dart';

class DeviceBattery extends StatefulWidget {
  @override
  _DeviceBatteryState createState() => _DeviceBatteryState();
}

class _DeviceBatteryState extends State<DeviceBattery> {
  Memory? _mem;
  DiskSpace? _diskSpac;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    retrieveMemoryInfo();
  }

  retrieveMemoryInfo() async {
    Memory? memo;
    DiskSpace? disk;
    try {
      memo = await MemoryInfoPlugin().memoryInfo;
      disk = await MemoryInfoPlugin().diskSpace;
    } on PlatformException catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    if (memo != null || disk != null) {
      setState(() {
        _mem = memo;
        _diskSpac = disk;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = const JsonEncoder.withIndent(' ');
    String memory = encoder.convert(_mem?.toMap());
    String diskDat = encoder.convert(_diskSpac?.toMap());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "Memory Status: " +
                  memory.toString().replaceAll("{", "").replaceAll("}", "") +
                  "",
              style: GoogleFonts.orbitron(
                  fontWeight: FontWeight.bold, color: Colors.redAccent.shade700)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "Device disk:" +
                  diskDat.toString().replaceAll("{", "").replaceAll("}", ""),
              style: GoogleFonts.orbitron(
                  fontWeight: FontWeight.bold, color: Colors.redAccent.shade700)),
        )
      ],
    );
  }
}
