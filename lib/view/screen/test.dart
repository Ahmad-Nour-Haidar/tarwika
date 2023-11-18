import 'package:flutter/material.dart';
import 'package:tarwika/core/constant/app_image.dart';
import 'package:tarwika/print.dart';

class DetailsProduct extends StatefulWidget {
  const DetailsProduct({super.key});

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        debugPrint(constraints.maxHeight.toString());
        final h = constraints.maxHeight;
        return Scaffold(
          body: Column(
            children: [
              // this = h * .15
              Container(
                padding: const EdgeInsets.only(left: 15, top: 20),
                height: h * .15,
                width: double.infinity,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: const Color(0x002f2f2f),
                        foregroundColor: const Color.fromARGB(255, 52, 53, 53),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              // this =  h * .20
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: (h * .20) - 10,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppImage.logo,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // this = h * .65
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: h * .65 - 10,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
