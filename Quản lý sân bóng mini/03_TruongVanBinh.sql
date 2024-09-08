CREATE DATABASE QLSanBongMinii

USE QLSanBongMini

Create table NhaBong
(
	 MaNhaBong INT IDENTITY(1,1) PRIMARY KEY,
	 TenNhaBong nvarchar(200),
	 SoDienThoai VARCHAR(11),
	 giomo datetime,
	 giodong datetime,
	 DiaChi nvarchar(200)
)
create table LoaiSanBong
(
	MaLoai INT IDENTITY(1,1) PRIMARY KEY,
	tenLoai nvarchar(200),
	GiaTien bigint,
)

-- Tạo bảng "Sân bóng"
CREATE TABLE SanBong (
   MaSanBong INT IDENTITY(1,1) PRIMARY KEY,
   TenSanBong NVARCHAR(100),
   MaLoai INT,
   MaNhaBong INT,
	CONSTRAINT fk_SB_LOAI FOREIGN KEY (MaLoai) REFERENCES LoaiSanBong(MaLoai),
	CONSTRAINT fk_SB_NhaBong FOREIGN KEY (MaNhaBong) REFERENCES NhaBong(MaNhaBong)
);

create table phanquyen
(
	MaQuyen int IDENTITY(1,1) PRIMARY KEY,
	TenLoaiQuyen nvarchar(255),
)

-- Tạo bảng "Khách hàng"
CREATE TABLE KhachHang (
   MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,
   HoTen NVARCHAR(100),
   SoDienThoai VARCHAR(11),
   Email NVARCHAR(50),
   TenDangNhap VARCHAR(100) unique,
   MatKhau VARCHAR(100),
   MaQuyen int,
   FOREIGN KEY (MaQuyen) REFERENCES phanquyen(MaQuyen)
);

CREATE TABLE DatSan (
    MaDatSan INT IDENTITY(1,1) PRIMARY KEY,
	GioST datetime,
	GioEnd datetime,
    MaSanBong int ,
    MaKhachHang int,
    FOREIGN KEY ( MaSanBong) REFERENCES SanBong(MaSanBong),
    FOREIGN KEY ( MaKhachHang) REFERENCES KhachHang(MaKhachHang)
    -- Thêm các trường thông tin khác nếu cần
);

create table DichVu
(
	maDV  INT IDENTITY(1,1) PRIMARY KEY,
	tenDV nvarchar(100),
	GiaTien bigint,
)
create table HOADON
(
	 MaDatSan INT,
	 maDV int,
	 PRIMARY KEY ( MaDatSan,maDV ),
	 NgayThanhToan date not null,
	 SoLuongDV int,
	 ThanhTien bigint,
	 FOREIGN KEY (MaDatSan) REFERENCES DatSan( MaDatSan),
	 FOREIGN KEY ( maDV) REFERENCES  DichVu(maDV),
	 Trangthai nvarchar(255)
)


-- Thêm dữ liệu vào bảng NhaBong
INSERT INTO NhaBong (TenNhaBong, SoDienThoai, giomo, giodong, DiaChi)
VALUES
('Nha Bong X', '0123456780', '09:00', '21:00', '789 Đường XYZ'),
('Nha Bong Y', '0987654321', '08:30', '22:30', '456 Đường ABC'),
('Nha Bong Z', '0123456789', '10:00', '20:00', '123 Đường MNO'),
('Nha Bong W', '0987654320', '11:00', '23:00', '987 Đường PQR'),
('Nha Bong V', '0123456777', '08:00', '22:00', '654 Đường STU');

-- Thêm dữ liệu vào bảng LoaiSanBong
INSERT INTO LoaiSanBong (tenLoai, GiaTien)
VALUES
('Sân cỏ tự nhiên', 120000),
('Sân cỏ nhân tạo', 90000),
('Sân đất nung', 80000),
('Sân sân ga', 150000),
('Sân gạch', 110000);

-- Thêm dữ liệu vào bảng SanBong
INSERT INTO SanBong (TenSanBong, MaLoai, MaNhaBong)
VALUES
('Sân A1', 1, 1),
('Sân A2', 2, 2),
('Sân B1', 3, 3),
('Sân B2', 4, 4),
('Sân C1', 5, 5);

-- Thêm dữ liệu vào bảng phanquyen
INSERT INTO phanquyen (TenLoaiQuyen)
VALUES
('Quản lý'),
('Khách hàng'),
('Nhân viên');

-- Thêm dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (HoTen, SoDienThoai, Email, TenDangNhap, MatKhau, MaQuyen)
VALUES
('Nguyen Van C', '0123456700', 'nguyenvanc@email.com', 'user3', 'password3', 2),
('Tran Van D', '0987654312', 'tranvand@email.com', 'user4', 'password4', 3),
('Le Thi E', '0123456788', 'lethie@email.com', 'user5', 'password5', 2),
('Pham Van F', '0987654329', 'phamvanf@email.com', 'user6', 'password6', 3),
('Do Van G', '0123456767', 'dovang@email.com', 'user7', 'password7', 2);

INSERT INTO KhachHang (HoTen, SoDienThoai, Email, TenDangNhap, MatKhau)
VALUES
('Nguyen Van Binh', '0123456700', 'nguyenvanc@email.com', 'binh1', '123')

INSERT INTO KhachHang (HoTen, SoDienThoai, Email, TenDangNhap, MatKhau)
VALUES
('Nguyen Van Binh', '0123456700', 'nguyenvanc@email.com', 'binh2', '123')

INSERT INTO KhachHang (HoTen, SoDienThoai, Email, TenDangNhap, MatKhau)
VALUES
('Nguyen Van Binh', '0123456700', 'nguyenvanc@email.com', 'binhsys', '123')

-- Thêm dữ liệu vào bảng DatSan
INSERT INTO DatSan (GioST, GioEnd, MaSanBong, MaKhachHang)
VALUES
('2023-12-11 14:00', '2023-12-11 16:00', 1, 1),
('2023-12-12 10:00', '2023-12-12 12:00', 2, 2),
('2023-12-13 15:00', '2023-12-13 17:00', 3, 3),
('2023-12-14 08:00', '2023-12-14 10:00', 4, 4),
('2023-12-15 18:00', '2023-12-15 20:00', 5, 5);

-- Thêm dữ liệu vào bảng DichVu
INSERT INTO DichVu (tenDV, GiaTien)
VALUES
('Dich Vu C', 60000),
('Dich Vu D', 80000),
('Dich Vu E', 70000),
('Dich Vu F', 90000),
('Dich Vu G', 75000);

-- Thêm dữ liệu vào bảng HOADON
INSERT INTO HOADON (MaDatSan, maDV, NgayThanhToan, SoLuongDV, ThanhTien, Trangthai)
VALUES
(1, 1,'2023-12-13', 2, 120000, 'Đã thanh toán'),
(2, 2,'2023-12-13', 1, 80000, 'Chưa thanh toán'),
(3, 3,'2023-12-13', 3, 210000, 'Đã thanh toán'),
(4, 4,'2023-12-13', 2, 220000, 'Chưa thanh toán'),
(5, 5,'2023-12-13', 1, 75000, 'Đã thanh toán');


--Binh
select * from HOADON where MaDatSan = '1'
--Procedure
--Tim kiem thong tin
CREATE PROCEDURE SearchData
    @TableName NVARCHAR(50),
    @SearchColumn NVARCHAR(50),
    @SearchValue NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON; --là một câu lệnh trong SQL Server được sử dụng để tắt các thông báo số lượng hàng ảnh hưởng bởi một câu lệnh SQL

    DECLARE @SqlQuery NVARCHAR(MAX);

    -- Xây dựng câu truy vấn tìm kiếm dựa trên thông tin người dùng nhập vào
    SET @SqlQuery = 
        'SELECT * FROM ' + QUOTENAME(@TableName) +
        ' WHERE ' + QUOTENAME(@SearchColumn) + ' LIKE ''%' + @SearchValue + '%''';

    -- Thực hiện câu truy vấn
    EXEC sp_executesql @SqlQuery;
END

--Cap nhat thong tin san bong
CREATE PROCEDURE CapNhatThongTinSanBong
    @MaSanBong INT,
    @TenSanBong NVARCHAR(100),
    @MaLoai INT,
    @MaNhaBong INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE SanBong
    SET TenSanBong = @TenSanBong,
        MaLoai = @MaLoai,
        MaNhaBong = @MaNhaBong
    WHERE MaSanBong = @MaSanBong;
END

--Them san bong
CREATE PROCEDURE ThemSanBong
    @TenSanBong NVARCHAR(100),
    @MaLoai INT,
    @MaNhaBong INT
AS
BEGIN
    INSERT INTO SanBong (TenSanBong, MaLoai, MaNhaBong)
    VALUES (@TenSanBong, @MaLoai, @MaNhaBong);
END;

--Xoa san bong
CREATE PROCEDURE XoaSanBong
    @MaSanBong INT
AS
BEGIN
    DELETE FROM SanBong
    WHERE MaSanBong = @MaSanBong;
END;


--Tạo quyên
CREATE PROCEDURE dbo.CreateRole
    @RoleName NVARCHAR(255)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @RoleName AND type = 'R')
    BEGIN
		DECLARE @SqlQuery NVARCHAR(1000);
		BEGIN
			SET @SqlQuery = 'CREATE ROLE ' + QUOTENAME(@RoleName);
			EXEC sp_executesql @SqlQuery;

			INSERT INTO phanquyen (TenLoaiQuyen) VALUES (@RoleName);
		END
	END
END;

--Gán quyền 
CREATE PROCEDURE GrantSelectPermissionToUser
    @UserName NVARCHAR(100),
    @RoleName NVARCHAR(100)
AS
BEGIN
    DECLARE @SqlQuery NVARCHAR(MAX);
    -- Tạo câu lệnh GRANT
    SET @SqlQuery = 'ALTER ROLE ' + QUOTENAME(@RoleName) + ' ADD MEMBER ' + QUOTENAME(@UserName);

    -- Thực hiện câu lệnh GRANT
    EXEC sp_executesql @SqlQuery;
END;

--drop procedure GrantSelectPermissionToUser

--Thu hồi quyền
CREATE PROCEDURE RevokeUserRole
    @UserName NVARCHAR(100),
    @RoleName NVARCHAR(100)
AS
BEGIN
    DECLARE @SqlQuery NVARCHAR(MAX);

    SET @SqlQuery = 'ALTER ROLE ' + QUOTENAME(@RoleName) + ' DROP MEMBER ' + QUOTENAME(@UserName);

    -- Thực hiện câu lệnh ALTER USER
    EXEC sp_executesql @SqlQuery;
END;

--drop procedure RevokeUserRole

--Thêm khả năng truy cập cho role
CREATE PROCEDURE AddPermissionsToRole
    @RoleName NVARCHAR(255),
    @PermissionType NVARCHAR(50), -- Ví dụ: SELECT, INSERT, UPDATE, DELETE
    @TableName NVARCHAR(255)
AS
BEGIN
    DECLARE @SqlQuery NVARCHAR(MAX);
    SET @SqlQuery = '';

    -- Tạo câu lệnh GRANT dựa trên thông tin đầu vào
    SET @SqlQuery = 'GRANT ' + @PermissionType + ' ON OBJECT::' + QUOTENAME(@TableName) + ' TO ' + QUOTENAME(@RoleName);

    -- Thực hiện câu lệnh GRANT
    EXEC sp_executesql @SqlQuery;
END;

--Thu hồi 1 quyền bên trong quyền người dùng định nghĩa
CREATE PROCEDURE RevokePermissionFromRole
    @RoleName NVARCHAR(255),
    @PermissionType NVARCHAR(50), -- Ví dụ: SELECT, INSERT, UPDATE, DELETE
    @TableName NVARCHAR(255)
AS
BEGIN
    DECLARE @SqlQuery NVARCHAR(MAX);
    SET @SqlQuery = '';

    -- Tạo câu lệnh REVOKE dựa trên thông tin đầu vào
    SET @SqlQuery = 'REVOKE ' + @PermissionType + ' ON OBJECT::' + QUOTENAME(@TableName) + ' FROM ' + QUOTENAME(@RoleName);

    -- Thực hiện câu lệnh REVOKE
    EXEC sp_executesql @SqlQuery;
END;


-- Lấy thông tin về tất cả người dùng trong cơ sở dữ liệu hiện tại
--SELECT name FROM sys.database_principals WHERE type_desc = 'SQL_USER';

--Data Source=JONAS\SQLEXPRESS;Initial Catalog=QLSanBongMini;User ID=User01;Password=User01;

SELECT name
FROM sys.schemas
WHERE principal_id = USER_ID('sys');

--ALTER AUTHORIZATION ON SCHEMA::db_datareader TO binh;

--ALTER AUTHORIZATION ON SCHEMA::db_datawriter TO SCHEMA OWNER;

--ALTER AUTHORIZATION ON SCHEMA::db_ddladmin TO dbo;

--Lấy thông tin quyền đang có
CREATE PROCEDURE GetPermissionDetails
    @TenQuyen NVARCHAR(255)
AS
BEGIN
    -- Xem chi tiết về quyền
    SELECT
        DB_NAME() AS DatabaseName,
        dp.class_desc AS ObjectType,
        dp.permission_name AS PermissionType,
        dp.state_desc AS PermissionState,
        USER_NAME(dp.grantee_principal_id) AS Grantee,
        dp.major_id AS ObjectId,
        OBJECT_NAME(dp.major_id) AS ObjectName
    FROM sys.database_permissions dp
    INNER JOIN sys.database_principals dpri ON dp.grantee_principal_id = dpri.principal_id
    WHERE dpri.name = @TenQuyen;
END;

--Function
-- Tạo hàm
CREATE FUNCTION dbo.GetTotalCourtsByType()
RETURNS TABLE
AS
RETURN
(
    SELECT
        L.TenLoai AS TenLoaiSanBong,
        COUNT(S.MaSanBong) AS TongSoSanBong
    FROM
        SanBong S
    INNER JOIN
        LoaiSanBong L ON S.MaLoai = L.MaLoai
    GROUP BY
        L.TenLoai
);

select * from dbo.GetTotalCourtsByType()

--Cursos
DECLARE @TenLoaiSanBong NVARCHAR(100)
DECLARE @TongSoSanBong INT

-- Tạo con trỏ
DECLARE courtCursor CURSOR FOR
SELECT
    L.TenLoai,
    COUNT(S.MaSanBong) AS TongSoSanBong
FROM
    SanBong S
INNER JOIN
    LoaiSanBong L ON S.MaLoai = L.MaLoai
GROUP BY
    L.TenLoai

-- Mở con trỏ
OPEN courtCursor

-- Đọc dữ liệu từ con trỏ
FETCH NEXT FROM courtCursor INTO @TenLoaiSanBong, @TongSoSanBong
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Xử lý dữ liệu tại đây (ví dụ: xuất thông tin ra màn hình)
    PRINT 'Loai San Bong: ' + @TenLoaiSanBong + ', Tong So San Bong: ' + CAST(@TongSoSanBong AS NVARCHAR(10))

    -- Tiếp tục đọc dữ liệu
    FETCH NEXT FROM courtCursor INTO @TenLoaiSanBong, @TongSoSanBong
END

-- Đóng con trỏ
CLOSE courtCursor
DEALLOCATE courtCursor

-- Sử dụng hàm
SELECT * FROM dbo.GetTotalCourtsByType();

-- Tạo trigger kiểm tra giờ mở và giờ đóng của sân bóng
-- Tạo trigger kiểm tra giờ mở phải bé hơn giờ đóng
CREATE TRIGGER CheckSanBongHours
ON NhaBong
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CountInvalid INT;

    SELECT @CountInvalid = COUNT(*)
    FROM NhaBong sb
    INNER JOIN inserted i ON sb.MaNhaBong = i.MaNhaBong
    WHERE i.giomo >= i.giodong;

    IF @CountInvalid > 0
    BEGIN
        print('Giờ mở phải nhỏ hơn giờ đóng của sân bóng.');
        ROLLBACK; -- Nếu có lỗi, hủy bỏ thao tác chèn hoặc cập nhật
    END
END;
insert into NhaBong values ('Nha Bong Sai Gon', '0123456780', '21:00', '9:00', '789 Đường XYZ')



--HUY
--Them KhachHang
CREATE PROCEDURE ThemKhachHang
   @HoTen NVARCHAR(100),
   @SoDienThoai VARCHAR(11),
   @Email NVARCHAR(50),
   @TenDangNhap VARCHAR(100),
   @MatKhau VARCHAR(100),
   @MaQuyen int
AS
BEGIN
    INSERT INTO KhachHang ( HoTen, SoDienThoai, Email, TenDangNhap, MatKhau, MaQuyen)
    VALUES ( @HoTen, @SoDienThoai, @Email, @TenDangNhap, @MatKhau, @MaQuyen);
END;

select * from KhachHang
--Cap nhat thong tin san bong
CREATE PROCEDURE CapNhatThongTinKhachHang
   @MaKhachHang INT,
   @HoTen NVARCHAR(100),
   @SoDienThoai VARCHAR(11),
   @Email NVARCHAR(50),
   @TenDangNhap VARCHAR(100),
   @MatKhau VARCHAR(100),
   @MaQuyen int
 
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE KhachHang
    SET HoTen = @HoTen,
        SoDienThoai = @SoDienThoai,
        Email = @Email,
		TenDangNhap = @TenDangNhap,
		MatKhau = @MatKhau,
		MaQuyen = @MaQuyen
    WHERE MaKhachHang = @MaKhachHang;
END

-- Xóa người dùng và tài khoản SQL tương ứng
CREATE PROCEDURE XoaKhachHang
    @MaKhachHang INT
AS
BEGIN
    DECLARE @TenDangNhap NVARCHAR(100);

    -- Lấy tên đăng nhập từ KhachHang dựa trên MaKhachHang
    SELECT @TenDangNhap = TenDangNhap FROM KhachHang WHERE MaKhachHang = @MaKhachHang;

    -- Xóa người dùng từ KhachHang
    DELETE FROM KhachHang WHERE MaKhachHang = @MaKhachHang;

    -- Kiểm tra nếu có tên đăng nhập, thì xóa tài khoản SQL
    IF @TenDangNhap IS NOT NULL
    BEGIN
        DECLARE @SqlQuery NVARCHAR(MAX);

        -- Tạo câu lệnh DROP LOGIN
        SET @SqlQuery = 'DROP LOGIN ' + QUOTENAME(@TenDangNhap);

        -- Thực hiện câu lệnh 
        EXEC sp_executesql @SqlQuery;

		SET @SqlQuery = 'use QLSanBongMini';
        EXEC sp_executesql @SqlQuery;

		-- Tạo câu lệnh DROP USER
        SET @SqlQuery = 'DROP USER ' + QUOTENAME(@TenDangNhap);

        -- Thực hiện câu lệnh 
        EXEC sp_executesql @SqlQuery;
    END
END;

--drop procedure XoaKhachHang

CREATE FUNCTION TinhTongDoanhThu()
RETURNS INT
AS
BEGIN
    DECLARE @TongDoanhThu INT;

    SELECT @TongDoanhThu = COALESCE(SUM(CONVERT(INT, ThanhTien)), 0)
    FROM HOADON;

    RETURN @TongDoanhThu;
END;


DECLARE @Tongdt INT;
SET @Tongdt = dbo.TinhTongDoanhThu();

-- Displaying the result
SELECT @Tongdt AS TotalRevenue;


-- Tạo stored procedure để thêm người dùng mới
CREATE PROCEDURE CreateUserAccount
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100),
	@RoleName NVARCHAR(100)
AS
BEGIN
    DECLARE @SqlQuery NVARCHAR(MAX);

    -- Tạo câu lệnh CREATE LOGIN dựa trên thông tin đầu vào
    SET @SqlQuery = 'CREATE LOGIN ' + QUOTENAME(@UserName) + ' WITH PASSWORD = ''' + @Password + ''', DEFAULT_DATABASE = QLSanBongMini';

    -- Thực hiện câu lệnh CREATE LOGIN
    EXEC sp_executesql @SqlQuery;

    -- Tạo câu lệnh CREATE USER và gán quyền cho người dùng mới
    SET @SqlQuery = 'CREATE USER ' + QUOTENAME(@UserName) + ' FOR LOGIN ' + QUOTENAME(@UserName);
	EXEC sp_executesql @SqlQuery;

	-- Gán người dùng vào vai trò 'abc'
    SET @SqlQuery = 'ALTER ROLE ' + QUOTENAME(@RoleName) + ' ADD MEMBER ' + QUOTENAME(@UserName);
    EXEC sp_executesql @SqlQuery;
END;

--drop procedure CreateUserAccount
---- Thực hiện stored procedure để thêm người dùng mới
--EXEC CreateUserAccount @UserName = 'binh2', @Password = '123';


--create login binhsys with password = '123', default_database = QLSanBongMini
--use QLSanBongMini
--create user binhsys for login binhsys


--SELECT COUNT(*) FROM sys.syslogins WHERE loginname = 'binh1' and Password = '123'

--SELECT TenLoaiQuyen FROM phanquyen WHERE MaQuyen = 2002

---Sử dụng Cursor để in thông tin khách hàng
CREATE PROCEDURE InThongTinKH
AS
BEGIN
     -- Khai báo biến để lưu giá trị cột
    DECLARE @MaKhachHang INT,
            @HoTen NVARCHAR(100),
            @SoDienThoai VARCHAR(11),
            @Email NVARCHAR(50),
            @TenDangNhap VARCHAR(100),
            @MatKhau VARCHAR(100),
            @MaQuyen INT;

    -- Khai báo con trỏ
    DECLARE kh_cursor CURSOR FOR
    SELECT MaKhachHang, HoTen, SoDienThoai, Email, TenDangNhap, MatKhau, MaQuyen
    FROM KhachHang;

    -- Mở con trỏ
    OPEN kh_cursor;

    -- Lấy dòng đầu tiên vào biến
    FETCH NEXT FROM kh_cursor INTO @MaKhachHang, @HoTen, @SoDienThoai, @Email, @TenDangNhap, @MatKhau, @MaQuyen;

    -- Lặp qua con trỏ
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- In thông tin khách hàng (bạn có thể thay thế điều này bằng hành động mong muốn)
        PRINT 'Customer ID: ' + CAST(@MaKhachHang AS NVARCHAR(10)) +
              ', Name: ' + @HoTen +
              ', Phone: ' + @SoDienThoai +
              ', Email: ' + @Email +
              ', Username: ' + @TenDangNhap +
              ', Password: ' + @MatKhau +
              ', Role ID: ' + CAST(@MaQuyen AS NVARCHAR(10));

        -- Lấy dòng tiếp theo vào biến
        FETCH NEXT FROM kh_cursor INTO @MaKhachHang, @HoTen, @SoDienThoai, @Email, @TenDangNhap, @MatKhau, @MaQuyen;
    END

    -- Đóng và giải phóng con trỏ
    CLOSE kh_cursor;
    DEALLOCATE kh_cursor;
END;

-- Thực thi stored procedure
EXEC InThongTinKH;

---Sử dụng Cursor để in thông tin hóa đơn
CREATE PROCEDURE InThongTinHoaDon
AS
BEGIN
    -- Khai báo biến để lưu giá trị cột
    DECLARE @MaDatSan INT,
            @maDV INT,
            @NgayThanhToan DATE,
            @SoLuongDV INT,
            @ThanhTien BIGINT,
            @Trangthai NVARCHAR(255);

    -- Khai báo con trỏ
    DECLARE hoadon_cursor CURSOR FOR
    SELECT MaDatSan, maDV, NgayThanhToan, SoLuongDV, ThanhTien, Trangthai
    FROM HOADON;

    -- Mở con trỏ
    OPEN hoadon_cursor;

    -- Lấy dòng đầu tiên vào biến
    FETCH NEXT FROM hoadon_cursor INTO @MaDatSan, @maDV, @NgayThanhToan, @SoLuongDV, @ThanhTien, @Trangthai;

    -- Lặp qua con trỏ
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- In thông tin hóa đơn (bạn có thể thay thế điều này bằng hành động mong muốn)
        PRINT 'Mã Đặt Sân: ' + CAST(@MaDatSan AS NVARCHAR(10)) +
              ', Mã Dịch Vụ: ' + CAST(@maDV AS NVARCHAR(10)) +
              ', Ngày Thanh Toán: ' + CAST(@NgayThanhToan AS NVARCHAR(10)) +
              ', Số Lượng Dịch Vụ: ' + CAST(@SoLuongDV AS NVARCHAR(10)) +
              ', Thành Tiền: ' + CAST(@ThanhTien AS NVARCHAR(15)) +
              ', Trạng Thái: ' + @Trangthai;

        -- Lấy dòng tiếp theo vào biến
        FETCH NEXT FROM hoadon_cursor INTO @MaDatSan, @maDV, @NgayThanhToan, @SoLuongDV, @ThanhTien, @Trangthai;
    END

    -- Đóng và giải phóng con trỏ
    CLOSE hoadon_cursor;
    DEALLOCATE hoadon_cursor;
END;

-- Thực thi stored procedure
EXEC InThongTinHoaDon;

--Hàm lấy thông tin hóa đơn 
CREATE FUNCTION LayThongTinHoaDon(@MaDatSan INT)
RETURNS TABLE
AS
RETURN
(
    SELECT MaDatSan, maDV, NgayThanhToan, SoLuongDV, ThanhTien, Trangthai
    FROM HOADON
    WHERE MaDatSan = @MaDatSan
);

-- Sử dụng hàm
SELECT * FROM dbo.LayThongTinHoaDon(1);


--Hàm lấy thông tin khách hàng 
-- Tạo hàm
CREATE FUNCTION LayThongTinKhachHang(@MaKhachHang INT)
RETURNS TABLE
AS
RETURN
(
    SELECT MaKhachHang, HoTen, SoDienThoai, Email, TenDangNhap, MatKhau, MaQuyen
    FROM KhachHang
    WHERE MaKhachHang = @MaKhachHang
);

-- Sử dụng hàm truyền vào tham số là mã khách hàng
SELECT * FROM dbo.LayThongTinKhachHang(1);


--Quân
CREATE PROCEDURE ThemDatSan
    @GioST DATETIME,
    @GioEnd DATETIME,
    @MaSanBong INT,
    @MaKhachHang INT
AS
BEGIN
    INSERT INTO DatSan (GioST, GioEnd, MaSanBong, MaKhachHang)
    VALUES (@GioST, @GioEnd, @MaSanBong, @MaKhachHang);
END