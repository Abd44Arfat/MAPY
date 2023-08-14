import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapy/presentation/login_screen.dart';
import 'package:mapy/presentation/map_screen.dart';
import 'package:mapy/presentation/otp_screen.dart';

import 'business_logic/cubits/maps/maps_cubit.dart';
import 'business_logic/cubits/phoneAuth/phone_auth_cubit.dart';
import 'constants/strings.dart';
import 'data/repository/maps_repo.dart';
import 'data/webservices/places_webservices.dart';


class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MapsCubit(MapsRepository(PlacesWebservices())),
            child: MapScreen(),
          ),
        );

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
    }
  }
}
