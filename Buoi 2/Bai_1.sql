-- Khai báo biến @hoten có kiểu dữ liệu là varchar(20) và biến @tuoi có kiểu dữ liệu là int
DECLARE @hoten varchar(20)
DECLARE @tuoi int

-- Gán giá trị cho biến @hoten và @tuoi
SET @hoten = 'Nguyen Van Khanh'
SET @tuoi = 20

print 'thong tin' + @hoten + convert(char (3), @tuoi)
