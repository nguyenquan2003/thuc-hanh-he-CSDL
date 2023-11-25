create database Bai3
use db3
go

CREATE TABLE LOP
(
	MALOP CHAR(10) NOT NULL,
	TENLOP NVARCHAR(30),
	SISO INT,
	CONSTRAINT PK_MALOP PRIMARY KEY(MALOP)
)
CREATE TABLE SINHVIEN
(
	MASV CHAR(10) NOT NULL,
	HOTEN NVARCHAR(50),
	NGSINH DATE,
	GIOITINH NVARCHAR(3),
	QUEQUAN NVARCHAR(50),
	MALOP CHAR(10) NOT NULL, 
	DIEMTB FLOAT,
	XEPLOAI NVARCHAR(10),
	CONSTRAINT PK_MASV PRIMARY KEY(MASV),
	CONSTRAINT FK_MALOP FOREIGN KEY(MALOP) REFERENCES LOP(MALOP)
)
CREATE TABLE MONHOC
(
	MAMH CHAR(10) NOT NULL,
	TENMH NVARCHAR(30),
	SOTC INT,
	BATBUOC NVARCHAR(30),
	CONSTRAINT PK_MAMH PRIMARY KEY(MAMH),
)
CREATE TABLE KETQUA
(
	MASV char(10) not null,
	MAMH char(10) not null,
	HOCKY char(10) not null,
	DIEMTHI float,
	constraint pk_ketqua primary key(MASV,MAMH,HOCKY),
	constraint FK_KQ_SV foreign key(MASV) references SINHVIEN(MASV),
	constraint FK_KQ_MH foreign key(MAMH) references MONHOC(MAMH),
)

--delete from LOP;
insert into LOP VALUES('L01','Lop 1', 30),
('L02','Lop 2', 10),
('L03','Lop 3', 20),
('L04','Lop 4', 50),
('L05','Lop 5', 35),
('L06','Lop 6', 40),
('L07','Lop 7', 20),
('L08','Lop 8', 1);

SET DATEFORMAT DMY
INSERT INTO SINHVIEN
VALUES
('3001090113','Lam Bich Van','06/11/1989','NU','HA NOI','L01',5.1,'TB'),
('3001090344','Nguyen Thanh Nhan','15/08/1988','NAM','THANH HOA','L02',7.2,'KHA'),
('3001100021','Le Mi Nuong','20/04/1991','NU','TP.HCM','L01',4.0,'YEU'),
('3001100073','Trinh Dinh Trong','01/02/1992','NAM','HAI DUONG','L03',8.0,'GIOI'),
('3001100218','Le Van Khanh','24/06/1989','NAM','BAC GIANG','L04',6.8,'TB KHA'),
('3301094455','Chu Bao Chau','12/08/1980','NAM','HA NOI','L05',5.8,'TB'),
('3301096168','Trinh Dinh Thang','11/05/1990','NAM','HUNG YEN','L02',4.7,'YEU'),
('3301100042','Tran Thi Trinh','27/08/1991','NAM','DA NANG','L03',9.0,'GIOI'),
('3303090037','Truong Phu An','11/02/1988','NAM','HUE','L08',6.7,'TB KHA'),
('4001100091','Le Thi Sen','13/11/1986','NU','HA NOI','L05',7.1,'KHA'),
('4001100163','Do Thi Anh Tuyet','14/05/1986','NU','HA NOI','L04',8.2,'GIOI')

INSERT INTO MONHOC
VALUES
('01300012',N'CO SO DU LIEU',3,'BAT BUOC'),
('01300014',N'LY THUYET DO THI',2,'TUCHON'),
('01300019',N'LAP TRINH WINDOWS',2,'BAT BUOC'),
('01300025',N'CAC DICH VU MANG',2,'BAT BUOC'),
('01300031',N'CONG NGHE WEB',3,'TUCHON'),
('01300043',N'LAP TRINH MA NGUON MO',3,'TUCHON')


INSERT INTO KETQUA
VALUES
('3001090113','01300012','1',9.5),
('3001090113','01300014','1',3.0),
('3001090113','01300014','2',7.5),
('3001090344','01300012','1',2.0),
('3001090344','01300019','1',9.5),
('3001090344','01300031','1',6.0),
('3001100218','01300012','1',3.0),
('3001100218','01300012','2',8.0),
('3301094455','01300025','1',7.0),
('3301094455','01300043','1',8.0),
('3301096168','01300019','1',3.0),
('3301096168','01300019','2',4.0),
('3301100042','01300025','1',9.0),
('3303090037','01300012','1',8.0),
('3303090037','01300031','2',6.0)
-- Tạo ràng buộc khóa ngoại giữa bảng SINHVIEN và LOP
ALTER TABLE SINHVIEN
ADD CONSTRAINT FK_MALOP_SV FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);
--Viết thủ tục cập nhật SISO trên bảng LOP dựa vào bảng SINHVIEN:
CREATE PROC UpdateSISo
AS
BEGIN
    UPDATE LOP
    SET SISO = (SELECT COUNT(*) FROM SINHVIEN WHERE SINHVIEN.MALOP = LOP.MALOP)
END
go
EXEC UpdateSISo
select * from LOP
--Viết thủ tục thực hiện cộng 1 điểm cho sinh viên khi truyền vào 3 tham số là mã sinh
--viên và tên môn học và học kỳ.
CREATE PROCEDURE IncreaseStudentScore
    @MaSV CHAR(10),
    @TenMonHoc NVARCHAR(30),
    @HocKy CHAR(10)
AS
BEGIN
    DECLARE @Diem FLOAT

    -- Kiểm tra nếu sinh viên có tồn tại trong bảng KETQUA với các tham số đã cho
    IF EXISTS (SELECT 1 FROM KETQUA
               WHERE MASV = @MaSV AND MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = @TenMonHoc)
               AND HOCKY = @HocKy)
    BEGIN
        -- Lấy điểm hiện tại của sinh viên
        SELECT @Diem = DIEMTHI
        FROM KETQUA
        WHERE MASV = @MaSV AND MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = @TenMonHoc)
        AND HOCKY = @HocKy

        -- Cộng 1 điểm vào điểm hiện tại
        SET @Diem = @Diem + 1

        -- Cập nhật điểm mới
        UPDATE KETQUA
        SET DIEMTHI = @Diem
        WHERE MASV = @MaSV AND MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = @TenMonHoc)
        AND HOCKY = @HocKy
    END
END;
EXEC IncreaseStudentScore '3001090113', 'CO SO DU LIEU', '1';
--Viết thủ tục in ra họ tên và tên lớp của sinh viên khi truyền vào tham số MASV.
CREATE PROCEDURE GetStudentInfo
    @MaSV CHAR(10)
AS
BEGIN
    SELECT SINHVIEN.HOTEN AS 'Ho Ten', LOP.TENLOP AS 'Ten Lop'
    FROM SINHVIEN
    INNER JOIN LOP ON SINHVIEN.MALOP = LOP.MALOP
    WHERE SINHVIEN.MASV = @MaSV
END;
EXEC GetStudentInfo '3001090113';
-- Viết thủ tục trả về họ tên và tổng số môn học mà sinh viên đó học khi truyền vào 2
-- tham số: mã sinh viên và học kỳ
CREATE PROCEDURE GetStudentCourseCount
    @MaSV CHAR(10),
    @HocKy CHAR(10)
AS
BEGIN
    SELECT SINHVIEN.HOTEN AS 'Ho Ten', COUNT(KETQUA.MAMH) AS 'Tong So Mon Hoc'
    FROM SINHVIEN
    INNER JOIN KETQUA ON SINHVIEN.MASV = KETQUA.MASV
    WHERE SINHVIEN.MASV = @MaSV AND KETQUA.HOCKY = @HocKy
    GROUP BY SINHVIEN.HOTEN
END;
EXEC GetStudentCourseCount '3001090113', '1';
--Viết thủ tục khi truyền vào tên môn học và học kỳ sẽ trả về mã môn học, số tín chỉ
--và tổng số sinh viên học môn học trong học kỳ đó
CREATE PROCEDURE GetCourseInfo
    @TenMH NVARCHAR(30),
    @HocKy CHAR(10)
AS
BEGIN
    SELECT MONHOC.MAMH AS 'Ma Mon Hoc', MONHOC.SOTC AS 'So Tin Chi', COUNT(KETQUA.MASV) AS 'Tong So Sinh Vien'
    FROM MONHOC
    LEFT JOIN KETQUA ON MONHOC.MAMH = KETQUA.MAMH
    WHERE MONHOC.TENMH = @TenMH AND KETQUA.HOCKY = @HocKy
    GROUP BY MONHOC.MAMH, MONHOC.SOTC
END;

EXEC GetCourseInfo N'CO SO DU LIEU', '1';
--Viết thủ tục khi truyền vào 3 tham số: mã sinh viên, tên môn học và học kỳ sẽ trả về
--‘chua dang ky’ nếu như sinh viên đó chưa đăng ký môn học, trả về ‘dat’ nếu điểm
--môn đó >=5, trả về ‘khong dat’ neu điểm của môn đó <5.
CREATE PROCEDURE GetCourseStatus
    @MASV CHAR(10),
    @TenMH NVARCHAR(30),
    @HocKy CHAR(10)
AS
BEGIN
    DECLARE @Status NVARCHAR(20)

    SELECT @Status = CASE
        WHEN KETQUA.DIEMTHI >= 5 THEN 'dat'
        WHEN KETQUA.DIEMTHI IS NULL THEN 'chua dang ky'
        ELSE 'khong dat'
    END
    FROM KETQUA
    WHERE KETQUA.MASV = @MASV AND KETQUA.HOCKY = @HocKy AND KETQUA.MAMH = (SELECT MAMH FROM MONHOC WHERE TENMH = @TenMH);

    SELECT @Status AS 'Trang Thai Mon Hoc';
END;
EXEC GetCourseStatus '3001090113', N'CO SO DU LIEU', '1';
--Viết thủ tục trả về điểm trung bình của sinh viên khi truyền vào tham số mã sinh viên
--(HD: Điểm trung bình =(số tín chỉ1 * điểm môn học1+số tín chỉ2*điểm môn
--hoc2+...+số tín chỉ n * điểm môn học n)/tổng số tín chỉ)
CREATE PROCEDURE CalculateAverageScore
    @MASV CHAR(10)
AS
BEGIN
    DECLARE @DiemTB FLOAT

    SELECT @DiemTB = SUM(KETQUA.DIEMTHI * MONHOC.SOTC) / NULLIF(SUM(MONHOC.SOTC), 0)
    FROM KETQUA
    INNER JOIN MONHOC ON KETQUA.MAMH = MONHOC.MAMH
    WHERE KETQUA.MASV = @MASV;

    SELECT @DiemTB AS 'Diem Trung Binh';
END;
EXEC CalculateAverageScore '3001090113';
