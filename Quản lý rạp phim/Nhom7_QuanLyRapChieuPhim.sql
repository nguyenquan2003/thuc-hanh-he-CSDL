Create Database QuanLy_RapChieuPhim
ON PRIMARY 
(
    NAME = QuanLy_RapChieuPhim_Data,
    FILENAME = 'C:\Data\QuanLy_RapChieuPhim_Data.mdf', -- Đường dẫn file MDF
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
),
-- Tạo file dữ liệu phụ (NDF)
FILEGROUP Secondary_FG
(
    NAME = QuanLy_RapChieuPhim_Secondary,
    FILENAME = 'C:\Data\QuanLy_RapChieuPhim_Secondary.ndf', -- Đường dẫn file NDF
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
)
LOG ON 
(
    NAME = QuanLy_RapChieuPhim_Log,
    FILENAME = 'C:\Data\QuanLy_RapChieuPhim_Log.ldf', -- Đường dẫn file LDF
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 1MB
);
--============================================================================================
-- Đặt tên file backup và đường dẫn lưu trữ
DECLARE @BackupFile NVARCHAR(255)
SET @BackupFile = N'C:\Backup\QuanLy_RapChieuPhim.bak'

-- Thực hiện backup
BACKUP DATABASE QuanLy_RapChieuPhim
TO DISK = @BackupFile
WITH FORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, STATS = 10;
CREATE DATABASE QuanLy_RapChieuPhim

USE QuanLy_RapChieuPhim
--============================================================================================
SET DATEFORMAT dmy;
CREATE TABLE THELOAI(
MATL NVARCHAR(20) NOT NULL,
TENTHELOAI NVARCHAR(100) NOT NULL,
CONSTRAINT PK_TL PRIMARY KEY (MATL),
CONSTRAINT UQ_TENTHELOAI UNIQUE (TENTHELOAI)
);

CREATE TABLE PHIM(
MAPHIM NVARCHAR(20) NOT NULL,
TENPHIM NVARCHAR(200) NOT NULL,
THOILUONG FLOAT CHECK (THOILUONG > 0),
NGAYPHATHANH DATE,
CONSTRAINT PK_PHIM PRIMARY KEY (MAPHIM)

);

CREATE TABLE PHIM_THELOAI(
MAPHIM NVARCHAR(20) NOT NULL,
MATL NVARCHAR(20) NOT NULL,
PRIMARY KEY (MAPHIM, MATL),
CONSTRAINT FK_TLP1 FOREIGN KEY (MAPHIM) REFERENCES PHIM(MAPHIM),
CONSTRAINT FK_TLP2 FOREIGN KEY (MATL) REFERENCES THELOAI(MATL)
);

CREATE TABLE PHONG(
MAPHONG NVARCHAR(20) NOT NULL,
TENPHONG NVARCHAR(50) NOT NULL,
SOCHONGOI INT CHECK (SOCHONGOI > 0),
CONSTRAINT PK_PHONG PRIMARY KEY (MAPHONG)
);

CREATE TABLE SUATCHIEU(
MASC NVARCHAR(20),
MAPHIM NVARCHAR(20),
MAPHONG NVARCHAR(20),
NGAYCHIEU DATE,
THOIGIANBD TIME,
THOIGIANKT TIME,
CONSTRAINT PK_SC PRIMARY KEY (MASC),
CONSTRAINT FK_SC1 FOREIGN KEY (MAPHIM) REFERENCES PHIM(MAPHIM),
CONSTRAINT FK_SC2 FOREIGN KEY (MAPHONG) REFERENCES PHONG(MAPHONG)
);

CREATE TABLE KHACHHANG(
MAKH NVARCHAR(20),
HOTEN NVARCHAR(100),
SODT CHAR(10) NOT NULL UNIQUE,
CONSTRAINT PK_KH PRIMARY KEY (MAKH)
);
Create table ChucVu
(
	MaCV INT not null primary key,
	TenCV nvarchar(20)
);

CREATE TABLE NHANVIEN
(
	MANV NVARCHAR(20) not null,
	MaCV INT not null,
	TENNV NVARCHAR(100),
	SODT CHAR(10) NOT NULL UNIQUE,
	DiaChi NVARCHAR(100),
	GIOITINH NVARCHAR(5) CHECK (GIOITINH IN (N'Nam', N'Nữ', N'Khác')),	
	Luong float NOT NULL,
	AnhThe varchar(200),
	CONSTRAINT PK_NV PRIMARY KEY (MANV),
	constraint FK_NV_CV foreign key(MaCV) references ChucVu(MaCV)
);

CREATE TABLE TAIKHOAN 
(
	ID INT IDENTITY(1,1) NOT NULL primary key, 
    TenDN VARCHAR(30) unique,
	MatKhau VARCHAR(25),
	MANV NVARCHAR(20),
	constraint FK_USNV foreign key(MANV) references NHANVIEN(MANV)
)

CREATE TABLE HOADON(
MAHD NVARCHAR(20) not null,
MAKH NVARCHAR(20) not null,
MANV NVARCHAR(20) not null,
NGAYLAP DATE DEFAULT GETDATE(),
THANHTIEN FLOAT CHECK (THANHTIEN >= 0),
CONSTRAINT PK_HD PRIMARY KEY (MAHD),
CONSTRAINT FK_HD1 FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
CONSTRAINT FK_HD2 FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
);

CREATE TABLE VE(
MAVE NVARCHAR(20) not null,
MASUATCHIEU NVARCHAR(20) not null,
MAHD NVARCHAR(20) not null,
TENGHE NVARCHAR(10),
GIAGHE FLOAT CHECK (GIAGHE > 0),
CONSTRAINT PK_VE PRIMARY KEY (MAVE),
CONSTRAINT FK_VE FOREIGN KEY (MASUATCHIEU) REFERENCES SUATCHIEU(MASC),
CONSTRAINT FK_VE2 FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD),
CONSTRAINT UQ_SUATCHIEU_GHE UNIQUE (MASUATCHIEU, TENGHE)
);

CREATE TABLE THUCPHAM(
MATP NVARCHAR(20) not null,
TENTP NVARCHAR(100),
GIATP FLOAT CHECK (GIATP > 0),
SOLUONG INT CHECK (SOLUONG >= 0),
CONSTRAINT PK_TP PRIMARY KEY (MATP)
);

CREATE TABLE CHITIETHD_TP(
MAHD NVARCHAR(20),
MATP NVARCHAR(20),
SOLUONG INT CHECK (SOLUONG > 0),
TONGGIATP FLOAT CHECK (TONGGIATP >= 0),
CONSTRAINT FK_CTTP1 FOREIGN KEY (MAHD) REFERENCES HOADON(MAHD),
CONSTRAINT FK_CTTP2 FOREIGN KEY (MATP) REFERENCES THUCPHAM(MATP)
);



------------------------------------ Nhập dữ liệu ------------------------------------

insert into ChucVu
values
	(1, N'Quản Lý'),
	(2, N'Nhân viên bán vé'),
	(3, N'Nhân viên bán đồ ăn')
go

INSERT INTO THELOAI (MATL, TENTHELOAI)
VALUES
('TL01', N'Hành động'),
('TL02', N'Tình cảm'),
('TL03', N'Kinh dị'),
('TL04', N'Hoạt hình'),
('TL05', N'Phiêu lưu'),
('TL06', N'Hài');

INSERT INTO PHIM (MAPHIM, TENPHIM, THOILUONG, NGAYPHATHANH)
VALUES
('P001', N'CƯỜI XUYÊN BIÊN GIỚI', 113, '15/11/2024'),
('P002', N'VÕ SĨ GIÁC ĐẤU II', 148, '15/11/2024'),
('P003', N'LINH MIÊU', 109, '22/11/2024'),
('P004', N'ĐÔI BẠN HỌC YÊU', 118, '08/11/2024'),
('P005', N'VENOM: KÈO CUỐI', 110, '25/10/2024');

INSERT INTO PHIM_THELOAI (MAPHIM, MATL)
VALUES
('P001', 'TL06'),
('P002', 'TL01'),
('P002', 'TL05'),
('P003', 'TL03'),
('P004', 'TL02'),
('P004', 'TL06'),
('P005', 'TL01'),
('P005', 'TL05');

INSERT INTO PHONG (MAPHONG, TENPHONG, SOCHONGOI)
VALUES
('P01', N'Phòng 1', 30),
('P02', N'Phòng 2', 30),
('P03', N'Phòng 3', 30),
('P04', N'Phòng 4', 30);

-- Nhập dữ liệu cho SUATCHIEU
INSERT INTO SUATCHIEU (MASC, MAPHIM, MAPHONG, NGAYCHIEU, THOIGIANBD, THOIGIANKT)
VALUES
-- Suất chiếu cho phim 'CƯỜI XUYÊN BIÊN GIỚI'
('SC001', 'P001', 'P01', '01/12/2023', '10:00:00', '12:00:00'),
('SC005', 'P001', 'P01', '02/12/2023', '12:00:00', '14:00:00'),
('SC006', 'P001', 'P02', '02/12/2023', '16:00:00', '18:00:00'),

-- Suất chiếu cho phim 'VÕ SĨ GIÁC ĐẤU II'
('SC002', 'P002', 'P02', '01/12/2023', '14:00:00', '16:00:00'),
('SC007', 'P002', 'P02', '02/12/2023', '18:00:00', '20:00:00'),
('SC008', 'P002', 'P03', '02/12/2023', '20:00:00', '22:00:00'),

-- Suất chiếu cho phim 'LINH MIÊU'
('SC003', 'P003', 'P03', '01/12/2023', '18:00:00', '20:00:00'),
('SC009', 'P003', 'P01', '02/12/2023', '14:00:00', '16:00:00'),
('SC010', 'P003', 'P03', '02/12/2023', '22:00:00', '00:00:00'),

-- Suất chiếu cho phim 'ĐÔI BẠN HỌC YÊU'
('SC004', 'P004', 'P04', '01/12/2023', '20:00:00', '22:00:00'),
('SC011', 'P004', 'P01', '02/12/2023', '12:00:00', '14:00:00'),
('SC012', 'P004', 'P02', '02/12/2023', '16:00:00', '18:00:00'),

-- Suất chiếu cho phim 'VENOM: KÈO CUỐI'
('SC013', 'P005', 'P03', '02/12/2023', '14:00:00', '16:00:00'),
('SC014', 'P005', 'P04', '02/12/2023', '20:00:00', '22:00:00');

INSERT INTO KHACHHANG (MAKH, HOTEN, SODT)
VALUES
('KH001', N'Nguyễn Văn A', '0123456789'),
('KH002', N'Trần Thị B', '0987654321'),
('KH003', N'Lê Minh C', '0912345679');

INSERT INTO NHANVIEN 
VALUES
('AD001', 1 , N'Lê Quang D', '0312123456', N'Vô gia cư' , N'Nam', 1000000, null),
('NV001', 2 , N'Phan Thi E','0988776655','Vinhome', N'Nữ' , 300000 , null),
('NV002', 3, N'Nguyễn Thị F', '0912345678', 'Quận 1', N'Nữ',250000, null);

INSERT INTO TAIKHOAN
VALUES
('lequangd', '123456', 'AD001'),
('phanthie', '123456', 'NV001'),
('nguyenthif','123456', 'NV002');

--INSERT INTO HOADON (MAHD, MAKH, MANV, NGAYLAP, THANHTIEN)
--VALUES
--('HD001', 'KH001', 'NV001', '01/12/2023', 500000),
--('HD002', 'KH002', 'NV002', '01/12/2023', 300000);

--INSERT INTO VE (MAVE, MASUATCHIEU, MAHD, TENGHE, GIAGHE)
--VALUES
--('V001', 'SC001', 'HD001', '01', 100000),
--('V002', 'SC002', 'HD002', '02', 150000);

INSERT INTO THUCPHAM (MATP, TENTP, GIATP, SOLUONG)
VALUES
('TP01', N'Bắp ngọt', 59000, 100),
('TP02', N'Bắp phô mai', 74000, 100),
('TP03', N'Nước soda trái cây', 45000, 100),
('TP04', N'Coca cola', 45000, 100),
('TP05', N'7 Up', 45000, 100);

--INSERT INTO CHITIETHD_TP (MAHD, MATP, SOLUONG, TONGGIATP)
--VALUES
--('HD001', 'TP01', 2, 108000),
--('HD002', 'TP02', 1, 74000);



------------------------------------ Quản trị người dùng ------------------------------------

-- Tạo login
sp_addlogin 'lequangd', '123456', 'QuanLy_RapChieuPhim'
sp_addlogin 'phanthie', '123456', 'QuanLy_RapChieuPhim'
sp_addlogin 'nguyenthif', '123456', 'QuanLy_RapChieuPhim'

-- Tạo user
sp_adduser 'lequangd', 'lequangd'
sp_adduser 'phanthie', 'phanthie'
sp_adduser 'nguyenthif', 'nguyenthif'

-- Tạo nhóm quyền
sp_addrole 'Admin'
sp_addrole 'NhanVien_BanVe'
sp_addrole 'NhanVien_BanDoAn'

-- Thêm quyền vào nhóm quyền
-- Admin
GRANT SELECT, INSERT, UPDATE, DELETE ON PHIM TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON SUATCHIEU TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON PHONG TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON NHANVIEN TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TAIKHOAN TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON HOADON TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON VE TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON THUCPHAM TO Admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIETHD_TP TO Admin;

-- Nhân viên bán vé
GRANT SELECT ON PHIM TO NhanVien_BanVe;
GRANT SELECT ON SUATCHIEU TO NhanVien_BanVe;
GRANT SELECT, INSERT, UPDATE ON VE TO NhanVien_BanVe;
GRANT SELECT, INSERT ON KHACHHANG TO NhanVien_BanVe;
GRANT SELECT, INSERT ON HOADON TO NhanVien_BanVe;

-- Nhân viên bán đồ ăn
GRANT SELECT, INSERT, UPDATE ON THUCPHAM TO NhanVien_BanDoAn;
GRANT SELECT, INSERT ON HOADON TO NhanVien_BanDoAn;
GRANT INSERT, UPDATE ON CHITIETHD_TP TO NhanVien_BanDoAn;

-- Add user vào nhóm quyền
sp_addrolemember 'Admin', 'lequangd'
sp_addrolemember 'NhanVien_BanVe', 'nguyenvana'
sp_addrolemember 'NhanVien_BanDoAn', 'nguyenthif'

EXECUTE AS USER = 'lequangd'; -- Đăng nhập như admin
SELECT * FROM PHIM; -- Thử quyền
REVERT;

-----------------------------------------------------------
--NGUYỄN HỒNG HUY BẢO
--Function tạo mã nhân viên ( Nguyễn Hồng Huy Bảo)
CREATE FUNCTION CreateNewMANV()
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @NewMANV NVARCHAR(20);
    DECLARE @MaxMANV NVARCHAR(20);

    SELECT @MaxMANV = MAX(MANV) FROM NHANVIEN;

    IF @MaxMANV IS NULL
    BEGIN
        SET @NewMANV = 'NV0001';
    END
    ELSE
    BEGIN
        DECLARE @CurrentNumber INT;
        SET @CurrentNumber = CAST(SUBSTRING(@MaxMANV, 3, LEN(@MaxMANV) - 2) AS INT) + 1;

        SET @NewMANV = 'NV' + RIGHT('0000' + CAST(@CurrentNumber AS NVARCHAR(20)), 4);
    END

    RETURN @NewMANV;
END;

--Thêm thông tin nhân viên và cấp quyền theo chức vụ (Nguyễn Hồng Huy Bảo)
CREATE PROCEDURE proc_AddNhanVienAndUser
    @MaCV INT,
    @TenNhanVien NVARCHAR(50),
    @SoDienThoai CHAR(10),
    @DiaChi NVARCHAR(100),
    @GioiTinh NCHAR(5),
    @Luong FLOAT,
    @AnhThe VARCHAR(200),
    @TaiKhoanNV VARCHAR(30),
    @PasswordNV VARCHAR(255)
AS
BEGIN
    BEGIN TRANSACTION CapQuyenTK

    BEGIN TRY
        -- Tạo mã nhân viên mới
        DECLARE @MaNhanVien NVARCHAR(20);
        SET @MaNhanVien = dbo.CreateNewMANV();

        INSERT INTO NHANVIEN (MANV, MaCV, TENNV, SODT, DiaChi, GIOITINH, Luong, AnhThe)
        VALUES (@MaNhanVien, @MaCV, @TenNhanVien, @SoDienThoai, @DiaChi, @GioiTinh, @Luong, @AnhThe);

        INSERT INTO TAIKHOAN (TenDN, MatKhau, MANV)
        VALUES (@TaiKhoanNV, @PasswordNV, @MaNhanVien);

        IF NOT EXISTS (SELECT name FROM sys.server_principals WHERE name = @TaiKhoanNV)
        BEGIN
            EXEC sp_addlogin @TaiKhoanNV, @PasswordNV;
        END

        IF NOT EXISTS (SELECT name FROM sys.database_principals WHERE name = @TaiKhoanNV)
        BEGIN
            EXEC sp_adduser @TaiKhoanNV, @TaiKhoanNV;
        END

        DECLARE @CV INT;
        SELECT @CV = MaCV 
        FROM NHANVIEN 
        WHERE MANV = @MaNhanVien;

        IF (@CV IS NULL)
        BEGIN
            PRINT(N'Mã nhân viên không tồn tại!');
        END
        ELSE
        BEGIN
            IF (@CV = 1)
            BEGIN
                EXEC sp_addrolemember 'Admin', @TaiKhoanNV;
            END
            ELSE IF (@CV = 2)
            BEGIN
                EXEC sp_addrolemember 'NhanVien_BanVe', @TaiKhoanNV;
            END
            ELSE IF (@CV = 3)
            BEGIN
                EXEC sp_addrolemember 'NhanVien_BanDoAn', @TaiKhoanNV;
            END
        END

        COMMIT TRANSACTION CapQuyenTK;
        PRINT(N'Cấp quyền thành công!');
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION CapQuyenTK;
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

exec proc_AddNhanVienAndUser 1, N'Nguyễn Hoàng Giang', 012312313, 'Vô gia cư', 'Nam', 120000,null, 'giang', '123'

--Xóa nhân viên và xóa cả login và user trong role
CREATE PROCEDURE proc_DeleteNhanVienAndUser
    @MaNV NVARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION XoaNhanVien

    BEGIN TRY

        IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MANV = @MaNV)
        BEGIN
            PRINT(N'Nhân viên không tồn tại!');
            RETURN;
        END
		DECLARE @TaiKhoanNV VARCHAR(30);
        DECLARE @MaCV INT;
        SELECT @TaiKhoanNV = TenDN, @MaCV = MaCV FROM TAIKHOAN WHERE MANV = @MaNV;

		 IF @TaiKhoanNV IS NOT NULL
        BEGIN
            IF @MaCV = 1
            BEGIN
                EXEC sp_droprolemember 'Admin', @TaiKhoanNV;
            END
            ELSE IF @MaCV = 2
            BEGIN
                EXEC sp_droprolemember 'NhanVien_BanVe', @TaiKhoanNV;
            END
            ELSE IF @MaCV = 3
            BEGIN
                EXEC sp_droprolemember 'NhanVien_BanDoAn', @TaiKhoanNV;
            END

            EXEC sp_droplogin @TaiKhoanNV;
            DELETE FROM TAIKHOAN WHERE TenDN = @TaiKhoanNV;
        END

  
        SELECT @TaiKhoanNV = TenDN, @MaCV = MaCV FROM TAIKHOAN WHERE MANV = @MaNV;

        DELETE FROM NHANVIEN WHERE MANV = @MaNV;

        COMMIT TRANSACTION XoaNhanVien;
        PRINT(N'Xóa nhân viên thành công!');
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION XoaNhanVien;
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO

CREATE PROCEDURE proc_DeleteNhanVienAndUser

--Cập nhật thông tin nhân viên và kể cả thay đổi chức vụ
CREATE PROCEDURE proc_UpdateNhanVien
    @MaNV NVARCHAR(20),
    @MaCV INT,
    @TenNhanVien NVARCHAR(50),
    @SoDienThoai CHAR(10),
    @DiaChi NVARCHAR(100),
    @GioiTinh NCHAR(5),
    @Luong FLOAT,
    @AnhThe VARCHAR(200)
AS
BEGIN
    BEGIN TRANSACTION CapNhatNhanVien

    BEGIN TRY
         IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE MANV = @MaNV)
        BEGIN
            PRINT(N'Nhân viên không tồn tại!');
            RETURN;
        END

         DECLARE @MaCVCu INT; 
        SELECT @MaCVCu = MaCV FROM NHANVIEN WHERE MANV = @MaNV;

         UPDATE NHANVIEN
        SET MaCV = @MaCV,
            TENNV = @TenNhanVien,
            SODT = @SoDienThoai,
            DiaChi = @DiaChi,
            GIOITINH = @GioiTinh,
            Luong = @Luong,
            AnhThe = @AnhThe
        WHERE MANV = @MaNV;

         IF @MaCV <> @MaCVCu
        BEGIN
             DECLARE @TaiKhoanCu VARCHAR(30);
            SELECT @TaiKhoanCu = TenDN FROM TAIKHOAN WHERE MANV = @MaNV;

            -- Xóa vai trò cũ
            IF @MaCVCu = 1
            BEGIN
                EXEC sp_droprolemember 'Admin', @TaiKhoanCu;
            END
            ELSE IF @MaCVCu = 2
            BEGIN
                EXEC sp_droprolemember 'NhanVien_BanVe', @TaiKhoanCu;
            END
            ELSE IF @MaCVCu = 3
            BEGIN
                EXEC sp_droprolemember 'NhanVien_BanDoAn', @TaiKhoanCu;
            END

            -- Thêm vai trò mới
            IF @MaCV = 1
            BEGIN
                EXEC sp_addrolemember 'Admin', @TaiKhoanCu;
            END
            ELSE IF @MaCV = 2
            BEGIN
                EXEC sp_addrolemember 'NhanVien_BanVe', @TaiKhoanCu;
            END
            ELSE IF @MaCV = 3
            BEGIN
                EXEC sp_addrolemember 'NhanVien_BanDoAn', @TaiKhoanCu;
            END
        END

        COMMIT TRANSACTION CapNhatNhanVien;
        PRINT(N'Cập nhật thông tin nhân viên thành công!');
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION CapNhatNhanVien;
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO


--Xem hồ sơ (Huy Bảo)
create proc proc_ViewUser
as
	begin
		select nv.MANV as 'Employee ID', nv.TENNV as 'Name', cv.TenCV as 'Position', nv.SODT as 'Phone number', nv.DiaChi as 'Address', nv.GIOITINH as 'Gender', nv.Luong as 'Salary', us.TenDN as 'Username', us.MatKhau as 'Password'
		from NHANVIEN nv, ChucVu cv, TAIKHOAN us
		where nv.MaCV = cv.MaCV and nv.MANV = us.MANV
	end
go

--Update nhân viên (Huy Bảo)
create proc proc_UpdateEmployee
@MaNhanVien VARCHAR(5), @MaCV INT, @TenNhanVien NVARCHAR(50), @SoDienThoai INT, @DiaChi NVARCHAR(100), @GioiTinh NCHAR(5), @Luong float
as
	begin
		update NhanVien
		set MaCV = @MaCV, TENNV = @TenNhanVien, SODT = @SoDienThoai, DiaChi = @DiaChi, GioiTinh = @GioiTinh, Luong = @Luong
		where MANV = @MaNhanVien
	end

create proc proc_UpdateUserNV 
@MaNhanVien varchar(5), @PasswordNV VARCHAR(255)
as
	begin
		update TAIKHOAN
		set TenDN = @PasswordNV
		where MANV = @MaNhanVien
	end

select * from NhanVien
select * from TAIKHOAN

--------------------------------------------------------------------------
--NGUYỄN NHẬT TRƯỜNG
--=========================================================================================================================================================
-- Proc bán đồ ăn, kiểm tra và cập nhật tồn kho, cập nhật hóa đơn ( Nguyễn Nhật Trường )
CREATE PROCEDURE Sp_BanDoAn
    @MAHD NVARCHAR(20),
    @MATP NVARCHAR(20),
    @SOLUONG INT
AS
BEGIN
    BEGIN TRANSACTION BanDoAn

    BEGIN TRY
        -- Kiểm tra nhập liệu cơ bản
        IF NOT EXISTS (SELECT 1 FROM HOADON WHERE MAHD = @MAHD)
            THROW 51006, 'Mã hóa đơn không tồn tại!', 1

        IF NOT EXISTS (SELECT 1 FROM THUCPHAM WHERE MATP = @MATP)
            THROW 51007, 'Mã thực phẩm không tồn tại!', 1

        -- Lấy thông tin thực phẩm
        DECLARE @GIATP FLOAT
        DECLARE @TONKHO INT

        SELECT @GIATP = GIATP, @TONKHO = SOLUONG
        FROM THUCPHAM
        WHERE MATP = @MATP

        -- Kiểm tra tồn kho
        IF @TONKHO < @SOLUONG
            THROW 51008, 'Không đủ hàng trong kho!', 1

        -- Cập nhật tồn kho
        UPDATE THUCPHAM
        SET SOLUONG = SOLUONG - @SOLUONG
        WHERE MATP = @MATP

        -- Thêm chi tiết hóa đơn
        INSERT INTO CHITIETHD_TP (MAHD, MATP, SOLUONG, TONGGIATP)
        VALUES (@MAHD, @MATP, @SOLUONG, @SOLUONG * @GIATP)

        -- Cập nhật tổng tiền hóa đơn
        UPDATE HOADON
        SET THANHTIEN = THANHTIEN + (@SOLUONG * @GIATP)
        WHERE MAHD = @MAHD

        COMMIT TRANSACTION BanDoAn
        PRINT 'Bán đồ ăn thành công!'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION BanDoAn
        PRINT ERROR_MESSAGE()
    END CATCH
END

-- Chạy thử Sp_BanDoAn
EXEC Sp_BanDoAn 
    @MAHD = 'HD001', 
    @MATP = 'TP01', 
    @SOLUONG = 2

--=========================================================================================================================================================

-- Proc hủy vé, cập nhật hóa đơn ( Nguyễn Nhật Trường )
CREATE PROCEDURE Sp_HuyVe
(
    @MAVE NVARCHAR(20),   -- Mã vé cần hủy
    @MANV NVARCHAR(20)    -- Mã nhân viên thực hiện hủy vé
)
AS
BEGIN
    -- Kiểm tra xem vé có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM VE WHERE MAVE = @MAVE)
    BEGIN
        PRINT 'Vé không tồn tại!'
        RETURN
    END

    -- Lấy thông tin hóa đơn liên quan đến vé để cập nhật thành tiền sau khi hủy vé
    DECLARE @MAHD NVARCHAR(20), @GIAGHE FLOAT
    SELECT @MAHD = VE.MAHD, @GIAGHE = VE.GIAGHE
    FROM VE
    WHERE MAVE = @MAVE

    -- Xóa vé
    DELETE FROM VE WHERE MAVE = @MAVE

    -- Cập nhật lại thành tiền trong bảng HOADON
    UPDATE HOADON
    SET THANHTIEN = THANHTIEN - @GIAGHE
    WHERE MAHD = @MAHD

    PRINT 'Hủy vé thành công!'
END
GO

-- Chạy thử Sp_HuyVe
EXEC Sp_HuyVe @MAVE = 'V001', @MANV = 'NV001';

--=========================================================================================================================================================

-- Proc thêm suất chiếu ( Nguyễn Nhật Trường )
CREATE PROCEDURE SP_ThemSuatChieu
    @MaPhong NVARCHAR(20),
    @NgayChieu DATE,
    @ThoiGianBD TIME,
    @ThoiGianKT TIME,
    @MaPhim NVARCHAR(20),
    @KetQua NVARCHAR(100) OUTPUT
AS
BEGIN
    -- Kiểm tra trùng lịch chiếu trong cùng phòng
    IF EXISTS (
        SELECT 1
        FROM SUATCHIEU
        WHERE MAPHONG = @MaPhong
          AND NGAYCHIEU = @NgayChieu
          AND (
              (CAST(@ThoiGianBD AS DATETIME) BETWEEN CAST(THOIGIANBD AS DATETIME) AND CAST(THOIGIANKT AS DATETIME))
              OR (CAST(@ThoiGianKT AS DATETIME) BETWEEN CAST(THOIGIANBD AS DATETIME) AND CAST(THOIGIANKT AS DATETIME))
              OR (CAST(@ThoiGianBD AS DATETIME) <= CAST(THOIGIANBD AS DATETIME) AND CAST(@ThoiGianKT AS DATETIME) >= CAST(THOIGIANKT AS DATETIME))
          )
    )
    BEGIN
        SET @KetQua = N'Trùng lịch chiếu với suất chiếu khác trong cùng phòng.'
        RETURN;
    END

    -- Tạo mã suất chiếu mới
    DECLARE @MaSC NVARCHAR(20)
    SELECT @MaSC = CONCAT('SC', FORMAT(ISNULL(MAX(CAST(SUBSTRING(MASC, 3, LEN(MASC) - 2) AS INT)), 0) + 1, '000'))
    FROM SUATCHIEU

    -- Thêm suất chiếu mới
    INSERT INTO SUATCHIEU (MASC, MAPHIM, MAPHONG, NGAYCHIEU, THOIGIANBD, THOIGIANKT)
    VALUES (@MaSC, @MaPhim, @MaPhong, @NgayChieu, @ThoiGianBD, @ThoiGianKT)

    SET @KetQua = N'Thêm suất chiếu thành công!'
END
GO

-- Kiểm tra proc
-- TH lỗi
DECLARE @KetQua1 NVARCHAR(100)
EXEC SP_ThemSuatChieu 'P01', '2023-12-01', '10:00:00', '12:00:00', 'P001', @KetQua1 OUTPUT
PRINT @KetQua1

-- TH thành công
DECLARE @KetQua NVARCHAR(100)
EXEC SP_ThemSuatChieu 'P01', '2023-11-25', '10:00:00', '12:00:00', 'P001', @KetQua OUTPUT
PRINT @KetQua

-- Check
SELECT * FROM SUATCHIEU

--=========================================================================================================================================================

-- Proc thêm thực phẩm vào danh sách ( Nguyễn Nhật Trường )
CREATE PROCEDURE SP_ThemThucPham
    @MATP NVARCHAR(20),
    @TENTP NVARCHAR(100),
    @GIATP FLOAT,
    @SOLUONG INT
AS
BEGIN
    BEGIN TRY
        -- Kiểm tra input
        IF @MATP IS NULL OR LEN(@MATP) = 0
        BEGIN
            THROW 51000, 'Mã thực phẩm không được để trống.', 1;
        END

        IF @GIATP <= 0
        BEGIN
            THROW 51001, 'Giá thực phẩm phải lớn hơn 0.', 1
        END

        IF @SOLUONG < 0
        BEGIN
            THROW 51002, 'Số lượng phải >= 0.', 1
        END

        -- Kiểm tra xem thực phẩm đã tồn tại
        IF EXISTS (SELECT 1 FROM THUCPHAM WHERE MATP = @MATP)
        BEGIN
            THROW 51003, 'Mã thực phẩm đã tồn tại. Không thể thêm.', 1
        END

        -- Thêm thực phẩm
        INSERT INTO THUCPHAM (MATP, TENTP, GIATP, SOLUONG)
        VALUES (@MATP, @TENTP, @GIATP, @SOLUONG);

        PRINT 'Thêm thực phẩm thành công.'
    END TRY
    BEGIN CATCH
        PRINT 'Lỗi: ' + ERROR_MESSAGE();
    END CATCH
END

-- Kiểm tra proc
-- TH lỗi
EXEC SP_ThemThucPham 
    @MATP = 'TP01',
    @TENTP = N'Rau Cải',
    @GIATP = 12000,
    @SOLUONG = 5

-- TH thành công
EXEC SP_ThemThucPham 
    @MATP = 'TP06',
    @TENTP = N'Rau Cải',
    @GIATP = 12000,
    @SOLUONG = 5

-- Check
Select * from THUCPHAM

--=========================================================================================================================================================

-- Proc xóa thực phẩm ( Nguyễn Nhật Trường )
CREATE PROCEDURE SP_XoaThucPham
    @MATP NVARCHAR(20)
AS
BEGIN
    BEGIN TRY
        -- Kiểm tra input
        IF @MATP IS NULL OR LEN(@MATP) = 0
        BEGIN
            THROW 51004, 'Mã thực phẩm không được để trống.', 1
        END

        -- Kiểm tra xem thực phẩm có tồn tại
        IF NOT EXISTS (SELECT 1 FROM THUCPHAM WHERE MATP = @MATP)
        BEGIN
            THROW 51005, 'Không tìm thấy thực phẩm với mã đã cho.', 1
        END

        -- Xóa thực phẩm
        DELETE FROM THUCPHAM WHERE MATP = @MATP

        PRINT 'Xóa thực phẩm thành công.'
    END TRY
    BEGIN CATCH
        PRINT 'Lỗi: ' + ERROR_MESSAGE()
    END CATCH
END

-- Kiểm tra proc
-- TH lỗi
EXEC SP_XoaThucPham @MATP = 'TP007'

-- TH thành công
EXEC SP_XoaThucPham @MATP = 'TP06'

--Check
Select * from THUCPHAM

--=========================================================================================================================================================

-- Proc sửa thực phẩm ( Nguyễn Nhật Trường )
CREATE PROCEDURE SP_SuaThucPham
    @MATP NVARCHAR(20),
    @TENTP NVARCHAR(100),
    @GIATP FLOAT,
    @SOLUONG INT
AS
BEGIN
    BEGIN TRY
        -- Kiểm tra input
        IF @MATP IS NULL OR LEN(@MATP) = 0
        BEGIN
            THROW 51006, 'Mã thực phẩm không được để trống.', 1
        END

        IF @GIATP <= 0
        BEGIN
            THROW 51007, 'Giá thực phẩm phải lớn hơn 0.', 1
        END

        IF @SOLUONG < 0
        BEGIN
            THROW 51008, 'Số lượng phải >= 0.', 1
        END

        -- Kiểm tra xem thực phẩm có tồn tại
        IF NOT EXISTS (SELECT 1 FROM THUCPHAM WHERE MATP = @MATP)
        BEGIN
            THROW 51009, 'Không tìm thấy thực phẩm để sửa.', 1
        END

        -- Sửa thông tin thực phẩm
        UPDATE THUCPHAM
        SET TENTP = @TENTP,
            GIATP = @GIATP,
            SOLUONG = @SOLUONG
        WHERE MATP = @MATP

        PRINT 'Sửa thông tin thực phẩm thành công.'
    END TRY
    BEGIN CATCH
        PRINT 'Lỗi: ' + ERROR_MESSAGE()
    END CATCH
END

-- Kiểm tra proc
-- TH lỗi
EXEC SP_SuaThucPham 
    @MATP = 'TP033',
    @TENTP = N'Rau Cải Xanh',
    @GIATP = 15000,
    @SOLUONG = 10

-- TH thành công
EXEC SP_SuaThucPham 
    @MATP = 'TP03',
    @TENTP = N'Rau Cải Xanh',
    @GIATP = 15000,
    @SOLUONG = 10

-- Check
Select * from THUCPHAM

--=========================================================================================================================================================
-- Proc hủy vé, cập nhật hóa đơn ( Nguyễn Nhật Trường )
CREATE PROCEDURE Sp_HuyVe
(
    @MAVE NVARCHAR(20),   -- Mã vé cần hủy
    @MANV NVARCHAR(20)    -- Mã nhân viên thực hiện hủy vé
)
AS
BEGIN
    -- Kiểm tra xem vé có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM VE WHERE MAVE = @MAVE)
    BEGIN
        PRINT 'Vé không tồn tại!'
        RETURN
    END

    -- Lấy thông tin hóa đơn liên quan đến vé để cập nhật thành tiền sau khi hủy vé
    DECLARE @MAHD NVARCHAR(20), @GIAGHE FLOAT
    SELECT @MAHD = VE.MAHD, @GIAGHE = VE.GIAGHE
    FROM VE
    WHERE MAVE = @MAVE

    -- Xóa vé
    DELETE FROM VE WHERE MAVE = @MAVE

    -- Cập nhật lại thành tiền trong bảng HOADON
    UPDATE HOADON
    SET THANHTIEN = THANHTIEN - @GIAGHE
    WHERE MAHD = @MAHD

    PRINT 'Hủy vé thành công!'
END
GO

-- Chạy thử Sp_HuyVe
EXEC Sp_HuyVe @MAVE = 'V001', @MANV = 'NV001';


--------------------------------------------------------------------------
--Trần Chí Cương
CREATE PROCEDURE sp_ThemHoaDon
    @MAHD NVARCHAR(50),
    @MATP NVARCHAR(50),
    @SOLUONG INT,
    @TONGGIATP FLOAT
AS
BEGIN
    BEGIN TRY
        INSERT INTO CHITIETHD_TP (MAHD, MATP, SOLUONG, TONGGIATP)
        VALUES (@MAHD, @MATP, @SOLUONG, @TONGGIATP);
        PRINT 'Thêm thành công';
    END TRY
    BEGIN CATCH
        PRINT 'Lỗi xảy ra: ' + ERROR_MESSAGE();
    END CATCH
END;
-----------
CREATE PROCEDURE sp_SuaHoaDon
    @MAHD NVARCHAR(50),
    @MATP NVARCHAR(50),
    @SOLUONG INT,
    @TONGGIATP FLOAT
AS
BEGIN
    BEGIN TRY
        UPDATE CHITIETHD_TP
        SET SOLUONG = @SOLUONG, TONGGIATP = @TONGGIATP
        WHERE MAHD = @MAHD AND MATP = @MATP;
        PRINT 'Cập nhật thành công';
    END TRY
    BEGIN CATCH
        PRINT 'Lỗi xảy ra: ' + ERROR_MESSAGE();
    END CATCH
END;
-----------
CREATE TRIGGER trg_CalculatingTongGia
ON CHITIETHD_TP
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MATP NVARCHAR(50), @SOLUONG INT, @TONGGIATP FLOAT;

    -- Xử lý trường hợp Insert
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        -- Lấy thông tin từ bảng inserted (chứa dữ liệu vừa được thêm vào)
        SELECT @MATP = MATP, @SOLUONG = SOLUONG FROM inserted;
        SELECT @TONGGIATP = GIATP FROM THUCPHAM WHERE MATP = @MATP;
        -- Cập nhật thành tiền trong bảng `CHITIETHD_TP`
        UPDATE CHITIETHD_TP
        SET TONGGIATP = @TONGGIATP * @SOLUONG
        WHERE MATP = @MATP;
    END

    -- Xử lý trường hợp Update
    IF EXISTS (SELECT * FROM CHITIETHD_TP)
    BEGIN
        -- Lấy thông tin từ bảng updated (chứa dữ liệu vừa được cập nhật)
        SELECT @MATP = MATP, @SOLUONG = SOLUONG FROM CHITIETHD_TP;
        SELECT @TONGGIATP = GIATP FROM THUCPHAM WHERE MATP = @MATP;
        UPDATE CHITIETHD_TP
        SET TONGGIATP = @TONGGIATP * @SOLUONG
        WHERE MATP = @MATP;
    END
END


--==============================================================================
--(Hà Minh Tiến)
-- Chức năng đặt vé
-- 1. Trigger kiểm tra số ghế trùng lặp khi thêm vé(Hà Minh Tiến)
CREATE TRIGGER tg_KiemTraGheTrung
ON VE
INSTEAD OF INSERT
AS
BEGIN
    -- Kiểm tra nếu có vé đã được đặt cho suất chiếu và ghế
    IF EXISTS (
        SELECT 1
        FROM VE ve, inserted
        WHERE ve.MASUATCHIEU = inserted.MASUATCHIEU
        AND ve.TENGHE = inserted.TENGHE
    )
    BEGIN
        -- Nếu đã có vé, ngừng hành động chèn
        RAISERROR ('Ghế đã được đặt cho suất chiếu này.', 16, 1);
    END
    ELSE
    BEGIN
        -- Nếu không có vé trùng, thực hiện chèn dữ liệu bình thường
        INSERT INTO VE (MAVE, MASUATCHIEU, MAHD, TENGHE, GIAGHE)
        SELECT MAVE, MASUATCHIEU, MAHD, TENGHE, GIAGHE
        FROM inserted;
    END
END

--drop trigger tg_KiemTraGheTrung

-- 2. Trigger cập nhật tổng doanh thu của hóa đơn(Hà Minh Tiến)
CREATE TRIGGER tg_CapNhatThanhTienHD
ON VE
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE HOADON
    SET THANHTIEN = (SELECT SUM(GIAGHE) FROM VE WHERE MAHD = HOADON.MAHD)
    WHERE MAHD IN (SELECT MAHD FROM INSERTED UNION SELECT MAHD FROM DELETED);
END

drop trigger tg_CapNhatThanhTienHD

-- 3. Thêm khách hàng mới
CREATE PROCEDURE proc_ThemKH
    @MAKH NVARCHAR(20),
    @HOTEN NVARCHAR(50),
    @SODT NVARCHAR(15)
AS
BEGIN
    INSERT INTO KHACHHANG (MAKH, HOTEN, SODT)
    VALUES (@MAKH, @HOTEN, @SODT);
END
GRANT EXECUTE ON proc_ThemKH TO phanthie;

-- 4. Tạo hóa đơn mới(Hà Minh Tiến)
CREATE PROCEDURE proc_TaoHD
    @MAHD NVARCHAR(20),
    @MAKH NVARCHAR(20),
    @MANV NVARCHAR(20),
    @NGAYLAP DATE
AS
BEGIN
    INSERT INTO HOADON (MAHD, MAKH, MANV, NGAYLAP)
    VALUES (@MAHD, @MAKH, @MANV, @NGAYLAP);
END
GRANT EXECUTE ON proc_TaoHD TO phanthie;

-- 5. Thêm vé vào hóa đơn(Hà Minh Tiến)
CREATE PROCEDURE proc_ThemVe
    @MAVE NVARCHAR(20),
    @MASUATCHIEU NVARCHAR(20),
    @MAHD NVARCHAR(20),
    @TENGHE INT,
	@GIAGHE DECIMAL
AS
BEGIN
    INSERT INTO VE (MAVE, MASUATCHIEU, MAHD, TENGHE, GIAGHE)
    VALUES (@MAVE, @MASUATCHIEU, @MAHD, @TENGHE, @GIAGHE);
END
GRANT EXECUTE ON proc_ThemVe TO phanthie;

-- 6. Procduce hiển thị phim(Hà Minh Tiến)
CREATE PROC proc_HienThiPhim
@ngaychieu DATE
AS
BEGIN
	SELECT DISTINCT p.MAPHIM, p.TENPHIM
	FROM SUATCHIEU sc, PHIM p
	WHERE sc.MAPHIM = p.MAPHIM AND NGAYCHIEU = @ngaychieu
END
GRANT EXECUTE ON proc_HienThiPhim TO phanthie;

SELECT * 
FROM dbo.func_CapNhatGheTrung('2024-12-01', 'P001', 'SC001');


-- 7. Procduce hiển thị suất chiếu(Hà Minh Tiến)
CREATE PROCEDURE proc_GetSuatChieu
    @maPhim NVARCHAR(50),
    @ngayChieu DATE
AS
BEGIN
    SELECT 
        MASC, 
        MAPHIM, 
        NGAYCHIEU, 
        CONCAT(LEFT(THOIGIANBD, 5), ' - ', LEFT(THOIGIANKT, 5)) AS ThoiGian
    FROM 
        SUATCHIEU
    WHERE 
        MAPHIM = @maPhim
        AND NGAYCHIEU = @ngayChieu
END

GRANT EXECUTE ON proc_GetSuatChieu TO phanthie;

exec proc_GetSuatChieu 'P001', '01-12-2024'


-- 8. Function sinh mã tự động(Hà Minh Tiến)
CREATE FUNCTION func_SinhMaTuDong
(
    @tt NVARCHAR(10),  -- Tiền tố (VD: 'HD', 'KH')
    @tenBang NVARCHAR(50),  -- Tên bảng
    @ngay NVARCHAR(8)  -- Ngày định dạng 'ddMMyyyy'
)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @maCuoi NVARCHAR(20)
    DECLARE @maMoi NVARCHAR(20)
    DECLARE @soThuTu INT

    -- Lấy mã cuối cùng theo tiền tố và ngày
    IF (@tenBang = 'HOADON')
    BEGIN
        SET @maCuoi = (
            SELECT TOP 1 MAHD
            FROM HOADON
            WHERE MAHD LIKE @tt + @ngay + '%' -- Điều kiện LIKE dựa trên tiền tố và ngày
            ORDER BY MAHD DESC
        );
    END
	ELSE IF (@tenBang = 'KHACHHANG')
    BEGIN
        SET @maCuoi = (
            SELECT TOP 1 MAKH
            FROM KHACHHANG
            WHERE MAKH LIKE @tt + @ngay + '%'
            ORDER BY MAKH DESC
        );
    END
	ELSE
    BEGIN
        SET @maCuoi = (
            SELECT TOP 1 MAVE
            FROM VE
            WHERE MAVE LIKE @tt + @ngay + '%'
            ORDER BY MAVE DESC
        );
    END

    -- Kiểm tra nếu không có mã nào
    IF @maCuoi IS NULL
    BEGIN
        SET @maMoi = @tt + @ngay + '001'
    END
    ELSE
    BEGIN
        -- Tăng số thứ tự
        SET @soThuTu = CAST(SUBSTRING(@maCuoi, LEN(@tt) + LEN(@ngay) + 1, 3) AS INT) + 1
        SET @maMoi = @tt + @ngay + RIGHT('000' + CAST(@soThuTu AS NVARCHAR), 3)
    END

    RETURN @maMoi
END

drop function func_SinhMaTuDong

GRANT EXECUTE ON func_SinhMaTuDong TO phanthie;

--============================================================================================
-----Thêm Phim(Thanh Trang)
go
CREATE PROCEDURE ThemPhim
    @maphim NVARCHAR(20),
    @tenphim NVARCHAR(200),
    @thoiluong FLOAT,
    @ngayphathanh DATE
AS
BEGIN
    IF @thoiluong <= 0
    BEGIN
        RAISERROR('Thời lượng phim phải lớn hơn 0', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO PHIM (MAPHIM, TENPHIM, THOILUONG, NGAYPHATHANH)
        VALUES (@maphim, @tenphim, @thoiluong, @ngayphathanh);
    END
END;
----goi thu tuc----
EXEC ThemPhim 'P006', N'THÁM TỬ LỪNG DANH', 120, '01/12/2024';

select * from PHIM
-----Sửa Phim (Thanh Trang)
GO
CREATE PROCEDURE SuaPhim
    @maphim NVARCHAR(20),
    @tenphim NVARCHAR(200),
    @thoiluong FLOAT,
    @ngayphathanh DATE
AS
BEGIN
    UPDATE PHIM
    SET TENPHIM = @tenphim, THOILUONG = @thoiluong, NGAYPHATHANH = @ngayphathanh
    WHERE MAPHIM = @maphim;
END;
---Gọi thủ tục
EXEC SuaPhim 'P002', N'VÕ SĨ GIÁC ĐẤU III', 150, '2024-12-15';
-----Xóa Phim (Thanh Trang)
GO
CREATE PROCEDURE XoaPhim
    @maphim NVARCHAR(20)
AS
BEGIN
    DELETE FROM PHIM_THELOAI WHERE MAPHIM = @maphim;
    DELETE FROM SUATCHIEU WHERE MAPHIM = @maphim;
    DELETE FROM PHIM WHERE MAPHIM = @maphim;
END;
----Gọi thủ tục
EXEC XoaPhim 'P003';
------FUNCTION----
----Lấy Danh Sách Phim Theo Thể Loại (Thanh Trang)
GO
CREATE FUNCTION LayPhimTheoTheLoai(@matl NVARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT PHIM.MAPHIM, PHIM.TENPHIM, PHIM.THOILUONG, PHIM.NGAYPHATHANH
    FROM PHIM
    JOIN PHIM_THELOAI ON PHIM.MAPHIM = PHIM_THELOAI.MAPHIM
    WHERE PHIM_THELOAI.MATL = @matl
);
---sd ham
SELECT * FROM LayPhimTheoTheLoai('TL01');
-------TRIGGER-----
--Tự Động Xóa Suất Chiếu Khi Xóa Phim (Thanh Trang)
go
CREATE TRIGGER XoaSuatChieuKhiXoaPhim
ON PHIM
AFTER DELETE
AS
BEGIN
    DELETE FROM SUATCHIEU
    WHERE MAPHIM IN (SELECT MAPHIM FROM deleted);
END;
----Kiểm Tra Thể Loại Phim Trùng (Thanh Trang)
go
CREATE TRIGGER CheckTheLoaiTrung
ON PHIM_THELOAI
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM PHIM_THELOAI pt
        JOIN inserted i ON pt.MAPHIM = i.MAPHIM AND pt.MATL = i.MATL
    )
    BEGIN
        RAISERROR('Thể loại đã tồn tại cho phim này!', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO PHIM_THELOAI SELECT * FROM inserted;
    END
END;
----CURSOR----- 
----Xóa Phim Có Thời Lượng Dưới 90 Phút (Thanh Trang)
GO
CREATE PROCEDURE XoaPhimThoiLuongNgan
AS
BEGIN
    DECLARE @maphim NVARCHAR(20);

    DECLARE cur CURSOR FOR 
    SELECT MAPHIM FROM PHIM WHERE THOILUONG < 90;

    OPEN cur;
    FETCH NEXT FROM cur INTO @maphim;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC XoaPhim @maphim;
        FETCH NEXT FROM cur INTO @maphim;
    END;

    CLOSE cur;
    DEALLOCATE cur;
END;
-------Gọi thủ tục:
EXEC XoaPhimThoiLuongNgan;