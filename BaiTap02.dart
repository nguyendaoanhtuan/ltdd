//BaiTap02.dart
// Giai pt bac 2 : ax^2+bx+c = 0;

import 'dart:io';
import 'dart:math';

void main() {
  double? a, b, c;
   // Nhập hệ số a
  do {
    stdout.write('Nhập hệ số a (a != 0): ');
    String? input = stdin.readLineSync();
    a = input != null ? double.tryParse(input) : null;

    if (a == null || a == 0) {
      print('Dữ liệu không hợp lệ! Hệ số a phải là số khác 0.');
    }
  } while (a == null || a == 0);

  // Nhập hệ số b
  do {
    stdout.write('Nhập hệ số b: ');
    String? input = stdin.readLineSync();
    b = input != null ? double.tryParse(input) : null;

    if (b == null) {
      print('Dữ liệu không hợp lệ! Hệ số b phải là số.');
    }
  } while (b == null);

  // Nhập hệ số c
  do {
    stdout.write('Nhập hệ số c: ');
    String? input = stdin.readLineSync();
    c = input != null ? double.tryParse(input) : null;

    if (c == null) {
      print('Dữ liệu không hợp lệ! Hệ số c phải là số.');
    }
  } while (c == null);


  // Tính toán nghiệm phương trình bậc hai
  giaiPhuongTrinhBacHai(a!, b!, c!);
}



// Hàm giải phương trình bậc hai
void giaiPhuongTrinhBacHai(double a, double b, double c) {
  double delta = b * b - 4 * a * c;

  if (delta > 0) {
    double x1 = (-b + sqrt(delta)) / (2 * a);
    double x2 = (-b - sqrt(delta)) / (2 * a);
    print("Phường trình có dạng: $a^2x+$b x+ $c");
    print("Phương trình có hai nghiệm phân biệt:");
    print("x1 = $x1");
    print("x2 = $x2");
  } else if (delta == 0) {
    double x = -b / (2 * a);
    print("Phương trình có nghiệm kép: x = $x");
  } else {
    print("Phương trình vô nghiệm (delta < 0).");
  }
}
