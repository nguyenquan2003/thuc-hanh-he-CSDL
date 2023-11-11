create database QL_ThuVienn on primary
(
	name = QL_ThuVien,
	filename = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\db_primary.mdf)',
	size = 3MB,
	maxsize = 10MB,
	filegrowth = 10%

),
(
	name = DB_SECOND1_1,
	filename = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\DB_second1_1.ndf)',
	size = 3MB,
	maxsize = 5MB,
	filegrowth = 10%

),
(
	name = DB_SECOND1_2,
	filename = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\DB_second1_2.ndf)',
	size = 3MB,
	maxsize = 5MB,
	filegrowth = 5%

),
(
	name = DB_SECOND1_3,
	filename = 'D:\NguyenLePhong_THHQTCSDL_Buoi1\DB_second1_3.ndfx)',
	size = 3MB,
	maxsize = 5MB,
	filegrowth = 5%

)
log on
(	
	name = DB_Log,
	filename = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\DB_Log.ldf)',
	size = 1MB,
	maxsize = 5MB,
	filegrowth = 15%
)

USE DB_THUVIEN;
Go

CREATE TABLE SACH (
    MASH INT PRIMARY KEY,
    TENSH NVARCHAR(255),
    TACGIA NVARCHAR(255),
    LOAI NVARCHAR(50),
    TINHTRANG NVARCHAR(20)
);

CREATE TABLE DOCGIA (
    MADG INT PRIMARY KEY,
    TENDG NVARCHAR(255),
    TUOI INT,
    PHAI NVARCHAR(5),
    DIACHI NVARCHAR(255)
);

CREATE TABLE MUONSACH (
    MADG INT,
    MASH INT,
    NGAYMUON DATE,
    NGAYTRA DATE
);
--Thay đổi kiểu dữ liệu cột PHAI thành nvarchar(5) trong bảng DOCGIA:
ALTER TABLE DOCGIA
ALTER COLUMN PHAI NVARCHAR(5);
--Thêm cột Điện thoại và Email với kiểu dữ liệu tùy chọn vào bảng DOCGIA:
ALTER TABLE DOCGIA
ADD DienThoai NVARCHAR(15),
    Email NVARCHAR(255);
--Thêm cột Nhà xuất bản với kiểu dữ liệu là nvarchar(20) vào bảng SACH:
ALTER TABLE SACH
ADD NhaXuatBan NVARCHAR(20);

-- Yêu cầu 1: Tuổi của độc giả phải lớn hơn 15
ALTER TABLE DOCGIA
ADD CONSTRAINT CHK_Tuoi CHECK (TUOI > 15);

-- Yêu cầu 2: Phái của độc giả phải là Nam hoặc Nữ
ALTER TABLE DOCGIA
ADD CONSTRAINT CHK_Phai CHECK (PHAI IN ('Nam', 'Nữ'));

-- Yêu cầu 3: Loại sách phải thuộc các giá trị chỉ định
ALTER TABLE SACH
ADD CONSTRAINT CHK_LoaiSach CHECK (LOAI IN ('Khoa học tự nhiên', 'Xã hội', 'Kinh tế', 'Truyện'));

-- Xóa ràng buộc toàn vẹn
ALTER TABLE DOCGIA
DROP CONSTRAINT CHK_Tuoi;

ALTER TABLE DOCGIA
DROP CONSTRAINT CHK_Phai;

ALTER TABLE SACH
DROP CONSTRAINT CHK_LoaiSach;

-- Yêu cầu 5: Giá trị mặc định cho Tình trạng trên bảng SACH
ALTER TABLE SACH
ADD CONSTRAINT DF_TinhTrang DEFAULT 'Chưa mượn' FOR TINHTRANG;

-- Yêu cầu 6: Giá trị mặc định cho Địa chỉ trên bảng DOCGIA
ALTER TABLE DOCGIA
ADD CONSTRAINT DF_DiaChi DEFAULT 'Chưa xác định' FOR DIACHI;

-- Yêu cầu 7: Ràng buộc để đảm bảo Tên sách là duy nhất
ALTER TABLE SACH
ADD CONSTRAINT UQ_TenSach UNIQUE (TENSH);
