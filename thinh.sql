--1.	Viết  hàm tính doanh thu cuả năm.. với năm là tham số truyền  vào.
create function f1 (@nam int)
returns  bigint
begin
	declare @dt bigint
	set @dt=(select sum(SL*GIABAN)
			from HOADON h, CHITIETHOADON c
			where h.MAHD=c.MAHD and YEAR(Ngay)=@nam)
	return @dt
end
print 'doanh thu nam 2000=' +str(dbo.f1(2000))
--2.	Viết  hàm tính doanh thu cuả tháng .. với tháng là tham số truyền  vào.
create function f2(@t int)
returns bigint
begin
	declare @dt bigint
	set @dt=(select sum(SL*GIABAN)
			from HOADON h, CHITIETHOADON c
			where h.MAHD=c.MAHD and month(Ngay)=@t)
	return @dt
end
print 'doanh thu nam thang 6 ' +str(dbo.f2(6))
		

--3.	Viết hàm tính doanh thu của khách hàng với  mã khách hàng là tham số truyền vào.
create function f3(@ma NVARCHAR(10))
returns bigint
begin 
	declare @dt bigint 
	set @dt=(select sum(SL*GIABAN)
				from CHITIETHOADON c, HOADON h, KHACHHANG k
				where c.MAHD=h.MAHD and k.MAKH=h.MAKH and k.MAKH=@ma)
	return @dt
end
print 'doanh thu khach hang' +str(dbo.f3('KH03'))
--4.	Viết hàm tính tổng số lượng bán được cho từng mặt hàng theo tháng với  mã hàng và thàng nhập vào,  nếu tháng không nhập vào tức là tính tất cả các tháng.
alter function f4(@ma nvarchar(10), @t int)
returns bigint
	begin
	declare @sl bigint
	if(@t is NULL)
	set @sl=(select sum(SL)
			from CHITIETHOADON c, VATTU v, HOADON h
			where c.MAVT=v.MAVT and h.MAHD=c.MAHD and v.MAVT=@ma )
	else
	set @sl=(select sum(SL)
			from CHITIETHOADON c, VATTU v, HOADON h
			where c.MAVT=v.MAVT and h.MAHD=c.MAHD and v.MAVT=@ma and MONTH(NGAY)=@t )
return @sl
end
print 'sl thang 6 ' +str(dbo.f4('VT01',6))
--5.	Viết hàm tính lãi ((giá bán – trừ giá mua )* slố lượng bán được ) cho từng mặt hàng, với mã mặt hàng là tham số truyền vào. Nếu mã mặt hàng không truyền vào thì tính cho tất cả các mặt hàng.
create function f5 (@mvt nvarchar(10))
returns bigint
begin
	declare @lai bigint
	if(@mvt is null)
		set @lai=(select sum((GIABAN-GIAMUA)*SL) as lai
				from VATTU v, CHITIETHOADON c
				where c.MAVT=v.MAVT)
	else
		set @lai=(select sum((GIABAN-GIAMUA)*SL) as lai
				from VATTU v, CHITIETHOADON c
				where c.MAVT=v.MAVT and v.MAVT=@mvt)
	return @lai
end
print 'doanh thu lai '+str (dbo.f5('VT01')) 
--1.	Lấy ra danh các khách hàng đã mua hàng trong ngày [ngày]…. Với [ngày] là tham số truyền vào.
--2.	Lấy ra danh sách X khách hàng  có tổng trị giá các đơn hàng lớn nhất.
3.	Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất.
4.	Lấy ra danh sách X mặt hàng bán ra có lãi 1t nhất.
5.	Tính giá trị cho cột khuyến mãi như sau: Khuyến mãi 5% nếu SL >100, 10% nếu SL>500.
6.	Tính số lại số lượng tồn cho tất cả các mặt hàng. (SLTON = SLTON – tổng sl bán được)
7.	Tính trị giá cho mỗi hoá đơn.
8.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10000000 vào table KH_VIP
