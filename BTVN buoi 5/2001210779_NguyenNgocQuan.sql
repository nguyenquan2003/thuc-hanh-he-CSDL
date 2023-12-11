﻿--Bài tập 1
--1.
CREATE DATABASE TEST;
USE TEST;
CREATE TABLE SINHVIEN (
    MaSV INT PRIMARY KEY,
    TenSV VARCHAR(50),
    Diem FLOAT
);

CREATE DATABASE SACH;
USE SACH;
CREATE TABLE DanhMucSach (
    MaSach INT PRIMARY KEY,
    TenSach VARCHAR(100),
    TacGia VARCHAR(50),
    Gia FLOAT
);

CREATE DATABASE SINHVIEN;
USE SINHVIEN;
CREATE TABLE LopHoc (
    MaLop INT PRIMARY KEY,
    TenLop VARCHAR(50),
    SoLuongSV INT
);

--2.
CREATE LOGIN SV1 WITH PASSWORD = 'MatKhauSV1';
CREATE LOGIN GV1 WITH PASSWORD = 'MatKhauGV1';
CREATE LOGIN ADM1 WITH PASSWORD = 'MatKhauADM1';

USE TEST;
CREATE USER SV1 FOR LOGIN SV1;
GRANT SELECT ON SINHVIEN TO SV1;

USE SACH;
CREATE USER GV1 FOR LOGIN GV1;
GRANT SELECT ON DanhMucSach TO GV1;

USE SINHVIEN;
CREATE USER ADM1 FOR LOGIN ADM1;
GRANT SELECT ON LopHoc TO ADM1;

--3.
USE SACH;
CREATE USER SinhVien1 FOR LOGIN SV1;
CREATE USER GV1 FOR LOGIN GV1;
GRANT SELECT ON DanhMucSach TO SinhVien1;
GRANT SELECT ON DanhMucSach TO GV1;

--4.
USE SACH;
GRANT SELECT ON DanhMucSach TO SinhVien1;
GRANT SELECT ON DanhMucSach TO GV1;

--5.
USE SACH;
DENY SELECT ON SCHEMA::dbo TO SinhVien1;

--6.
USE SACH;
CREATE ROLE GiaoVien1;
CREATE ROLE GiaoVien2;

--7.
USE SACH;
GRANT SELECT, INSERT ON DanhMucSach TO GiaoVien1;

--8.
USE SACH;
GRANT SELECT, INSERT ON DanhMucSach TO GiaoVien2;
DENY UPDATE, DELETE ON DanhMucSach TO GiaoVien2;

--9
USE SACH;
ALTER ROLE GiaoVien1 ADD MEMBER GV1;

--10.
USE SACH;
REVOKE SELECT, INSERT ON DanhMucSach FROM GiaoVien1;


--Bài tập 2:
--1.
CREATE DATABASE QLSV;
USE QLSV;

CREATE TABLE KHOA (
    Makhoa INT PRIMARY KEY,
    Tenkhoa NVARCHAR(50)
);
CREATE TABLE LOP (
    Malop INT PRIMARY KEY,
    Tenlop NVARCHAR(50),
    Makhoa INT,
    FOREIGN KEY (Makhoa) REFERENCES KHOA(Makhoa)
);
CREATE TABLE SINHVIEN (
    MaSV INT PRIMARY KEY,
    Hoten NVARCHAR(100),
    Ngaysinh DATE,
    Diachi NVARCHAR(255),
    Gioitinh NVARCHAR(10),
    Malop INT,
    FOREIGN KEY (Malop) REFERENCES LOP(Malop)
);
CREATE TABLE MONHOC (
    MaMH INT PRIMARY KEY,
    TenMH NVARCHAR(100),
    SoTC INT
);
CREATE TABLE KETQUA (
    MaSV INT,
    MaMH INT,
    Diem FLOAT,
    PRIMARY KEY (MaSV, MaMH),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
    FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)
);

-- Ban giám hiệu
CREATE ROLE BanGiamHieu;
GRANT INSERT, UPDATE, DELETE ON KHOA TO BanGiamHieu;


CREATE ROLE DaoTao;
GRANT INSERT, UPDATE, DELETE ON LOP TO DaoTao;
GRANT INSERT, UPDATE, DELETE ON SINHVIEN TO DaoTao;
GRANT INSERT, UPDATE, DELETE ON KETQUA TO DaoTao;

CREATE ROLE Khoa;
GRANT INSERT, UPDATE, DELETE ON MONHOC TO Khoa;

CREATE ROLE SinhVien;
GRANT SELECT ON SINHVIEN TO SinhVien;
GRANT SELECT, INSERT, UPDATE ON KETQUA TO SinhVien;

--2.
CREATE LOGIN Ngoan WITH PASSWORD = 'abcxyz';
CREATE LOGIN Thanh WITH PASSWORD = 'abcxyz';
CREATE LOGIN Nguyen WITH PASSWORD = 'abcxyz';
CREATE LOGIN Phuong WITH PASSWORD = 'abcxyz';
CREATE LOGIN Anh WITH PASSWORD = 'abcxyz';
CREATE LOGIN Hoa WITH PASSWORD = 'abcxyz';
CREATE LOGIN Hong WITH PASSWORD = 'abcxyz';

--3.
USE QLSV;
CREATE USER Ngoan FOR LOGIN Ngoan;
ALTER ROLE BanGiamHieu ADD MEMBER Ngoan;

CREATE USER Thanh FOR LOGIN Thanh;
ALTER ROLE DaoTao ADD MEMBER Thanh;

CREATE USER Nguyen FOR LOGIN Nguyen;
ALTER ROLE DaoTao ADD MEMBER Nguyen;

CREATE USER Phuong FOR LOGIN Phuong;
ALTER ROLE Khoa ADD MEMBER Phuong;

CREATE USER Anh FOR LOGIN Anh;
ALTER ROLE Khoa ADD MEMBER Anh;

CREATE USER Hoa FOR LOGIN Hoa;
ALTER ROLE SinhVien ADD MEMBER Hoa;

CREATE USER Hong FOR LOGIN Hong;
ALTER ROLE SinhVien ADD MEMBER Hong;


--Bài tập 3
CREATE DATABASE QLBH;
USE QLBH;

CREATE TABLE KHACHHANG (
    MaKH INT PRIMARY KEY,
    Hoten NVARCHAR(100),
    Diachi NVARCHAR(255),
    DT NVARCHAR(20)
);
CREATE TABLE MATHANG (
    MaMH INT PRIMARY KEY,
    TenMH NVARCHAR(100),
    DVT NVARCHAR(20),
    SLton INT,
    Dongia FLOAT
);
CREATE TABLE HOADON (
    SoHD INT PRIMARY KEY,
    Ngaylap DATE,
    MaKH INT,
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);
CREATE TABLE CHITIETHD (
    SoHD INT,
    MaMH INT,
    SL INT,
    PRIMARY KEY (SoHD, MaMH),
    FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD),
    FOREIGN KEY (MaMH) REFERENCES MATHANG(MaMH)
);
CREATE LOGIN NguyenA WITH PASSWORD = 'abc';
CREATE LOGIN NguyenB WITH PASSWORD = 'xyz';
CREATE LOGIN NguyenC WITH PASSWORD = 'abc';
CREATE LOGIN NguyenD WITH PASSWORD = 'xyz';
CREATE LOGIN NguyenE WITH PASSWORD = 'abc';
CREATE LOGIN NguyenF WITH PASSWORD = 'xyz';
CREATE LOGIN NguyenG WITH PASSWORD = 'abc';
CREATE LOGIN NguyenH WITH PASSWORD = 'xyz';

CREATE USER BanGiamDoc FOR LOGIN NguyenA;
CREATE USER BanGiamDoc FOR LOGIN NguyenB;

CREATE USER KeToan FOR LOGIN NguyenC;
CREATE USER KeToan FOR LOGIN NguyenD;
GRANT INSERT, UPDATE ON HOADON TO KeToan;
GRANT INSERT, UPDATE ON CHITIETHD TO KeToan;

CREATE USER KinhDoanh FOR LOGIN NguyenE;
CREATE USER KinhDoanh FOR LOGIN NguyenF;
GRANT INSERT, UPDATE ON KHACHHANG TO KinhDoanh;

CREATE USER IT FOR LOGIN NguyenG;
CREATE USER IT FOR LOGIN NguyenH;
GRANT CONTROL ON DATABASE::QLBH TO IT;

DENY UPDATE ON HOADON TO KeToan;
DENY UPDATE ON CHITIETHD TO KeToan;

REVOKE CONTROL ON DATABASE::QLBH TO BanGiamDoc;