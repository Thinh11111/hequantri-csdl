1.	Hiển danh sách tất cả các khách hàng gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v1
as
select *
from KHACHHANG
select *
from v1
2.	Hiển danh sách các khách hàng có địa chỉ là “TAN BINH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v2
as
select *
from KHACHHANG
where DIACHI like 'TAN BINH'
select *
from v2

3.	Hiển danh sách các khách hàng có địa chỉ là “BINH CHANH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v3
as
select *
from KHACHHANG
where DIACHI like 'BINH CHANH'
select *
from v3
4.	Hiển danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại
create view v4
as
select *
from KHACHHANG
where DT is NULL
select *
from v4
5.	Hiển danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
create view v5
as
select *
from KHACHHANG
where DT is NULL AND EMAIL is NULL
SELECT *
FROM v5
6.	Hiển danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v6
as
select *
from KHACHHANG
where DT is not NULL and EMAIL is not NULL
select *
from v6
7.	Hiển danh sách tất cả các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
create view v7
as
select *
from VATTU
select *
from v7
8.	Hiển danh sách các vật tư có đơn vị tính là “CAI” gồm mã vật tư, tên vật tư và giá mua.
create view v8
as
select *
from VATTU
where DVT like 'CAI'
select *
from v8
9.	Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
create view v9
as
select *
from VATTU
where GIAMUA > 25000
select *
from v9
10.	Hiển danh sách các vật tư là “GẠCH” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua
create view v10
as
select *
from VATTU
where TENVT like 'GACH%'
select *
from v10
11.	Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
create view v11
as
select *
from VATTU
where GIAMUA >20000 and GIAMUA <40000
select *
from v11
12.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
create view v12
as
select h.MAHD, h.NGAY,k.TENKH,k.DIACHI, k.DT
from HOADON h,KHACHHANG k
where h.MAKH=k.MAKH
select *
from v12
13.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2000.
set dateformat dmy
create view v13
as
select h.MAHD, k.TENKH, k.DIACHI, k.DT
from HOADON h, KHACHHANG k
where h.MAKH=k.MAKH and NGAY = '25/5/2000'
select *
from v13
14.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hoá đơn trong tháng 6/2000.
create view v14
as
select h.MAHD,h.NGAY, k.TENKH, k.DIACHI , k.DT
from HOADON h, KHACHHANG k
where h.MAKH=k.MAKH and month(h.NGAY)=6 and YEAR(h.NGAY)=2000
select *
from v14

15.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
create view v15
as
select h.MAHD, h.NGAY,k.TENKH,k.DIACHI, k.DT
from HOADON h,KHACHHANG k
where h.MAKH=k.MAKH
select *
from v15
16.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2000.
create view v16
as
select k.TENKH, k.DIACHI, k.DT
from HOADON h, KHACHHANG k
where h.MAKH=k.MAKH and month(h.NGAY)=6 and year(h.NGAY)=2000
select *
from v16

17.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
create view v17
as
select TENKH, DIACHI, DT
from KHACHHANG
where MAKH not in(select h.MAKH
					from HOADON h, KHACHHANG k
					where h.MAKH=k.MAKH and month(h.NGAY)=6 and year(h.NGAY)=2000)
select *
from v17
18.	Tạo query để lấy ra các thông tin gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng).
alter view v18
as
select c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, v.GIAMUA*v.SLTON as [tri gia mua] , c.GIABAN*c.SL as [tri gia ban]
from CHITIETHOADON c, VATTU v
where v.MAVT=c.MAVT
select *
from v18
19.	Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
alter view v19
as
select c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, v.GIAMUA*v.SLTON as [tri gia mua] , c.GIABAN*c.SL as [tri gia ban]
from CHITIETHOADON c, VATTU v
where v.MAVT=c.MAVT and c.GIABAN >= v.GIAMUA
select *
from v19
20.	Tạo query để lấy ra các thông tin gồm mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lơn hơn 100
create view v20
as
select c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL, v.GIAMUA*v.SLTON as [tri gia mua] , sum(c.GIABAN*c.SL) trigiaban,[khuyen mai]=
	case
	when c.SL>100 then sum(c.GIABAN*c.SL)*0.1
	else 0
	end
from CHITIETHOADON c, VATTU v
where v.MAVT=c.MAVT
group by c.MAHD, c.MAVT, v.TENVT, v.DVT, c.GIABAN, v.GIAMUA, c.SL,v.GIAMUA*v.SLTON
select *
from v20

21.	Tìm ra những mặt hàng chưa bán được.
create view v21
as
select b.TENVT
from CHITIETHOADON a, VATTU b
where a.SL=0
select *
from v21
22.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
create view v22
as
select a.MAHD, a.NGAY, b.TENKH, b.DIACHI, b.DT, c.TENVT, c.DVT, c.GIAMUA,d.GIABAN, d.SL, c.GIAMUA*c.SLTON as [tri gia mua] , sum(d.GIABAN*d.SL) trigiaban
from HOADON a, KHACHHANG b, VATTU c, CHITIETHOADON d
where a.MAKH=b.MAKH and a.MAHD=d.MAHD and d.MAVT=c.MAVT
group by a.MAHD, a.NGAY, b.TENKH, b.DIACHI, b.DT, c.TENVT, c.DVT, c.GIAMUA,d.GIABAN, d.SL,c.GIAMUA*c.SLTON
select *
from v22
23.	Tạo bảng tổng hợp của tháng 5/2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
 create view v23
 as
 select *
 from v22
 where month(NGAY)=5 and year(NGAY)=2000 
 select *
 from v23 
24.	Tạo bảng tổng hợp của tháng 6/2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
create view v24
 as
 select *
 from v22
 where month(NGAY)=6 and year(NGAY)=2000 
 select *
 from v24
25.	Tạo bảng tổng hợp của quý 1 năm 2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán.
alter view v25
 as
 select *
 from v22
 where month(NGAY) <4 and YEAR(NGAY)=2000 
 select *
 from v25
26.	Lấy ra danh sách các hoá đơn gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
alter view v26
as
select count(a.MAHD) sohoadon, NGAY,TENKH, b.DIACHI ,sum(SL*GIABAN)   tongtrigia 
from CHITIETHOADON a, KHACHHANG b, HOADON c
where a.MAHD=c.MAHD and c.MAKH=b.MAKH
group by c.NGAY,b.TENKH, b.DIACHI ,a.MAHD
select *
from v26
27.	Lấy ra hoá đơn có tổng trị giá lớn nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
create view v27
as
select top 1 with ties count(a.MAHD), a.NGAY, b.TENKH, b.DIACHI, sum(SL*GIABAN)   tongtrigia
from HOADON c, KHACHHANG b, CHITIETHOADON a
where a.MAKH=b.MAKH and 
order by count(a.MAHD), a.NGAY, b.TENKH, b.DIACHI, sum(SL*GIABAN)
28.	Lấy ra hoá đơn có tổng trị giá lớn nhất trong tháng 5/2000 gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
29.	Lấy ra hoá đơn có tổng trị giá nhỏ nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
30.	Đếm xem mỗi khách hàng có bao nhiêu hoá đơn.
31.	Lấy ra các thông tin của khách hàng có số lượng hoá đơn mua hàng nhiều nhất.
32.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
33.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hoá đơn nhất.
34.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
35.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ , số lượng hoá đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hoá đơn để trống)



