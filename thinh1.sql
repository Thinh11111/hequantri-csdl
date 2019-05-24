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
drop proc p1
create proc p1 @ngay int
as
	select k.TENKH
	from KHACHHANG k,HOADON h
	where k.MAKH=h.MAKH and day(ngay)=@ngay
go
exec p1 27
--2.	Lấy ra danh sách X khách hàng  có tổng trị giá các đơn hàng lớn nhất.
create proc p2 @x int
as
	select top(@x) k.TENKH, sum(SL*GIABAN) trigia 
	from KHACHHANG k, CHITIETHOADON c, HOADON h
	where k.MAKH=h.MAKH and c.MAHD=h.MAHD
	group by k.TENKH
	order by trigia desc
exec p2 4
--3.	Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất.
create proc p3 @x int
as
	select top 1 with ties v.TENVT, sum(SL) slln
	from CHITIETHOADON c, VATTU v
	where c.MAVT=v.MAVT
	group by v.TENVT
	order by slln desc
go
exec p3 4
--4.	Lấy ra danh sách X mặt hàng bán ra có lãi 1t nhất.
alter proc p4 @x int
as
	select top(@x)  c.MAVT,  TENVT, sum((GIABAN-GIAMUA)*SL) laiitnhat
	from CHITIETHOADON c,VATTU v, HOADON h
	where c.MAVT=v.MAVT and h.MAHD=c.MAHD
	group by  c.MAVT, TENVT
	order by laiitnhat asc
go
exec p4 4
--5.	Tính giá trị cho cột khuyến mãi như sau: Khuyến mãi 5% nếu SL >100, 10% nếu SL>500.
create proc p5
as
	update CHITIETHOADON set KHUYENMAI=
	case
		when SL>100 and SL<500 then SL*GIABAN*0.05
		when SL>500 then SL*GIABAN*0.1
	else 0
end
exec p5 
select * from CHITIETHOADON

--6.	Tính số lại số lượng tồn cho tất cả các mặt hàng. (SLTON = SLTON – tổng sl bán được)
alter proc p6
as
	update VATTU set SLTON= SLTON-(select sum(SL)
									from CHITIETHOADON
									where VATTU.MAVT=CHITIETHOADON.MAVT)
exec p6
select * from VATTU
--7.	Tính trị giá cho mỗi hoá đơn.
alter proc p7
as
	update HOADON set TONGTG=(select sum(SL*GIABAN)
							from CHITIETHOADON
							where CHITIETHOADON.MAHD=HOADON.MAHD )
	
exec p7
select * from HOADON
--8.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10000000 vào table KH_VIP
