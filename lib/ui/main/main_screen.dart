import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_test/bloc/main/main_cubit.dart';
import 'package:olearis_test/extensions.dart';
import 'package:olearis_test/ui/login/login_screen.dart';

const logoWidth = 360;
const minLogoAspectRation = 9 / 4;
const logoMargin = 20.0;
const cellAspectRatio = 5 / 1;
const cellPadding = 8.0;
const gridDimension = 2;
const logoCornerRadius = BorderRadius.all(Radius.circular(20.0));
const totalPaddings = cellPadding * (gridDimension + 1);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: const MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  const MainScreenContent({super.key});

  List<Widget> generateCells(int size, BuildContext context) {
    return List.generate(
      size,
      (i) => DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(
          child: Text("Item $i", style: context.styles.titleLarge),
        ),
      ),
    );
  }

  double calculateLogoHeight(
    int size,
    double maxWidth,
    double maxHeight,
    BuildContext context,
  ) {
    final gridHeight = (size / 2).ceil() *
        ((maxWidth - totalPaddings) / cellAspectRatio / 2 + cellPadding);

    final fullLogoWidth = min(logoWidth, context.screenWidth) + logoMargin * 2;
    final minLogoSize = fullLogoWidth / minLogoAspectRation;

    return max(minLogoSize, maxHeight - gridHeight);
  }

  void navigateBack(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateBack(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Markup Test'),
          leading: BackButton(
            onPressed: () => navigateBack(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => context.read<MainCubit>().remove(),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.read<MainCubit>().add(),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<MainCubit, int>(
            builder: (context, count) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: calculateLogoHeight(
                            count,
                            constraints.maxWidth,
                            constraints.maxHeight,
                            context,
                          ),
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: logoMargin,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: logoCornerRadius,
                              ),
                              child: const ClipRRect(
                                borderRadius: logoCornerRadius,
                                child: Image(
                                  image: AssetImage('images/logo.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: cellPadding,
                          ),
                          crossAxisCount: gridDimension,
                          crossAxisSpacing: cellPadding,
                          mainAxisSpacing: cellPadding,
                          childAspectRatio: cellAspectRatio,
                          children: generateCells(count, context),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
