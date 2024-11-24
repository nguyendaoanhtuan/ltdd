import '../models/dien_thoai.dart';
class HoaDon {
  String _maHoaDon;
  DateTime _ngayBan;
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhach;

  // Constructor đầy đủ tham số
    HoaDon(this._maHoaDon, this._ngayBan, this._dienThoai, this._soLuongMua,
      this._giaBanThucTe, this._tenKhachHang, this._soDienThoaiKhach);

  // Getter và Setter với validation
  String get maHoaDon => _maHoaDon;
  set maHoaDon(String value) {
    if (value.isNotEmpty && value.startsWith("HD-")) {
      _maHoaDon = value;
    } else {
      throw FormatException("Mã hóa đơn không hợp lệ");
    }
  }

  DateTime get ngayBan => _ngayBan;
  set ngayBan(DateTime value) {
    if (value.isBefore(DateTime.now())) {
      _ngayBan = value;
    } else {
      throw FormatException("Ngày bán không thể sau ngày hiện tại");
    }
  }

  int get soLuongMua => _soLuongMua;
  set soLuongMua(int value) {
    if (value > 0 && value <= _dienThoai.soLuongTonKho) {
      _soLuongMua = value;
    } else {
      throw FormatException("Số lượng mua không hợp lệ");
    }
  }

  double get giaBanThucTe => _giaBanThucTe;
  set giaBanThucTe(double value) {
    if (value > 0) {
      _giaBanThucTe = value;
    } else {
      throw FormatException("Giá bán thực tế phải lớn hơn 0");
    }
  }

  String get tenKhachHang => _tenKhachHang;
  set tenKhachHang(String value) {
    if (value.isNotEmpty) {
      _tenKhachHang = value;
    } else {
      throw FormatException("Tên khách hàng không thể trống");
    }
  }

  String get soDienThoaiKhach => _soDienThoaiKhach;
  set soDienThoaiKhach(String value) {
    if (value.isNotEmpty && value.length == 10) {
      _soDienThoaiKhach = value;
    } else {
      throw FormatException("Số điện thoại không hợp lệ");
    }
  }

   // Getter cho DienThoai
  DienThoai get dienThoai => _dienThoai;



  // Phương thức tính tổng tiền
  double tinhTongTien() {
    return _giaBanThucTe * _soLuongMua;
  }

  // Phương thức tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() {
    return (_giaBanThucTe - _dienThoai.giaNhap) * _soLuongMua;
  }

  // Phương thức hiển thị thông tin hóa đơn
  void hienThiThongTin() {
    print("Mã hóa đơn: $_maHoaDon");
    print("Ngày bán: $_ngayBan");
    print("Tên khách hàng: $_tenKhachHang");
    print("Số điện thoại khách: $_soDienThoaiKhach");
    print("Sản phẩm: ${_dienThoai.tenDienThoai}");
    print("Số lượng mua: $_soLuongMua");
    print("Giá bán thực tế: $_giaBanThucTe");
    print("Tổng tiền: ${tinhTongTien()}");
    print("Lợi nhuận thực tế: ${tinhLoiNhuanThucTe()}");
  }
}
