import '../models/dien_thoai.dart';
import '../models/hoa_don.dart';

class CuaHang {
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  // Constructor
  CuaHang(this._tenCuaHang, this._diaChi);

  // Phương thức thêm điện thoại mới
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
  }

  // Phương thức cập nhật thông tin điện thoại
  void capNhatDienThoai(DienThoai dienThoai) {
    for (var dt in _danhSachDienThoai) {
      if (dt.maDienThoai == dienThoai.maDienThoai) {
        dt.tenDienThoai = dienThoai.tenDienThoai;
        dt.hangSanXuat = dienThoai.hangSanXuat;
        dt.giaNhap = dienThoai.giaNhap;
        dt.giaBan = dienThoai.giaBan;
        dt.soLuongTonKho = dienThoai.soLuongTonKho;
        dt.trangThaiKinhDoanh = dienThoai.trangThaiKinhDoanh;
      }
    }
  }

  // Phương thức ngừng kinh doanh điện thoại
  void ngungKinhDoanh(DienThoai dienThoai) {
    for (var dt in _danhSachDienThoai) {
      if (dt.maDienThoai == dienThoai.maDienThoai) {
        dt.trangThaiKinhDoanh = false;
      }
    }
  }

  // Phương thức tìm kiếm điện thoại theo mã, tên, hãng
  List<DienThoai> timDienThoai({String? maDienThoai, String? tenDienThoai, String? hangSanXuat}) {
    return _danhSachDienThoai.where((dienThoai) {
      bool matchesMa = maDienThoai == null || dienThoai.maDienThoai.contains(maDienThoai);
      bool matchesTen = tenDienThoai == null || dienThoai.tenDienThoai.contains(tenDienThoai);
      bool matchesHang = hangSanXuat == null || dienThoai.hangSanXuat.contains(hangSanXuat);
      return matchesMa && matchesTen && matchesHang;
    }).toList();
  }
  // Phương thức hiển thị danh sách hóa đơn
// Phương thức hiển thị danh sách điện thoại
void hienThiDanhSachDienThoai() {
  if (_danhSachDienThoai.isEmpty) {
    print("Không có điện thoại nào trong cửa hàng.");
  } else {
    print("Danh sách điện thoại:");
    for (var dienThoai in _danhSachDienThoai) {
      print("Mã điện thoại: ${dienThoai.maDienThoai}");
      print("Tên điện thoại: ${dienThoai.tenDienThoai}");
      print("Hãng sản xuất: ${dienThoai.hangSanXuat}");
      print("Giá nhập: ${dienThoai.giaNhap}");
      print("Giá bán: ${dienThoai.giaBan}");
      print("Số lượng tồn kho: ${dienThoai.soLuongTonKho}");
      print("Trạng thái kinh doanh: ${dienThoai.trangThaiKinhDoanh ? 'Đang bán' : 'Ngừng bán'}");
      print("-----------------------------");
    }
  }
}

  // Phương thức tạo hóa đơn mới
  void taoHoaDon(HoaDon hoaDon) {
    _danhSachHoaDon.add(hoaDon);
    for (var dt in _danhSachDienThoai) {
      if (dt.maDienThoai == hoaDon.dienThoai.maDienThoai) {
        dt.soLuongTonKho -= hoaDon.soLuongMua;
      }
    }
  }

  // Phương thức tìm kiếm hóa đơn theo mã, ngày, khách hàng
  List<HoaDon> timHoaDon({String? maHoaDon, DateTime? tuNgay, DateTime? denNgay, String? tenKhachHang}) {
    return _danhSachHoaDon.where((hoaDon) {
      bool matchesMa = maHoaDon == null || hoaDon.maHoaDon.contains(maHoaDon);
      bool matchesDate = (tuNgay == null || hoaDon.ngayBan.isAfter(tuNgay)) &&
                         (denNgay == null || hoaDon.ngayBan.isBefore(denNgay));
      bool matchesCustomer = tenKhachHang == null || hoaDon.tenKhachHang.contains(tenKhachHang);
      return matchesMa && matchesDate && matchesCustomer;
    }).toList();
  }

  void hienThiDanhSachHoaDon() {
  if (_danhSachHoaDon.isEmpty) {
    print("Không có hóa đơn nào.");
  } else {
    print("Danh sách hóa đơn:");
    for (var hoaDon in _danhSachHoaDon) {
      hoaDon.hienThiThongTin();
      print("-----------------------------");
    }
  }
}

  // Phương thức thống kê tổng doanh thu theo khoảng thời gian
  double tongDoanhThu(DateTime tuNgay, DateTime denNgay) {
    double tong = 0;
    for (var hoaDon in _danhSachHoaDon) {
      if (hoaDon.ngayBan.isAfter(tuNgay) && hoaDon.ngayBan.isBefore(denNgay)) {
        tong += hoaDon.tinhTongTien();
      }
    }
    return tong;
  }

  // Phương thức thống kê tổng lợi nhuận theo khoảng thời gian
  double tongLoiNhuan(DateTime tuNgay, DateTime denNgay) {
    double tongLoiNhuan = 0;
    for (var hoaDon in _danhSachHoaDon) {
      if (hoaDon.ngayBan.isAfter(tuNgay) && hoaDon.ngayBan.isBefore(denNgay)) {
        tongLoiNhuan += hoaDon.tinhLoiNhuanThucTe();
      }
    }
    return tongLoiNhuan;
  }

  // Phương thức thống kê top điện thoại bán chạy
  List<DienThoai> topDienThoaiBanChay() {
    Map<String, int> soLuongBan = {};
    for (var hoaDon in _danhSachHoaDon) {
      String maDienThoai = hoaDon.dienThoai.maDienThoai;
      if (!soLuongBan.containsKey(maDienThoai)) {
        soLuongBan[maDienThoai] = 0;
      }
      soLuongBan[maDienThoai] = soLuongBan[maDienThoai]! + hoaDon.soLuongMua;
    }

    List<MapEntry<String, int>> sorted = soLuongBan.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<DienThoai> topDienThoai = [];
    for (var entry in sorted) {
      var dienThoai = _danhSachDienThoai.firstWhere((dt) => dt.maDienThoai == entry.key);
      topDienThoai.add(dienThoai);
    }

    return topDienThoai;
  }

  // Phương thức thống kê tồn kho
  Map<String, int> thongKeTonKho() {
    Map<String, int> tonKho = {};
    for (var dt in _danhSachDienThoai) {
      tonKho[dt.tenDienThoai] = dt.soLuongTonKho;
    }
    return tonKho;
  }
}
