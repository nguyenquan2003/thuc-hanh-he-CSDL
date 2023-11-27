create function thongtinsv (@masv char(10))
returns table
as
return (select tensv,tenlop from sinhvien inner join lop on lop.malop = sinhvien.malop where masv = @masv) 


select * from dbo.thongtinsv1('SV01')

create function thongtinsv1 (@masv char(10))

returns @ttsv table (tensv nvarchar (40),tenlop nvarchar (20))
as
begin
	insert into @ttsv
	select tensv,tenlop from sinhvien inner join lop on lop.malop = sinhvien.malop where masv = @masv
	return
end


create function ds_monhoc (@k int  = 1)
returns @dsmonhoc table (mamh nchar(10),tenmh nvarchar(50),sotiet int)
begin

	if( @k=1)
			insert into @dsmonhoc	
				select *from monhoc where sotiet <=30
	else if( @k=2)
		insert into @dsmonhoc
			select * from monhoc where sotiet>30 and sotiet <=60
	else
		insert into @dsmonhoc
			select * from monhoc where sotiet >60
	return
end

select * from dbo.ds_monhoc(2)

		
use master
CREATE DATABASE  DB_QLTHUVIEN 
use DB_QLTHUVIEN
CREATE TABLE SACH
(
	MASH CHAR(10),
	TENSH NVARCHAR(40),
	TACGIA NVARCHAR (40),
	LOAI NVARCHAR (40),
	TINHTRANG NVARCHAR (40),
	CONSTRAINT PK_SACH PRIMARY KEY (MASH) 
)


CREATE TABLE DOCGIA
(
	MADG CHAR(10),
	TENDG NVARCHAR (40),
	TUOI INT ,
	PHAI NCHAR(4),
	DIACHI NVARCHAR(40),
	CONSTRAINT PK_DOCGIA PRIMARY KEY (MADG)
)

CREATE TABLE MUONSACH
(
	MADG CHAR (10),
	MASH CHAR (10),
	NGAYMUON DATE,
	NGAYTRA DATE,
	CONSTRAINT PK_MUONSACH PRIMARY KEY (MADG,MASH,NGAYMUON)
)

ALTER TABLE DOCGIA
ALTER COLUMN PHAI NVARCHAR(5)

ALTER TABLE DOCGIA
ADD SDT CHAR(10),
	EMAIL NVARCHAR(20)
ALTER TABLE SACH 
ADD NHAXB NVARCHAR(20)

ALTER TABLE DOCGIA
ADD CONSTRAINT CHK_TUOI CHECK (TUOI>15)

ALTER TABLE DOCGIA
ADD CONSTRAINT CHK_GIITINH CHECK (PHAI IN ('NAM',N'NỮ'))

ALTER TABLE SACH
ADD CONSTRAINT CHK_LOAI CHECK (LOAI IN (N'Khoa học tự nhiên',N'Xã hội',N'Kinh tế',N'Truyện'))




ALTER TABLE SACH
ADD CONSTRAINT DF_TINHTRANG DEFAULT ('Chua muon') FOR TINHTRANG

ALTER TABLE DOCGIA 
ADD CONSTRAINT DF_DIACHI DEFAULT ('Chua xac dinh') FOR DIACHI

ALTER TABLE SACH
ADD CONSTRAINT UNI_TENSACH UNIQUE (TENSH)



INSERT INTO SACH (MASH, TENSH, TACGIA, LOAI, TINHTRANG)
VALUES
('S001', N'Sách 1', N'Tác giả 1', N'Khoa học tự nhiên', N'Chua muon'),
('S002', N'Sách 2', N'Tác giả 2', N'Xã hội', N'Chua muon'),
('S003', N'Sách 3', N'Tác giả 3', N'Kinh tế', N'Chua muon');

insert into sach (MASH, TENSH, TACGIA, LOAI, TINHTRANG)
values ('S004',N'Sách 4',N'Tác giả 4',N'Chính trị',N'Da muon')

INSERT INTO DOCGIA (MADG, TENDG, TUOI, PHAI, DIACHI)
VALUES
('DG001', N'Độc giả 1', 20, N'NAM', N'Địa chỉ 1'),
('DG002', N'Độc giả 2', 18, N'NỮ', N'Địa chỉ 2'),
('DG003', N'Độc giả 3', 25, N'NAM', N'Địa chỉ 3');


INSERT INTO MUONSACH (MADG, MASH, NGAYMUON, NGAYTRA)
VALUES
('DG001', 'S001', '2023-11-01', '2023-11-10'),
('DG002', 'S002', '2023-11-02', '2023-11-12'),
('DG003', 'S003', '2023-11-03', '2023-11-15');

INSERT INTO MUONSACH (MADG, MASH, NGAYMUON, NGAYTRA)
VALUES
('DG001', 'S004', '2023-11-01', NULL),

create function ttdocgia (@madg char(10))
returns @dsdocgia table (tendocgia nvarchar(40),diachi nvarchar(40))
begin
	insert into @dsdocgia
		select TENDG,DIACHI from DOCGIA where @madg = MADG
		return
end

select * from dbo.ttdocgia('DG001')


create function thongtinsach (@masach char(10))
returns table 
	return (select TENSH,NHAXB from SACH where @masach = MASH)

select * from dbo.thongtinsach('S001')

create function tinhtrangsachdgmuon (@madocgia char(10))
returns int

begin
	declare @soluong int
	select @soluong = COUNT(MUONSACH.MADG) 
	from DOCGIA inner join MUONSACH on DOCGIA.MADG = MUONSACH.MADG
	where @madocgia = MUONSACH.MADG
	return @soluong
end




create function sach_dgmuon (@masach char(10))
returns table 
	return (select from DOCGIA inner join muon)


	select count(MUONSACH.MADG) as 'So luong'
			from DOCGIA inner join MUONSACH on DOCGIA.MADG = MUONSACH.MADG
			where 'DG004' = MUONSACH.MADG