import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui';

backdropFilter(context) {
  return Center(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 3),
        child: Stack(
          children: [
             Center(
              child: SpinKitCircle(color: Colors.black),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0),
            ),
          ],
        ),
      ),
    ),
  );
}