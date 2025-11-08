import 'package:edc_v2/core/di/get_it.dart';
import 'package:edc_v2/core/router/app_router.dart';
import 'package:edc_v2/core/theme/app_theme.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_bloc.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_event.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_state.dart';
import 'package:edc_v2/features/auth/presentation/page/auth_page.dart';
import 'package:edc_v2/features/history/presentation/bloc/history_bloc.dart';
import 'package:edc_v2/features/history/presentation/bloc/history_event.dart';
import 'package:edc_v2/features/main/presentation/bloc/main_bloc.dart';
import 'package:edc_v2/features/main/presentation/bloc/payment_bloc.dart';
import 'package:edc_v2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
        getIt<UserBloc>()
          ..add(GetUserEvent()),
      ),
      BlocProvider(
        create: (context) => getIt<MainBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<PaymentBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<HistoryBloc>()..add(LoadDonationsEvent(refresh: true)),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      builder: (context, widget) {
        return BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state.status == UserStatus.error ||
              state.status == UserStatus.logOut) {
            AppRouter.router.go(AuthPage.path);
          }
        }, child: widget,);
      },
      theme: AppTheme.getTheme(),
    ),
  ));
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   setup();
//   runApp(MultiBlocProvider(
//         providers: [
//           BlocProvider(
//         create: (context) => 
//         getIt<UserBloc>()
//         ..add(GetUserEvent()),
//           ),
//           BlocProvider(
//             create: (content) => getIt<MainBloc>(),
//             ),
//         ],
//         child: MaterialApp.router(
//           // ignore: deprecated_member_use
//           useInheritedMediaQuery: true,
//           routerConfig: AppRouter.router,
//           builder: (context, widget) {
//         return BlocListener<UserBloc, UserState>(
//           listener: (context, state) {
//             if (state.status == UserStatus.error || 
//             state.status == UserStatus.logOut) {
//           AppRouter.router.go(AuthPage.path);
//             }
//           },
//           child: widget!,
//         );
//           },
//           theme: AppTheme.getTheme(),
//         ),
//       ),
//     );
// }

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   setup();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(
//     DevicePreview(
//       builder: (context) => 
//         BlocProvider(
//           create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
//           child: MaterialApp.router(
//             // ignore: deprecated_member_use
//             useInheritedMediaQuery: true, 
//             routerConfig: AppRouter.router,
//             theme: AppTheme.getTheme(),
//           ),
//         ),
//     ),
//   );
// }




// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   setup();
//   runApp(BlocProvider(
//           create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
//           child: MaterialApp.router(
//             routerConfig: AppRouter.router,
//             theme: AppTheme.getTheme(),
//           ),
//         ),
//     );
// }


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   setup();
//   runApp(
//     BlocProvider(
//       create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
//       child: MaterialApp.router(
//         routerConfig: AppRouter.router,
//         builder: (context, widget) {
//           return BlocListener<UserBloc, UserState>(
//             listener: (context, state) {
//               if (state.status == UserStatus.error || state.status == UserStatus.logOut){
//                 AppRouter.router.go(AuthPage.path);
//               }
//             },
//             child: widget ?? const SizedBox.shrink(),
//           );
//         },
//         theme: AppTheme.getTheme(),
//       ),
//     ),
//   );
// }

