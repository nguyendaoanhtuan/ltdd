import 'dart:io';

void main(){
  //Khai bao bien co ban
  var ten = 'Tung'; // tu suy luan
  int tuoi = 25; // khai bao ro rang

  //Su dung null safety
  String? tenNullable;
  tenNullable = null;

  //su dung bien late
  late String moTa;
  moTa = 'Lap trinh dart';

  // su dung final va const
  final String quocGia = 'VienNam';
  const int nam = 2024;

  //In gia tri biem
  print('Ten: $ten');
  print('Tuoi: $tuoi');
  print('Mo Ta: $moTa');
  print('Quoc Gia: $quocGia');
  print('Nam: $nam');

  //Kiem tra bien nullable
  int? soLuong;
  assert (soLuong == null);
}