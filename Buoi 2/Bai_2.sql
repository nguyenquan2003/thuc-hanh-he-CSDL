CREATE DATABASE DB2;
USE DB1;
CREATE TABLE SINHVIEN (
    MASV varchar(10) PRIMARY KEY,
    HOTEN varchar(255),
    NGSINH date,
    DIEMTB float
);
INSERT INTO SINHVIEN (MASV, HOTEN, NGSINH, DIEMTB)
VALUES
    ('SV001', 'Nguyen Van A', '1990-01-15', 8.5),
    ('SV002', 'Tran Thi B', '1992-05-20', 7.9),
    ('SV003', 'Le Van C', '1991-11-10', 6.5),
    ('SV004', 'Nguyen Van Khanh', '1982-03-20', 9.2);
DECLARE @hoTenSinhVien varchar(255)
DECLARE @ngaySinhSinhVien date

SELECT @hoTenSinhVien = HOTEN, @ngaySinhSinhVien = NGSINH
FROM SINHVIEN
WHERE MASV = 'SV004';
PRINT 'Sinh vien ' + @hoTenSinhVien + ' co ngay sinh la: ' + CONVERT(varchar(10), @ngaySinhSinhVien, 103);
SELECT 'Ho ten:', @hoTenSinhVien;
SELECT 'Ngay sinh:', @ngaySinhSinhVien;
DECLARE @DIEMTB FLOAT
SET @DIEMTB = 9.2 -- Đổi giá trị của @DIEMTB tùy ý

-- Kiểm tra biến @DIEMTB và xuất ra thông báo tương ứng
IF @DIEMTB < 5
    PRINT 'Yếu'
ELSE IF @DIEMTB >= 5 AND @DIEMTB < 7
    PRINT 'Trung bình'
ELSE IF @DIEMTB >= 7 AND @DIEMTB < 8
    PRINT 'Khá'
ELSE
    PRINT 'Giỏi'

DECLARE @TUOI INT

-- Lấy tuổi của sinh viên 'SV001' từ cơ sở dữ liệu
SELECT @TUOI = DATEDIFF(YEAR, NGSINH, GETDATE()) FROM SINHVIEN WHERE MASV = 'SV001'

-- Kiểm tra tuổi của sinh viên 'SV001' và xuất thông tin tương ứng
IF @TUOI > 30
    SELECT HOTEN, @TUOI AS Tuoi, DIEMTB
    FROM SINHVIEN
    WHERE MASV = 'SV001'
ELSE
    PRINT 'Sinh vien nay duoi 30 tuoi'

DECLARE @TONGSINHVIEN INT

-- Sử dụng câu lệnh IF EXISTS...ELSE để kiểm tra số lượng sinh viên có điểm trung bình > 5
IF EXISTS (SELECT 1 FROM SINHVIEN WHERE DIEMTB > 5)
BEGIN
    SELECT @TONGSINHVIEN = COUNT(*) FROM SINHVIEN WHERE DIEMTB > 5
    PRINT 'Tong so sinh vien tren trung binh la: ' + CAST(@TONGSINHVIEN AS VARCHAR)
END
ELSE
    PRINT 'Khong co sinh vien tren trung binh'
CREATE DATABASE QLSV;
USE DB1;