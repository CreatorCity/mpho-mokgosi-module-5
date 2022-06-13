import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_edit.dart';

void main() {
  runApp(const dashboard());
}

class dashboard extends StatelessWidget {
  const dashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MyHomeScreenState(),
    );
  }
}

class _MyHomeScreenState extends StatefulWidget {
  const _MyHomeScreenState({Key? key}) : super(key: key);

  @override
  State<_MyHomeScreenState> createState() => _MyHomeScreenStates();
}

class _MyHomeScreenStates extends State<_MyHomeScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(children: const [
            Icon(
              Icons.menu,
              size: 25.0,
              color: Colors.white,
            )
          ]),
          actions: const [
            Icon(
              Icons.map,
              size: 25.0,
              color: Colors.white,
            ),
            SizedBox(width: 20.0),
            Icon(
              Icons.phone,
              size: 25.0,
              color: Colors.white,
            ),
            SizedBox(width: 20.0),
            Icon(
              Icons.person,
              size: 25.0,
              color: Colors.white,
            ),
            
            SizedBox(
              width: 10.0,
            ),
          ],
          
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 15.0, 15.0, 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.timelapse,
                                          size: 25.0,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          'View your Vouchers',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 25.0,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              )
                              
                              ),
                              
                        ),
                        const SizedBox(
                          height: 20.0,

                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                      
                    ),
                     
                    )
                    )
                    )
                    
                    );
                    
  }
}
