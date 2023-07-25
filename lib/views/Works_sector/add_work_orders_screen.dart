import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/custom_button.dart';
import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../widgets/input_decoration.dart';

class AddWorkOrderScreen extends StatefulWidget {
  AddWorkOrderScreen({super.key});

  @override
  State<AddWorkOrderScreen> createState() => _AddWorkOrderScreenState();
}

class _AddWorkOrderScreenState extends State<AddWorkOrderScreen> {
  final TextEditingController _itemController = TextEditingController();

  final TextEditingController _qntController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _comController = TextEditingController();

  final TextEditingController _totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.textColorWhite,
            )),
        backgroundColor: AppColor.bgColor,
        title: Text(
          'Add Work List',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Constractor Estimation',
                style: CustomTextStyle.h2(
                    color: AppColor.deepOrange, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Item Description'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _itemController,
                hintText: 'Item name',
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Qty'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _qntController,
                hintText: 'Quantity',
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Price'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _priceController,
                hintText: 'Price',
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Comment'),
              SizedBox(
                height: 5.h,
              ),

              TextFormField(
                 maxLines: 4,
                controller: _comController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    fillColor: AppColor.textColor.withOpacity(.1),
                    filled: true,
                    hintText: 'comment',
                  

                  
                    hintStyle: CustomTextStyle.h4(
                        color: AppColor.deepOrange.withOpacity(.5)),
                    border: border(false),
                    enabledBorder: border(false),
                    focusedBorder: border(true)),
              ),

       
             SizedBox(
                height: 15.h,
              ),
              _titleText('Total Price'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _totalController,
                hintText: 'Total Price',
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryButton(title: 'Save', onPressed: printOrSaveAsDocument)
            ],
          ),
        ),
      ),
    );
  }

  void printOrSaveAsDocument() async {
    final itemName = _itemController.text;
    final qntText = _qntController.text;
    final priceText = _priceController.text;
    final comText = _comController.text;
    final totalText = _totalController.text;

    if (itemName.isNotEmpty ||
        qntText.isNotEmpty ||
        priceText.isNotEmpty ||
        comText.isNotEmpty ||
        totalText.isNotEmpty) {
      final pdf = await _generatePdf(
          itemname: itemName,
          quantity: qntText,
          price: priceText,
          comment: comText,
          totalPrice: totalText);

      _printOrSavePdf(pdf);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter text to print or save')));
    }
  }

  Future<pw.Document> _generatePdf(
      {required String itemname,
      required String quantity,
      required String price,
      required String comment,
      required String totalPrice}) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(pw.Page(
      build: (context) {
        return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Estimation # 111',
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 30.sp,
                      color: const PdfColor.fromInt(0xFF000000),
                      fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20.h),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Essential Infotech',
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 28.sp,
                            color: const PdfColor.fromInt(0xFF000000),
                            fontWeight: pw.FontWeight.bold)),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Work Order Info',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 28.sp,
                                  color: const PdfColor.fromInt(0xFF000000),
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('Property: Captain Planet',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 24.sp,
                                  color: const PdfColor.fromInt(0xFF000000),
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('WO # 111',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 28.sp,
                                  color: const PdfColor.fromInt(0xFF000000),
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('Sector 13, Uttara',
                              style: pw.TextStyle(
                                  font: font,
                                  color: const PdfColor.fromInt(0xFF000000),
                                  fontSize: 28.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ])
                  ]),
              pw.SizedBox(height: 20.h),
              pw.Text('Item Description:',
                  style: pw.TextStyle(font: font, fontSize: 24.sp)),
              pw.Text(itemname,
                  style: pw.TextStyle(font: font, fontSize: 20.sp)),
              pw.SizedBox(height: 8.h),
              pw.Text('Quantity:',
                  style: pw.TextStyle(font: font, fontSize: 24.sp)),
              pw.Text(quantity,
                  style: pw.TextStyle(font: font, fontSize: 20.sp)),
              pw.SizedBox(height: 8.h),
              pw.Text('Price:',
                  style: pw.TextStyle(font: font, fontSize: 24.sp)),
              pw.Text(price, style: pw.TextStyle(font: font, fontSize: 20.sp)),
              pw.SizedBox(height: 8.h),
              pw.Text('Comment:',
                  style: pw.TextStyle(font: font, fontSize: 24.sp)),
              pw.Text(comment,
                  style: pw.TextStyle(font: font, fontSize: 20.sp)),
              pw.SizedBox(height: 8.h),
              pw.Text('Total Price:',
                  style: pw.TextStyle(font: font, fontSize: 24.sp)),
              pw.Text(totalPrice,
                  style: pw.TextStyle(font: font, fontSize: 20.sp)),
              pw.SizedBox(height: 20.h),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Thank you!',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 25.sp,
                          color: const PdfColor.fromInt(0xFF000000),
                        )),
                           pw.Text('https://essential-infotech.com',
                        style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 25.sp,
                          color: const PdfColor.fromInt(0xFF000000),
                        )),
                 
                 
                  ])
            ]);
      },
    ));

    return pdf;
  }

  void _printOrSavePdf(pw.Document pdf) async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'fileName.pdf');
  }

  _titleText(String title) {
    return Text(
      title,
      style: CustomTextStyle.h3(color: AppColor.deepOrange.withOpacity(.6)),
    );
  }
}
