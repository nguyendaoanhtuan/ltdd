class DienThoai {
  String _maDienThoai;
  String _tenDienThoai;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThaiKinhDoanh;

  // Constructor đầy đủ tham số
  DienThoai(this._maDienThoai, this._tenDienThoai, this._hangSanXuat,
      this._giaNhap, this._giaBan, this._soLuongTonKho, this._trangThaiKinhDoanh);

  // Getter và Setter với validation
  String get maDienThoai => _maDienThoai;
  set maDienThoai(String value) {
    if (value.isNotEmpty && value.startsWith("DT-")) {
      _maDienThoai = value;
    } else {
      throw FormatException("Mã điện thoại không hợp lệ");
    }
  }

  String get tenDienThoai => _tenDienThoai;
  set tenDienThoai(String value) {
    if (value.isNotEmpty) {
      _tenDienThoai = value;
    } else {
      throw FormatException("Tên điện thoại không thể trống");
    }
  }

  String get hangSanXuat => _hangSanXuat;
  set hangSanXuat(String value) {
    if (value.isNotEmpty) {
      _hangSanXuat = value;
    } else {
      throw FormatException("Hãng sản xuất không thể trống");
    }
  }

  double get giaNhap => _giaNhap;
  set giaNhap(double value) {
    if (value > 0) {
      _giaNhap = value;
    } else {
      throw FormatException("Giá nhập phải lớn hơn 0");
    }
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0 && value > _giaNhap) {
      _giaBan = value;
    } else {
      throw FormatException("Giá bán phải lớn hơn giá nhập");
    }
  }

  int get soLuongTonKho => _soLuongTonKho;
  set soLuongTonKho(int value) {
    if (value >= 0) {
      _soLuongTonKho = value;
    } else {
      throw FormatException("Số lượng tồn kho không thể âm");
    }
  }

  bool get trangThaiKinhDoanh => _trangThaiKinhDoanh;
  set trangThaiKinhDoanh(bool value) {
    _trangThaiKinhDoanh = value;
  }

  // Phương thức tính lợi nhuận dự kiến
  double tinhLoiNhuanDuKien(int soLuongBan) {
    return (giaBan - giaNhap) * soLuongBan;
  }

  // Phương thức hiển thị thông tin
  void hienThiThongTin() {
    print("Mã điện thoại: $_maDienThoai");
    print("Tên điện thoại: $_tenDienThoai");
    print("Hãng sản xuất: $_hangSanXuat");
    print("Giá nhập: $_giaNhap");
    print("Giá bán: $_giaBan");
    print("Số lượng tồn kho: $_soLuongTonKho");
    print("Trạng thái kinh doanh: $_trangThaiKinhDoanh");
  }

  // Phương thức kiểm tra có thể bán không
  bool coTheBan() {
    return _soLuongTonKho > 0 && _trangThaiKinhDoanh;
  }
}
