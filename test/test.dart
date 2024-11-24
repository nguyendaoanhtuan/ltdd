import '../models/cua_hang.dart';
import '../models/dien_thoai.dart';
import '../models/hoa_don.dart';

void main() {
  // Tạo cửa hàng và điện thoại mẫu
  CuaHang cuaHang = CuaHang("Cửa Hàng Điện Thoại ABC", "123 Đường ABC");

  // Tạo điện thoại mẫu
  DienThoai dienThoai1 = DienThoai("DT-001", "Samsung Galaxy S24", "Samsung", 15000, 20000, 50, true);
  DienThoai dienThoai2 = DienThoai("DT-002", "iPhone 15", "Apple", 20000, 25000, 30, true);

  // 1. Thêm điện thoại mới
  cuaHang.themDienThoai(dienThoai1);
  cuaHang.themDienThoai(dienThoai2);
  
  // Kiểm tra thêm điện thoại
  cuaHang.hienThiDanhSachDienThoai();
  print("Test Thêm điện thoại thành công.");

  // 2. Cập nhật thông tin điện thoại
  dienThoai1.tenDienThoai = "Samsung Galaxy S24 Ultra";
  cuaHang.capNhatDienThoai(dienThoai1);
  
  // Kiểm tra cập nhật điện thoại
  cuaHang.hienThiDanhSachDienThoai();
  print("Test Cập nhật điện thoại thành công.");

  // 3. Kiểm tra validation khi thêm điện thoại
  try {
    DienThoai dienThoaiSai = DienThoai("DT03", "Huawei P50", "Huawei", 20000, 25000, 10, true);
    cuaHang.themDienThoai(dienThoaiSai);  // Giá nhập âm là không hợp lệ
    print("Test Validation điện thoại không thành công.");
  } catch (e) {
    print("Test Validation điện thoại thành công.");
  }

  // 4. Tạo hóa đơn hợp lệ
  HoaDon hoaDon1 = HoaDon("HD001", DateTime.now(), dienThoai1, 2, 20000, "Nguyễn Văn A", "0987654321");
  cuaHang.taoHoaDon(hoaDon1);
  
  // Kiểm tra tạo hóa đơn
  cuaHang.hienThiDanhSachHoaDon();
  print("Test Tạo hóa đơn thành công.");

  // 5. Kiểm tra tạo hóa đơn với số lượng vượt quá tồn kho
  try {
    HoaDon hoaDonSai = HoaDon("HD002", DateTime.now(), dienThoai2, 40, 25000, "Nguyễn Văn B", "0987654322");
    cuaHang.taoHoaDon(hoaDonSai);  // Số lượng mua vượt quá tồn kho
    print("Test Validation hóa đơn không thành công.");
  } catch (e) {
    print("Test Validation hóa đơn thành công.");
  }

  // 6. Kiểm tra tính toán tổng tiền và lợi nhuận trong hóa đơn
  print("Tổng tiền hóa đơn 1: ${hoaDon1.tinhTongTien()}");
  print("Lợi nhuận thực tế hóa đơn 1: ${hoaDon1.tinhLoiNhuanThucTe()}");

  // 7. Kiểm tra thống kê doanh thu theo khoảng thời gian
  double doanhThu = cuaHang.tongDoanhThu(DateTime(2024, 11, 1), DateTime.now());
  print("Doanh thu theo khoảng thời gian: $doanhThu");

  // 8. Kiểm tra thống kê lợi nhuận theo khoảng thời gian
  double loiNhuan = cuaHang.tongLoiNhuan(DateTime(2024, 11, 1), DateTime.now());
  print("Lợi nhuận theo khoảng thời gian: $loiNhuan");

  // 9. Kiểm tra top điện thoại bán chạy
  List<DienThoai> topDienThoai = cuaHang.topDienThoaiBanChay();
  print("Top điện thoại bán chạy:");
  for (var dt in topDienThoai) {
    print(dt.tenDienThoai);
  }

  // 10. Kiểm tra báo cáo tồn kho
  Map<String, int> tonKho = cuaHang.thongKeTonKho();
  print("Báo cáo tồn kho:");
  tonKho.forEach((key, value) {
    print("Tên điện thoại: $key, Số lượng tồn kho: $value");
  });
}
