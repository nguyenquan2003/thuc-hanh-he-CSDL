CREATE DATABASE QL_BanHang;
USE bai5 ;

CREATE TABLE KHACH (
    MAKH INT PRIMARY KEY,
    TENKH VARCHAR(255),
    DCHI VARCHAR(255),
    DTHOAI VARCHAR(15)
);

-- Tạo bảng NHASX
CREATE TABLE NHASX (
    MANSX INT PRIMARY KEY,
    TENNSX VARCHAR(255),
    DCHI VARCHAR(255),
    DTHOAI VARCHAR(15)
);

-- Tạo bảng NHACC
CREATE TABLE NHACC (
    MANCC INT PRIMARY KEY,
    TENNCC VARCHAR(255),
    DCHI VARCHAR(255),
    DTHOAI VARCHAR(15)
);

-- Tạo bảng PHIEUNHAP
CREATE TABLE PHIEUNHAP (
    MAPN INT PRIMARY KEY,
    NGAYNHAP DATE,
    MANCC INT,
    TIENNHAP DECIMAL(18, 2),
    FOREIGN KEY (MANCC) REFERENCES NHACC(MANCC)
);

-- Tạo bảng HANG
CREATE TABLE HANG (
    MAHG INT PRIMARY KEY,
    TENHG VARCHAR(255),
    DVT VARCHAR(20),
    SOLUONG INT,
    MANSX INT,
    MANCC INT,
    TINHTRANG VARCHAR(50),
    FOREIGN KEY (MANSX) REFERENCES NHASX(MANSX),
    FOREIGN KEY (MANCC) REFERENCES NHACC(MANCC)
);

-- Tạo bảng CHITIETPN
CREATE TABLE CHITIETPN (
    MAPN INT,
    MAHG INT,
    SOLUONG INT,
    GIANHAP DECIMAL(18, 2),
    THANHTIEN DECIMAL(18, 2),
    PRIMARY KEY (MAPN, MAHG),
    FOREIGN KEY (MAPN) REFERENCES PHIEUNHAP(MAPN),
    FOREIGN KEY (MAHG) REFERENCES HANG(MAHG)
);

-- Tạo bảng HOADON
CREATE TABLE HOADON (
    MAHD INT PRIMARY KEY,
    NGAYBAN DATE,
    TENNV VARCHAR(255),
    MAKH INT,
    TIENBAN DECIMAL(18, 2),
    GIAMGIA DECIMAL(18, 2),
    THANHTOAN VARCHAR(50),
    FOREIGN KEY (MAKH) REFERENCES KHACH(MAKH)
);

-- Tạo bảng CHITIETHD
CREATE TABLE CHITIETHD (
    MAHD INT,
    MAHG INT,
    SOLUONG INT,
    GIABAN DECIMAL(18, 2),
    THANHTIEN DECIMAL(18, 2),
    PRIMARY KEY (MAHD, MAHG),
    FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD),
    FOREIGN KEY (MAHG) REFERENCES HANG(MAHG)
);

-- Tạo bảng DONGIA
CREATE TABLE DONGIA (
    MAHG INT PRIMARY KEY,
    NGAYCN DATE,
    GIA DECIMAL(18, 2),
    FOREIGN KEY (MAHG) REFERENCES HANG(MAHG)
);
-- Thêm ràng buộc khóa ngoại cho bảng CHITIETHD
ALTER TABLE CHITIETHD
ADD CONSTRAINT FK_CHITIETHD_HOADON
FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD);

ALTER TABLE CHITIETHD
ADD CONSTRAINT FK_CHITIETHD_HANG
FOREIGN KEY (MAHG) REFERENCES HANG(MAHG);

-- Thêm ràng buộc khóa ngoại cho bảng CHITIETPN
ALTER TABLE CHITIETPN
ADD CONSTRAINT FK_CHITIETPN_PHIEUNHAP
FOREIGN KEY (MAPN) REFERENCES PHIEUNHAP(MAPN);

ALTER TABLE CHITIETPN
ADD CONSTRAINT FK_CHITIETPN_HANG
FOREIGN KEY (MAHG) REFERENCES HANG(MAHG);

--Thủ tục cập nhật THANHTIEN trên bảng CHITIETHD và TIENBAN trên bảng HOADON
-- Tạo thủ tục cập nhật THANHTIEN trên bảng CHITIETHD và TIENBAN trên bảng HOADON
CREATE PROCEDURE CapNhatThanhTienTienBan
    @MaHD INT
AS
BEGIN
    -- Cập nhật THANHTIEN trên bảng CHITIETHD
    UPDATE CHITIETHD
    SET THANHTIEN = SOLUONG * GIABAN
    WHERE MAHD = @MaHD;

    -- Cập nhật TIENBAN trên bảng HOADON
    UPDATE HOADON
    SET TIENBAN = (
            SELECT SUM(THANHTIEN)
            FROM CHITIETHD
            WHERE MAHD = @MaHD
        )
    WHERE MAHD = @MaHD;
END;

-- Gọi thủ tục để cập nhật THANHTIEN và TIENBAN cho một hóa đơn cụ thể
EXEC CapNhatThanhTienTienBan @MaHD = 1; -- Thay thế 1 bằng mã hóa đơn cần cập nhật
--Viết thủ tục thực hiện cập nhật THANHTIEN trên bảng CHITIETPN và
--TIENNHAP trên bảng PHIEUNHAP.
-- Tạo thủ tục cập nhật THANHTIEN trên bảng CHITIETPN và TIENNHAP trên bảng PHIEUNHAP
CREATE PROCEDURE CapNhatThanhTienTienNhap
    @MaPN INT
AS
BEGIN
    -- Cập nhật THANHTIEN trên bảng CHITIETPN
    UPDATE CHITIETPN
    SET THANHTIEN = SOLUONG * GIANHAP
    WHERE MAPN = @MaPN;

    -- Cập nhật TIENNHAP trên bảng PHIEUNHAP
    UPDATE PHIEUNHAP
    SET TIENNHAP = (
            SELECT SUM(THANHTIEN)
            FROM CHITIETPN
            WHERE MAPN = @MaPN
        )
    WHERE MAPN = @MaPN;
END;
-- Gọi thủ tục để cập nhật THANHTIEN và TIENNHAP cho một phiếu nhập cụ thể
EXEC CapNhatThanhTienTienNhap @MaPN = 1; -- Thay thế 1 bằng mã phiếu nhập cần cập nhật
--Viết thủ tục truyền vào tham số mã khách hàng sẽ in ra danh sách các hóa đơn (mã
--hóa đơn, tổng trị giá) của khách hàng đó.
-- Tạo thủ tục để in ra danh sách hóa đơn của một khách hàng
CREATE PROCEDURE DanhSachHoaDonKhachHang
    @MaKH INT
AS
BEGIN
    -- In ra danh sách hóa đơn của khách hàng
    SELECT
        HOADON.MAHD,
        HOADON.NGAYBAN,
        HOADON.TIENBAN AS TongTriGia
    FROM
        HOADON
    WHERE
        HOADON.MAKH = @MaKH;
END;
-- Gọi thủ tục để in ra danh sách hóa đơn của một khách hàng cụ thể
EXEC DanhSachHoaDonKhachHang @MaKH = 1; -- Thay thế 1 bằng mã khách hàng cần tìm
--Viết thủ tục truyền vào tham số mã hóa đơn sẽ trả về ngày lập và trị giá của hóa
--đơn đó.
-- Tạo thủ tục để trả về ngày lập và trị giá của một hóa đơn
CREATE PROCEDURE ThongTinHoaDon
    @MaHD INT
AS
BEGIN
    -- Trả về ngày lập và trị giá của hóa đơn
    SELECT
        NGAYBAN AS NgayLap,
        TIENBAN AS TriGia
    FROM
        HOADON
    WHERE
        MAHD = @MaHD;
END;
-- Gọi thủ tục để lấy thông tin của một hóa đơn cụ thể
EXEC ThongTinHoaDon @MaHD = 1; -- Thay thế 1 bằng mã hóa đơn cần tìm
--Viết thủ tục truyền vào tham số mã hàng sẽ trả về tên hàng, tên nhà sản xuất và tên
--nhà cung cấp tương ứng.
-- Tạo thủ tục để trả về thông tin sản phẩm
CREATE PROCEDURE ThongTinSanPham
    @MaHG INT
AS
BEGIN
    -- Trả về tên hàng, tên nhà sản xuất, và tên nhà cung cấp tương ứng
    SELECT
        HANG.TENHG AS TenHang,
        NHASX.TENNSX AS TenNhaSanXuat,
        NHACC.TENNCC AS TenNhaCungCap
    FROM
        HANG
    JOIN NHASX ON HANG.MANSX = NHASX.MANSX
    JOIN NHACC ON HANG.MANCC = NHACC.MANCC
    WHERE
        HANG.MAHG = @MaHG;
END;
-- Gọi thủ tục để lấy thông tin của một sản phẩm cụ thể
EXEC ThongTinSanPham @MaHG = 1; -- Thay thế 1 bằng mã hàng cần tìm
--Để kiểm tra một khách hàng thuộc loại nào (‘VIP’, ‘KH thành viên’, ‘KH thân
--thiết’) cần viết một thủ tục truyền vào tham số mã khách hàng sẽ trả về ‘VIP’ nếu
--doanh số ≥10.000.000; ‘KH thành viên’ nếu 6.000.000 ≤doanh số<10.000.000; ‘KH
--thân thiết’ nếu doanh số <6.000.000 (ghi chú: Doanh số là số tiền mà khách mua
--hàng).
-- Tạo thủ tục để xác định loại khách hàng
CREATE PROCEDURE XacDinhLoaiKhachHang
    @MaKH INT
AS
BEGIN
    DECLARE @DoanhSo DECIMAL(18, 2);

    -- Lấy doanh số mua hàng của khách hàng
    SELECT @DoanhSo = ISNULL(SUM(TIENBAN), 0)
    FROM HOADON
    WHERE MAKH = @MaKH;

    -- Xác định loại khách hàng dựa trên doanh số
    IF @DoanhSo >= 10000000
        SELECT 'VIP' AS LoaiKhachHang;
    ELSE IF @DoanhSo >= 6000000
        SELECT 'KH thành viên' AS LoaiKhachHang;
    ELSE
        SELECT 'KH thân thiết' AS LoaiKhachHang;
END;
-- Gọi thủ tục để kiểm tra loại khách hàng của một khách hàng cụ thể
EXEC XacDinhLoaiKhachHang @MaKH = 2; -- Thay thế 1 bằng mã khách hàng cần kiểm tra
--Viết thủ tục truyền vào mã hàng sẽ trả về ngày cập nhật đơn giá gần nhất.
-- Tạo thủ tục để trả về ngày cập nhật đơn giá gần nhất
CREATE PROCEDURE NgayCapNhatDonGiaGanNhat
    @MaHG INT
AS
BEGIN
    -- Trả về ngày cập nhật đơn giá gần nhất
    SELECT TOP 1
        NGAYCN AS NgayCapNhat
    FROM
        DONGIA
    WHERE
        MAHG = @MaHG
    ORDER BY
        NGAYCN DESC;
END;
-- Gọi thủ tục để lấy ngày cập nhật đơn giá gần nhất của một sản phẩm cụ thể
EXEC NgayCapNhatDonGiaGanNhat @MaHG = 1; -- Thay thế 1 bằng mã hàng cần tìm
