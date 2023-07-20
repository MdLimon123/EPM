
import 'package:epm/Routes/routes.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


void main() async{
   await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(430, 932));
    return GetMaterialApp(
      title: 'EPM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: getPage,
      initialRoute: Routes.loginScreen,
  
    );
  }
}

