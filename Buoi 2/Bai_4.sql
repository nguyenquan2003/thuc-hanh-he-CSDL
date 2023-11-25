CREATE DATABASE ThuVien;
USE db4 ;
CREATE TABLE DOCGIA (
    MADG CHAR(10) PRIMARY KEY,
    TENDG NVARCHAR(255),
    DIACHI NVARCHAR(255)
);
CREATE TABLE SACH (
    MASH CHAR(10) PRIMARY KEY,
    TENSH NVARCHAR(255),
    LOAI NVARCHAR(50),
    NXB NVARCHAR(100),
    NAMXB INT,
    TACGIA NVARCHAR(255),
    TINHTRANG NVARCHAR(20)
);
CREATE TABLE MUONSACH (
    MADG CHAR(10),
    MASH CHAR(10),
    NGAYMUON DATE,
    NGAYTRA DATE,
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    FOREIGN KEY (MASH) REFERENCES SACH(MASH)
);
INSERT INTO DOCGIA (MADG, TENDG, DIACHI)
VALUES (1, 'Nguyen Van A', '123 Duong ABC, Quan 1'),
       (2, 'Tran Thi B', '456 Duong XYZ, Quan 2'),
       (3, 'Le Van C', '789 Duong DEF, Quan 3');
INSERT INTO SACH (MASH, TENSH, LOAI, NXB, NAMXB, TACGIA, TINHTRANG)
VALUES (101, 'Sach 1', 'Loai 1', 'Nha Xuat Ban A', 2020, 'Tac Gia 1', 'Con'),
       (102, 'Sach 2', 'Loai 2', 'Nha Xuat Ban B', 2019, 'Tac Gia 2', 'Het'),
       (103, 'Sach 3', 'Loai 1', 'Nha Xuat Ban A', 2018, 'Tac Gia 3', 'Con');
INSERT INTO MUONSACH (MADG, MASH, NGAYMUON, NGAYTRA)
VALUES (1, 101, '2023-11-01', '2023-11-15'),
       (2, 102, '2023-11-02', '2023-11-16'),
       (1, 103, '2023-11-03', '2023-11-17');

--Viết thủ tục truyền vào tham số mã đọc giả sẽ trả về tên đọc giả và địa chỉ.
CREATE PROCEDURE GetDocGiaInfo
    @MADG INT
AS
BEGIN
    SELECT TENDG, DIACHI
    FROM DOCGIA
    WHERE MADG = @MADG;
END;
EXEC GetDocGiaInfo @MADG = 3; -- Thay thế 1 bằng mã đọc giả bạn muốn truy vấn
--Thủ tục truyền vào mã sách để trả về tên sách, năm xuất bản và tác giả:
CREATE PROCEDURE GetSachInfo
    @MASH INT
AS
BEGIN
    SELECT TENSH, NAMXB, TACGIA
    FROM SACH
    WHERE MASH = @MASH;
END;
EXEC GetSachInfo @MASH = 101; -- Thay thế 101 bằng mã sách bạn muốn truy vấn
--Viết thủ tục truyền vào tham số mã sách sẽ trả về tên sách, năm xuất bản và tác giả.
CREATE PROCEDURE GetBookInfo
    @MASH CHAR(10)
AS
BEGIN
    SELECT TENSH AS 'Tên Sách', NAMXB AS 'Năm Xuất Bản', TACGIA AS 'Tác Giả'
    FROM SACH
    WHERE MASH = @MASH;
END;
EXEC GetBookInfo @MASH = '101';
--Viết thủ tục truyền vào tham số mã đọc giả sẽ trả về số lượng sách mà đọc giả đang
--mượn, nếu không có sách nào đang mượn thì trả về 0 (ghi chú: sách chưa trả thì ngày
--trả có giá trị NULL)
CREATE PROCEDURE GetBorrowedBookCount
    @MADG CHAR(10)
AS
BEGIN
    DECLARE @BorrowedCount INT;
    
    SELECT @BorrowedCount = COUNT(*)
    FROM MUONSACH
    WHERE MADG = @MADG AND NGAYTRA IS NULL;
    
    IF @BorrowedCount IS NULL
        SET @BorrowedCount = 0;
    
    SELECT @BorrowedCount AS 'Số Lượng Sách Đang Mượn';
END;
EXEC GetBorrowedBookCount @MADG = 'DG001';
--Viết thủ tục truyền vào mã sách sẽ trả về tên đọc giả nếu đọc giả đang mượn sách
--đó, nếu sách hiện không có đọc giả nào mượn thì trả về ‘chua muon’
CREATE PROCEDURE GetBorrowingReaderName
    @MASH CHAR(10)
AS
BEGIN
    DECLARE @ReaderName NVARCHAR(50);
    
    SELECT @ReaderName = DG.TENDG
    FROM MUONSACH AS MS
    JOIN DOCGIA AS DG ON MS.MADG = DG.MADG
    WHERE MS.MASH = @MASH AND MS.NGAYTRA IS NULL;
    
    IF @ReaderName IS NULL
        SET @ReaderName = 'chua muon';
    
    SELECT @ReaderName AS 'Tên Đọc Giả Đang Mượn';
END;
EXEC GetBorrowingReaderName @MASH = 'SH001';
--Viết thủ tục truyền vào tham số mã đọc giả và ngày/tháng/năm sẽ trả số sách mà đọc
--giả mượn trong ngày/tháng/năm đó, nếu đọc giả không có mượn sách trong ngày đó
--thì trả về 0.
CREATE PROCEDURE GetBorrowedBooksByReaderAndDate
    @MADG CHAR(10),
    @NGAYMUON DATE
AS
BEGIN
    DECLARE @BorrowedBooksCount INT;

    SELECT @BorrowedBooksCount = COUNT(*)
    FROM MUONSACH
    WHERE MADG = @MADG
      AND CONVERT(DATE, NGAYMUON) = @NGAYMUON;

    IF @BorrowedBooksCount IS NULL
        SET @BorrowedBooksCount = 0;

    SELECT @BorrowedBooksCount AS 'Số Sách Đọc Giả Mượn Trong Ngày';
END;
EXEC GetBorrowedBooksByReaderAndDate @MADG = 'DG001', @NGAYMUON = '2023-11-09';
--Viết thủ tục truyền vào mã sách sẽ trả về ngày/tháng/năm mà sách đó được mượn
--gần nhất.
CREATE PROCEDURE GetLastBorrowedDateByBook1
    @MASH CHAR(10)
AS
BEGIN
    DECLARE @LastBorrowedDate DATE;

    SELECT TOP 1 @LastBorrowedDate = TRY_CAST(NGAYMUON AS DATE)
    FROM MUONSACH
    WHERE MASH = @MASH
    ORDER BY NGAYMUON DESC;

    IF @LastBorrowedDate IS NULL
        SET @LastBorrowedDate = 'Chưa Được Mượn';

    SELECT @LastBorrowedDate AS 'Ngày Mượn Gần Nhất';
END;

EXEC GetLastBorrowedDateByBook1 @MASH = 'SH001';
