import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import 'api/hardwareAndSoftwareInfo.dart';
import 'api/ipAddress.dart';
import 'memory/memory.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _control;
  DeviceBattery dbattery = DeviceBattery();

  Map<String, dynamic> map = {};
  String phone = "";
  String ipAddr = "";
  String opS = "";
  String resolut = "";
  String vers = "";
  String hardware = "";
  String droid = "";
  dynamic memoryAndroid = "";


  @override
  void dispose() {
    super.dispose();
    _control.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();

    _control = AnimationController(
      duration: const Duration(
        seconds: 4,
      ),
      vsync: this,
    )..repeat(reverse: false);
  }

  Future init() async {
    final netInfo = await Ipaddress.getIP();
    final device = await HardSoftWare.getDeviceManuf();
    final os = await HardSoftWare.retrieveOS();
    final pVersion = await HardSoftWare.getDeviceVersion();
    final resol = await HardSoftWare.retrieveResolution();
    final hdwre = await HardSoftWare.androidHardWare();
    final android = await HardSoftWare.retrieveAndroidId();
    final droid = await HardSoftWare.getDroidDetails();

    if (!mounted) return;
    setState(() {
      map = {
        "WIFI-IP": netInfo,
        "phone": device,
        "os": os,
        "pVersion": pVersion,
        "resolution": resol,
        "hardware": hdwre,
        "droid": android,
      };
    });
    phoneDetails();
  }

  void phoneDetails() {
    for (var val in map.keys) {
      switch (val) {
        case "WIFI-IP":
          {
            ipAddr = map[val];

            break;
          }
        case "phone":
          {
            phone = map[val];
            break;
          }
        case "os":
          {
            opS = map[val];
            break;
          }
        case "pVersion":
          {
            vers = map[val];
            break;
          }
        case "resolution":
          {
            resolut = map[val];
            break;
          }
        case "hardware":
          {
            hardware = map[val];
            break;
          }
        case "droid":
          {
            droid = map[val];
            break;
          }
        case "battery":
          {
            memoryAndroid = map[val];
            break;
          }

        default:
          {
            log(val + " key not found...");
          }
      }
    }
  }

  late final Animation<double> _animation =
      CurvedAnimation(parent: _control, curve: Curves.easeOutSine);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white70,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 48),
                Text("ASSESS ANDROID 📱",style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 29)),

                const SizedBox(height: 100),
                Center(
                  child: WidgetCircularAnimator(
                    size: 250,
                    innerIconsSize: 10,
                    outerIconsSize: 10,
                    innerAnimation: Curves.linear,
                    outerAnimation: Curves.easeInOutBack,
                    innerColor: Colors.white,
                    outerColor: Colors.blue,
                    innerAnimationSeconds: 5,
                    outerAnimationSeconds: 10,
                    child: Container(
                      decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                      child: Image.asset(
                        'assets/aimob.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 800,
                  child: Card(
                    color: Colors.green.shade300,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          height: 62,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 83,
                              ),
                              Center(
                                  child: Text(
                                " DEVICE - INFORMATION",
                                style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 19),
                              ))
                            ],
                          ),
                        ),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "IP-ADDRESS:",
                              style: GoogleFonts.pressStart2p(fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            width: 23,
                          ),
                          Center(
                              child: Text(
                            ipAddr,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.orbitron(
                                fontWeight: FontWeight.bold),
                          ))
                        ]),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("PHONE:",
                                  style:
                                      GoogleFonts.pressStart2p(fontSize: 12)),
                            ),
                            const SizedBox(
                              width: 99,
                            ),
                            Text(
                              phone,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900),
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("RESOLUTION:",
                                  style:
                                      GoogleFonts.pressStart2p(fontSize: 12)),
                            ),
                            const SizedBox(
                              width: 37,
                            ),
                            Text(
                              resolut,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("PHONE VERSION:",
                                  style:
                                      GoogleFonts.pressStart2p(fontSize: 12)),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Text(
                              vers,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow),
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("OPERATING SYSTEM:",
                                  style:
                                      GoogleFonts.pressStart2p(fontSize: 12)),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Text(
                              opS,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade900),
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("HARDWARE:",
                                    style:
                                        GoogleFonts.pressStart2p(fontSize: 12)),
                              ),
                              const SizedBox(
                                width: 103,
                              ),
                              SizedBox(
                                  width: 104,
                                  child: Text(
                                    hardware,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.orbitron(
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("ANDROID-ID: ",
                                  style:
                                      GoogleFonts.pressStart2p(fontSize: 12)),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Center(
                                child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      droid,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.orbitron(
                                          fontWeight: FontWeight.bold),
                                    )))
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(height: 23),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 22,
                            color: Colors.black,
                            child: Center(
                                child: Text("MEMORY - INFO",
                                    style: GoogleFonts.pressStart2p(
                                        fontSize: 12, color: Colors.white)))),
                        const SizedBox(height: 33),
                        Stack(children: [
                          Card(
                            child: RotationTransition(
                              turns: _animation,
                              child: Container(
                                height: 229,
                                width: 328,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/memo.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          dbattery,
                          Text(memoryAndroid.toString())
                        ]),
                        const SizedBox(height: 33),
                        Container(
                          color: Colors.black,
                          height: 62,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 83,
                              ),
                              Center(
                                  child: Text(
                                "DEVICE FEATURES",
                                style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 19),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 33),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            HardSoftWare.getMap()
                                .toString()
                                .replaceAll("{", "")
                                .replaceAll("}", "")
                                .replaceAll(",", ",\n\n")
                                .replaceAll(":", "  :: -->  "),
                            style: GoogleFonts.orbitron(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.blue.shade900),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 622,
                            height: 41,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),

                            child: OutlineButton(
                             color: Colors.yellow,
                              shape: const StadiumBorder(),
                              highlightedBorderColor: Colors.lightGreenAccent,
                              borderSide: const BorderSide(
                                  width: 8,
                                  color: Colors.blue,
                              ),
                              onPressed: ()async {
                               const myUrl='https://paypal.me/appDevChris?country.x=US&locale.x=en_US';
                               if(await canLaunch(myUrl)) {
                                 await launch(myUrl,forceSafariVC: true,forceWebView: true,enableJavaScript: true);
                               }
                              },
                              child: Text('🙂TAP TO Donate to AppDevChris here! ☕',style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green.shade900)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 59),
                 Text("THANK YOU! 🙏",style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 19)),
                const SizedBox(height: 12),

                Center(
                  child: WidgetCircularAnimator(
                    size: 250,
                    innerIconsSize: 10,
                    outerIconsSize: 10,
                    innerAnimation: Curves.linear,
                    outerAnimation: Curves.easeInOutBack,
                    innerColor: Colors.white,
                    outerColor: Colors.blue.shade900,
                    innerAnimationSeconds: 5,
                    outerAnimationSeconds: 10,
                    child: Container(
                      decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade900),
                      child: Image.asset(
                        'assets/aimob.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 59),
              ],
            ),
          ),
        ));
  }
}
