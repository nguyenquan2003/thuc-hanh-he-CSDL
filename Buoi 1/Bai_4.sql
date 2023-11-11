CREATE DATABASE DB_QLHV10 ON PRIMARY
(
	NAME = 'DBQLHV_PRIMARY',
	FILENAME = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\DBQLHV_PRIMARY.mdf',
	SIZE = 5 MB,
	MAXSIZE = 10 MB,
	FILEGROWTH = 10%
)
LOG ON
(
	NAME = 'DBQLHV_LOG',
	FILENAME = 'D:\NguyenNgocQuan_THHQTCSDL_Buoi1\DBQLHV_LOG.ldf',
	SIZE = 2 MB,
	MAXSIZE = 5 MB,
	FILEGROWTH = 15%
)

USE db
GO
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(7) NOT NULL,
	TENGV NVARCHAR(50),
	NGAYSINH DATE,
	GIOITINH NVARCHAR(10),
	DIENTHOAI NCHAR(11),
	MAGVQUANLI CHAR(7),
	CONSTRAINT PK_GV PRIMARY KEY(MAGV)
)
GO
CREATE TABLE HOCVIEN
(
	MAHOCVIEN CHAR(8),
	TENHOCVIEN NVARCHAR(50),
	NGAYSINH DATE,
	TINHTRANG NVARCHAR(50),
	MALOP CHAR(8),
	CONSTRAINT PK_HV PRIMARY KEY(MAHOCVIEN)
)

GO
CREATE TABLE LOPHOC
(
	MALOP CHAR(8) NOT NULL,
	SISO INT,
	LOPTRUONG CHAR(8),
	GVQUANLI CHAR(7),
	NAMBATDAU INT,
	NAMKETTHUC INT,
)
GO
CREATE TABLE MONHOC
(
	MAMONHOC CHAR(7) NOT NULL,
	TENMONHOC NVARCHAR(50),
	SOCHI INT,
	CONSTRAINT PK_MH PRIMARY KEY(MAMONHOC)
)
GO
CREATE TABLE KETQUA
(
	MAHV CHAR(8) NOT NULL,
	MAMONHOC CHAR(7) NOT NULL,
	LANTHI INT NOT NULL,
	DIEM FLOAT,
	CONSTRAINT PK_KQ PRIMARY KEY(MAHV, MAMONHOC, LANTHI)
)

CREATE TABLE GIAOVIEN_DAY_MONHOC
(
	MAGV CHAR(7) NOT NULL,
	MAMH CHAR(7) NOT NULL,
	THAMNIEN INT,
	SOLOPDADAY INT,

)
GO
CREATE TABLE PHANCONG
(
	MAGV CHAR(7) NOT NULL,
	MAMH CHAR(7) NOT NULL,
	MALOP CHAR(8) NOT NULL,
	CONSTRAINT PK_PC PRIMARY KEY(MAGV, MAMH,MALOP)
)
------------------------TAO KHOA NGOAI
ALTER TABLE LOPHOC ADD CONSTRAINT PK_LH PRIMARY KEY (MALOP)
ALTER TABLE GIAOVIEN_DAY_MONHOC ADD CONSTRAINT PK_GDM PRIMARY KEY(MAGV, MAMH)
ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GV FOREIGN KEY (MAGVQUANLI) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE LOPHOC ADD CONSTRAINT FK_LH FOREIGN KEY (GVQUANLI) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE LOPHOC ADD CONSTRAINT FK_LH1 FOREIGN KEY (LOPTRUONG) REFERENCES HOCVIEN (MAHOCVIEN)
ALTER TABLE HOCVIEN ADD CONSTRAINT FK_HV FOREIGN KEY (MALOP) REFERENCES LOPHOC (MALOP)
ALTER TABLE GIAOVIEN_DAY_MONHOC ADD CONSTRAINT FK_GDM FOREIGN KEY (MAGV) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE GIAOVIEN_DAY_MONHOC ADD CONSTRAINT FK_GDM1 FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMONHOC)
ALTER TABLE PHANCONG ADD CONSTRAINT FK_PC FOREIGN KEY (MAGV, MAMH) REFERENCES GIAOVIEN_DAY_MONHOC (MAGV, MAMH)
ALTER TABLE PHANCONG ADD CONSTRAINT FK_PC1 FOREIGN KEY (MALOP) REFERENCES LOPHOC (MALOP)
ALTER TABLE KETQUA ADD CONSTRAINT FK_KQ FOREIGN KEY (MAHV) REFERENCES HOCVIEN (MAHOCVIEN)
ALTER TABLE KETQUA ADD CONSTRAINT FK_KQ1 FOREIGN KEY (MAMONHOC) REFERENCES MONHOC (MAMONHOC)

------------------------INSERT DU LIEU
-- INSERT BANG GIAO VIEN
set dateformat dmy
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0009', N'Trần Thị Kiều', '03/01/1997', N'Nữ','', NULL);
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0010', N'Trần Phương Loan', '30/4/1978', N'Nữ','', NULL);
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0008', N'Nguyễn Thị Linh', '08/07/1979', N'Nữ','0988076099', 'GV0009');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0004', N'Trương Tương Vi', '01/02/1988', N'Nữ','0984578905', 'GV0008');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0005', N'Hà Anh Tuấn', '03/12/1986', N'Nam','09139979797', 'GV0008');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0002', N'Nguyễn Thị Như Lan', '02/01/1981', N'Nam','', 'GV0005');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLI)
values ('GV0001', N'Nguyễn Văn An', '02/01/1981', N'Nam','', 'GV0002');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0003', N'Trần Minh Anh', '23/03/1986', N'Nam','', 'GV0002');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0006', N'Trần Anh Dũng', '04/04/1979', N'Nam','', 'GV0010');
insert into GiaoVien (magv,TenGV,NgaySinh, GioiTinh, DienThoai, MaGVQuanLi)
values ('GV0007', N'Trần Duy Tân', '04/01/1978', N'Nam','', 'GV0002');
update GiaoVien set MaGVQuanLi= NULL where MaGV in( 'GV0009', 'GV0010') 
-- INSERT BANG HOC VIEN
set dateformat dmy
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00001',N' Nguyễn Thị Thùy Trang', '01/02/1992', N'Buộc thôi học', NULL) 
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00002',N' Nguyễn Thị Kim Ngọc', '20/12/1993', N'Đang học', NULL) 
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00003',N' Nguyễn Xuân Phúc', '30/12/1994', N'Đang học', NULL) 
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00004',N' Trần Minh An', '03/12/1991', N'Đang học', NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00005',N' Trần Minh Anh', '12/03/1992', N'Đang học', NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00006',N' Trương Mỹ Linh', '12/12/1989', N'Đã tốt nghiệp', NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00007',N' Trần Hào', '02/02/1989', N'Đã tốt nghiệp',NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00008',N' Nguyễn Huỳnh Hoa', '03/03/1992', N'Đang học', NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00009',N' Lê Xuân Ngọc', '13/03/1993', N'Đang học', NULL)
insert into hocvien (MAHOCVIEN, TENHOCVIEN, NgaySinh, TinhTrang, MaLop)
values ('HV00011', N'Nguyễn Thị Thùy ', '01/02/1992/02', N'Buộc thôi học', NULL) 

-- INSERT BANG LOP HOC
insert into LOPHOC( MaLop, SiSo, LopTruong, GVQuanLi, NamBatDau, NamKetThuc)
values ('LH00001', 1,NULL, 'GV0001', 2010, 2014)
insert into LOPHOC( MaLop, SiSo, LopTruong, GVQuanLi, NamBatDau, NamKetThuc)
values ('LH00002', 1,NULL, 'GV0003', 2009, 2013)
insert into LOPHOC( MaLop, SiSo, LopTruong, GVQuanLi, NamBatDau, NamKetThuc)
values ('LH00003', 2,NULL, 'GV0008', 2010, 2014)
insert into LOPHOC( MaLop, SiSo, LopTruong, GVQuanLi, NamBatDau, NamKetThuc)
values ('LH00004', 4,NULL, 'GV0010', 2011, 2015)
insert into LOPHOC( MaLop, SiSo, LopTruong, GVQuanLi, NamBatDau, NamKetThuc)
values ('LH00005', 1,NULL, 'GV0009', 2010, 2014)

-- INSERT BANG MON HOC

insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00001', N'Cơ sở dữ liệu', 5);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00002', N'Cấu trúc dữ liệu', 6);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00003', N'Mạng máy tính', 4);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00004', N'Toán cao cấp', 6);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00005', N'Tin học cơ sở', 3);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00006', N'Công nghệ phần mềm', 4);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00007', N'Trí tuệ nhân tạo', 4);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00008', N'Khai thác dữ liệu', 3);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00009', N'Phân tích thiết kế hệ thống thông tin', 3);
insert into MONHOC( MAMONHOC, TENMONHOC, SoChi)
values ('MH00010', N'Hệ thống thông tin', 4);
-- INSERT BANG KET QUA

insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00001', 'MH00001', 1, 5.5)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00001', 'MH00004', 1, 6)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00002', 'MH00001', 1, 7)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00002', 'MH00004', 1, 8)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00003', 'MH00008', 1, 8.7)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00003', 'MH00009', 1, 9)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00003', 'MH00010', 1, 10)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00004', 'MH00008', 1, 4)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00004', 'MH00008', 2, 3)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00004', 'MH00009', 1, 2)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00004', 'MH00009', 2, 5)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00004', 'MH00010', 1, 6)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00005', 'MH00008', 1, 7.5)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00005', 'MH00009', 1, 1)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00005', 'MH00009', 2, 7)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00005', 'MH00010', 1, 1)
insert into KETQUA ( MaHV, MAMONHOC, LanThi, Diem)
values ('HV00005', 'MH00010', 2, 3.5)
-- INSERT BANG GIAO VIEN DAY

insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0001', 'MH00001', 3, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0001', 'MH00004', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0002', 'MH00001', 1, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0002', 'MH00002', 1, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0003', 'MH00006', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0003', 'MH00007', 3, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0003', 'MH00010', 4, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0004', 'MH00009', 6, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0004', 'MH00010',1, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0005', 'MH00008', 4, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0005', 'MH00010', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0006', 'MH00008', 4, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0006', 'MH00009', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0006', 'MH00010', 4, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0007', 'MH00010', 7, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0008', 'MH00001', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0008', 'MH00002', 1, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0009', 'MH00010', 2, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0010', 'MH00001', 3, NULL)
insert into GIAOVIEN_DAY_MONHOC(MaGV, MaMH, ThamNien, SoLopDaDay)
values ('GV0010', 'MH00002', 1, NULL)

-- INSERT BANG PHAN CONG

insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0001', 'MH00001', 'LH00001')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0001', 'MH00004', 'LH00001')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0003', 'MH00010', 'LH00005')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0004', 'MH00009', 'LH00004')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0005', 'MH00008', 'LH00002')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0005', 'MH00008', 'LH00004')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0006', 'MH00008', 'LH00003')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0006', 'MH00009', 'LH00002')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0006', 'MH00009', 'LH00003')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0006', 'MH00010', 'LH00004')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0007', 'MH00010', 'LH00002')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0007', 'MH00010', 'LH00003')
insert into PHANCONG (MaGV, MaMH, MaLop)
values ('GV0008', 'MH00002', 'LH00004')

-- update mã lớp của bảng học viên
UPDATE HOCVIEN SET MALOP = 'LH00001' WHERE MAHOCVIEN = 'HV00001'
UPDATE HOCVIEN SET MALOP = 'LH00001' WHERE MAHOCVIEN = 'HV00002'
UPDATE HOCVIEN SET MALOP = 'LH00002' WHERE MAHOCVIEN = 'HV00003'
UPDATE HOCVIEN SET MALOP = 'LH00003' WHERE MAHOCVIEN = 'HV00004' OR MAHOCVIEN = 'HV00005'
UPDATE HOCVIEN SET MALOP = 'LH00004' WHERE MAHOCVIEN = 'HV00006' OR MAHOCVIEN = 'HV00007' OR MAHOCVIEN = 'HV00008' OR MAHOCVIEN = 'HV00010'
UPDATE HOCVIEN SET MALOP = 'LH00005' WHERE MAHOCVIEN = 'HV00009'

--update mã lớp trưởng cho bảng lớp
update LOPHOC set LOPTRUONG = 'HV00002' WHERE MALOP = 'LH00001'
update LOPHOC set LOPTRUONG = 'HV00003' WHERE MALOP = 'LH00002'
update LOPHOC set LOPTRUONG = 'HV00004' WHERE MALOP = 'LH00003'
update LOPHOC set LOPTRUONG = 'HV00008' WHERE MALOP = 'LH00004'
update LOPHOC set LOPTRUONG = 'HV00009' WHERE MALOP = 'LH00005'
--Họ tên và tuổi của các giáo viên nữ:
SELECT TENGV, 
       YEAR(GETDATE()) - YEAR(NGAYSINH) AS Tuoi
FROM GIAOVIEN
WHERE GIOITINH = N'Nữ';

--Họ tên và tình trạng của học viên có mã số HV000001:
SELECT TENHOCVIEN, TINHTRANG
FROM HOCVIEN
WHERE MAHOCVIEN = 'HV00001';
--Họ tên của các học viên nhỏ hơn hoặc bằng 20 tuổi:
SELECT TENHOCVIEN
FROM HOCVIEN
WHERE DATEDIFF(YEAR, NGAYSINH, GETDATE()) <= 20;

--Mã số các lớp có sĩ số học viên trong khoảng từ 2 đến 4:
SELECT MALOP
FROM LOPHOC
WHERE SiSo BETWEEN 2 AND 4;
--Mã, họ tên, ngày sinh của các giáo viên mang họ Nguyễn:
SELECT MAGV, TENGV, NGAYSINH
FROM GIAOVIEN
WHERE TENGV LIKE N'Nguyễn%';
--Họ tên các giáo viên chưa có giáo viên quản lý:
SELECT TENGV
FROM GIAOVIEN
WHERE MAGVQUANLI IS NULL;
--Mã số các giáo viên có quản lý một giáo viên nào đó:
SELECT MAGV
FROM GIAOVIEN
WHERE MAGVQUANLI IS NOT NULL;
--Mã số, họ tên các học viên làm trưởng lớp:
SELECT MAHOCVIEN, TENHOCVIEN
FROM HOCVIEN
WHERE MAHOCVIEN IN (SELECT LOPTRUONG FROM LOPHOC WHERE LOPTRUONG IS NOT NULL);
--Mã số, tên các môn mà học viên HV000005 đã từng thi rớt:
SELECT K.MAMONHOC, TENMONHOC
FROM KETQUA K
JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
WHERE MAHV = 'HV000005' AND LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAHV = 'HV000005' AND MAMONHOC = K.MAMONHOC) AND DIEM < 5;
--Mã số các học viên từng thi môn MH00009 nhiều hơn 1 lần:
SELECT MAHV
FROM KETQUA
WHERE MAMONHOC = 'MH00009'
GROUP BY MAHV
HAVING COUNT(LANTHI) > 1;
--Mã học viên, tên học viên có điểm thi cao nhất môn MH00009:
SELECT TOP 1 MAHV, TENHOCVIEN
FROM HOCVIEN
WHERE MAHV IN (SELECT MAHV FROM KETQUA WHERE MAMONHOC = 'MH00009' ORDER BY DIEM DESC)
ORDER BY DIEM DESC;
--Họ tên và tuổi của học viên nhỏ tuổi nhất:
SELECT TOP 1 TENHOCVIEN, DATEDIFF(YEAR, NGAYSINH, GETDATE()) AS Tuoi
FROM HOCVIEN
ORDER BY NGAYSINH ASC;
--Mã, tên và số tín chỉ của môn học có nhiều học viên thi rớt nhất:
SELECT MAMONHOC, TENMONHOC, SoChi
FROM MONHOC
WHERE MAMONHOC IN (SELECT K.MAMONHOC
                   FROM KETQUA K
                   JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
                   WHERE LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAMONHOC = K.MAMONHOC) AND DIEM < 5
                   GROUP BY K.MAMONHOC
                   HAVING COUNT(MAHV) = (SELECT COUNT(MAHV)
                                         FROM KETQUA
                                         WHERE MAMONHOC = K.MAMONHOC
                                         GROUP BY MAHV
                                         HAVING COUNT(LANTHI) = 1));
--Số môn mà học viên Trần Minh An đã thi đậu:
SELECT COUNT(MAMONHOC)
FROM KETQUA
WHERE MAHV = 'HV000004' AND DIEM >= 5;

--Điểm trung bình của học viên HV000004 (theo công thức đã cho):
SELECT SUM(K.DIEM * M.SoChi) / SUM(M.SoChi) AS DiemTrungBinh
FROM KETQUA K
JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
WHERE K.MAHV = 'HV000004' AND K.LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAHV = 'HV000004');

--Cho biết số tín chỉ mà học viên Trần Minh An đã đạt được. Số tín chỉ đạt đượclà tổng số tín chỉ các môn mà học viên đó đã thi đậu.
SELECT SUM(M.SoChi) AS SoTinChiDatDuoc
FROM KETQUA K
JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
WHERE K.MAHV = 'HV000004' AND K.LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAHV = 'HV000004') AND K.DIEM >= 5;
--Liệt kê những học viên đạt trên 8 tín chỉ (mã học viên, họ tên học viên và số tín chỉ đã đạt được):
SELECT K.MAHV, H.TENHOCVIEN, SUM(M.SoChi) AS SoTinChiDatDuoc
FROM KETQUA K
JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
JOIN HOCVIEN H ON K.MAHV = H.MAHV
GROUP BY K.MAHV, H.TENHOCVIEN
HAVING SUM(M.SoChi) > 8;
--Xuất ra danh sách học viên cùng điểm trung bình của học viên (tính theo công thức câu 15):SELECT K1.MAHV, H1.TENHOCVIEN, K1.DIEMTrungBinh
FROM (
  SELECT K.MAHV, SUM(K.DIEM * M.SoChi) / SUM(M.SoChi) AS DIEMTrungBinh
  FROM KETQUA K
  JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
  WHERE K.LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAHV = K.MAHV)
  GROUP BY K.MAHV
) K1
JOIN HOCVIEN H1 ON K1.MAHV = H1.MAHV
JOIN (
  SELECT K.MAHV, SUM(K.DIEM * M.SoChi) / SUM(M.SoChi) AS DIEMTrungBinh
  FROM KETQUA K
  JOIN MONHOC M ON K.MAMONHOC = M.MAMONHOC
  WHERE K.LANTHI = (SELECT MAX(LANTHI) FROM KETQUA WHERE MAHV = K.MAHV)
  GROUP BY K.MAHV
) K2 ON K1.DIEMTrungBinh = K2.DIEMTrungBinh AND K1.MAHV != K2.MAHV;


--Thông tin học viên đậu tất cả các môn học trong lần thi đầu tiên:
SELECT K.MAHV, H.TENHOCVIEN
FROM KETQUA K
JOIN HOCVIEN H ON K.MAHV = H.MAHV
WHERE K.LANTHI = 1
GROUP BY K.MAHV, H.TENHOCVIEN
HAVING COUNT(K.MAMONHOC) = (SELECT COUNT(MAMONHOC) FROM MONHOC);
--Thông tin lớp học có tất cả các học viên đậu tất cả các môn trong lần thi đầu tiên:
SELECT L.MALOPHOC
FROM LOPHOC L
JOIN HOCVIEN H ON L.MALOPHOC = H.MALOPHOC
JOIN KETQUA K ON H.MAHV = K.MAHV AND K.LANTHI = 1
GROUP BY L.MALOPHOC
HAVING COUNT(DISTINCT K.MAHV) = (SELECT COUNT(H.MAHV) FROM HOCVIEN H WHERE H.MALOPHOC = L.MALOPHOC)
   AND COUNT(K.MAMONHOC) = (SELECT COUNT(MAMONHOC) FROM MONHOC);
   --Cập nhật lại sĩ số thực của lớp học bằng số học viên trong lớp học đó:
   UPDATE LOPHOC
SET SI_SO_THUC = (SELECT COUNT(MAHV) FROM HOCVIEN WHERE MALOPHOC = LOPHOC.MALOPHOC);





