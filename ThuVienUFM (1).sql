

CREATE TABLE DocGia (
  MaDG			varchar (5) constraint PK_DocGia_MaDG primary key, 
  HoTenDG		varchar (50)  not null,
  NgaySinhDG	date not null, 
  GioiTinhDG	VARCHAR (6) not null constraint CK_DG_GioiTinhDG Check (GioiTinhDG in ('Nam', 'Nu')),
  DthoaiDG		varchar(11) not null, 
  DiachiDG		varchar (50) not null,
  DoiTuong		varchar (15) not null constraint CK_DG_DoiTuong Check (DoiTuong in ('Sinh vien', 'Giang vien', 'Nhan vien')) 
);

--B?ng Th? th? vi?n
CREATE TABLE TheThuVien (
  Mathe			varchar (5) not null Constraint PK_TheThuVien_Mathe Primary key,
  MaDG			varchar (5) not null constraint FK_TheThuVien_MaDG references DocGia(MaDG),
  Ngaytao		date not null,
  HanThe		date not null
);

--B?ng Th? th?
CREATE TABLE ThuThu (
  MaTT			varchar (5) constraint PK_ThuThu_MaTT primary key, 
  HoTenTT		varchar (50)  not null,
  NgaySinhTT	date not null, 
  GioiTinhTT	varchar (6) not null constraint CK_ThuThu_GioiTinhTT Check (GioiTinhTT in ('Nam', 'Nu')),
  DthoaiTT		varchar(11) not null, 
  DiachiTT		varchar (50) not null
);

--B?ng Th? lo?i
CREATE TABLE TheLoai (
	MaLoai		varchar(5) constraint PK_TheLoai_MaLoai primary key,
	TenLoai		varchar(50) not null
);

--B?ng Nhà cung c?p
CREATE TABLE Nhacungcap (
	MaNCC		varchar(5) constraint PK_Nhacungcap_IDNCC primary key,
	TenNCC		varchar(100) not null,
	Diachi		varchar(150),
	Dienthoai	varchar(11) not null,
	Website		varchar(30)
);

--B?ng ??u sách
CREATE TABLE Dausach (
	ISBN			varchar (5) not null  constraint PK_DauSach_ISBN primary key,
	MaLoai			varchar (5)  not null constraint FK_Dausach_MaLoai references TheLoai(MaLoai),
    TenSach			varchar(200) not null,
    Tacgia			varchar(100) not null,
    NXB				varchar(100) not null,
	SoLuong			int not null,
    Thongtinsach	varchar(1500)
);

--B?ng Sách
CREATE TABLE Sach (
    MaSach	varchar (5) not null PRIMARY KEY,
	ISBN	varchar(5) not null constraint FK_Sach_ISBN references DauSach(ISBN),
	Gia		int,
	NamXB	int,
	Ghichu	varchar (20)
);

--B?ng Phi?u m??n
CREATE TABLE PhieuMuon (
  MaM		    varchar (5) constraint PK_PhieuMuon_MaM primary key, 
  MaDG			varchar (5) not null constraint FK_PhieuMuon_MaDG references DocGia(MaDG),
  MaTT			varchar (5) not null constraint FK_PhieuMuon_MaTT references ThuThu(MaTT),
  Ngaymuon	    date  not null,
  Ngayhethan	date  not null, 
  SoLuongM		int not null constraint C_PM_SLM check (SoLuongM IN (1, 2)),
  Ghichu		varchar (30) not null constraint CK_PhieuMuon_Ghichu Check (Ghichu in (N'Muon doc tai cho', 'Muon ve nha'))
);

--B?ng Chi ti?t Phi?u m??n
CREATE TABLE CTPhieuMuon (
  MaM		    varchar (5) not null constraint FK_CTPhieuMuon_MaM references PhieuMuon(MaM),
  MaSach		varchar (5) not null constraint FK_CTPhieuMuon_MaSach references Sach(MaSach),
  constraint PK__CTPhieuMuon primary key (MaM, MaSach)
);

--B?ng Phi?u tr?
CREATE TABLE PhieuTra (
  MaT		    varchar (5) constraint PK_PhieuTra_MaT primary key,
  MaM		    varchar (5) constraint FK_PhieuTra_MaM references PhieuMuon(MaM),
  Ngaytra		date not null,
  SoLuongM		int not null constraint C_PT_SLM check (SoLuongM > 0),
  SoLuongT		int not null constraint C_PT_SLT check (SoLuongT >= 0)
);

--B?ng Lo?i Vi Ph?m
CREATE TABLE LoaiVP (
	MaVP		varchar(5) constraint PK_LoaiVP_MaVP primary key,
	TenLoaiVP	varchar(100) not null,
	CachXuLy	varchar(100) not null
);

--B?ng Chi ti?t Phi?u Tr?
CREATE TABLE CTPhieuTra (
	MaT		varchar (5) constraint FK_CTPhieuTra_MaT references PhieuTra(MaT), 
	MaM		varchar (5) not null constraint FK_CTPhieuTra_MaM references PhieuMuon(MaM),
	MaSach	varchar (5) not null constraint FK_CTPhieuTra_MaSach references Sach(MaSach),
	MaVP	varchar (5) not null constraint FK_CTPhieuTra_MaVP references LoaiVP(MaVP),
	Phat	float not null  constraint C_CTPT_Phat check (Phat >= 0),
	constraint PK__CTPhieuTra primary key (MaM, MaT, MaSach, MaVP)
);

--B?ng Phi?u nh?p
CREATE TABLE PhieuNhap (
    SoPN		varchar (5) not null constraint PK_PhieuNhap_SoPN primary key,
	MaNCC		varchar (5) not null constraint FK_PhieuNhap_MaNCC references Nhacungcap(MaNCC),
	MaTT	    varchar (5) not null constraint FK_PhieuNhap_MaTT references ThuThu(MaTT),
	Ngaytao		date not null,
	Ngaynhap	date
);

--B?ng Chi ti?t Phi?u nh?p
CREATE TABLE CTPhieuNhap (
	SoPN	 varchar(5) not null constraint FK_CTPhieuNhap_SoPN references PhieuNhap(SoPN),
	ISBN	 varchar (5) not null constraint FK_PhieuNhap_ISBN references Dausach(ISBN),
	NamXB	 int not null,
	Soluong	 int not null  constraint C_CTPN_SL check (Soluong > 0),
	Gianhap	 int not null constraint C_CTPN_GN check (Gianhap > 0),
	constraint FK_CTPhieuNhap primary key (SoPN, ISBN)
)

--3. Thêm d? li?u m?u cho các b?ng
--Thêm d? li?u m?u vào b?ng Th? lo?i
    INSERT INTO TheLoai VALUES('TL001','An pham dinh ky');
	INSERT INTO TheLoai VALUES('TL002','Bai trich');
	INSERT INTO TheLoai VALUES('TL003','Bai trich bao, tap chi');
	INSERT INTO TheLoai VALUES('TL004','Bao - tap chi');
	INSERT INTO TheLoai VALUES('TL005','Chuyen de tot nghiep + Bao cao thuc tap');
	INSERT INTO TheLoai VALUES('TL006','Luan an Tien si');
	INSERT INTO TheLoai VALUES('TL007','Luan van Thac si');
	INSERT INTO TheLoai VALUES('TL008','Sach');
    INSERT INTO TheLoai VALUES ('TL009', 'Tieu thuyet lich su');
    INSERT INTO TheLoai VALUES ('TL010', 'Van hoc và tho ca');

--Thêm d? li?u m?u vào b?ng Nhà cung c?p
    INSERT INTO Nhacungcap VALUES('NCC01','Cong Ty Co Phan Phat Hanh Sach Tp. HCM', '60-62 Le Loi, P.Ben Nghe, Q.1, TPHCM','02838225798','www.fahasasg.com.vn');
	INSERT INTO Nhacungcap VALUES('NCC02','Tri Tue - Công Ty Co Phan Sach Va Thiet Bi Giao Duc Tri Tue','187 Giang Vo, Q.Dong Da, Ha Noi', '02438515567','www.nhasachtritue.com');
	INSERT INTO Nhacungcap VALUES('NCC03','Cong Ty TNHH Van Hoa Viet Long','14/35, Dao Duy Anh, P.9, Q.Phu Nhuan,Tp.HCM','02838452708','www.vietlongbook.com');
	INSERT INTO Nhacungcap VALUES('NCC04','Cong Ty TNHH Dang Nguyen', 'Thon Duc My, X.Suoi Nghe, H.Chau Duc, Ba Ria-Vung Tau','02543716857','www.bachdangbook.com/');
	INSERT INTO Nhacungcap VALUES('NCC05','Cong Ty Co Phan Sach Giao Duc Thanh Pho Ha Noi','289A Khuat Duy Tien, Trung Hoa, Cau Giay, Ha Noi', '02462534301','http://sachgiaoduchanoi.vn/');
	INSERT INTO Nhacungcap VALUES('NCC06','Cong Ty Co Phan Dich Vu Xuat Ban Giao Duc Ha Noi','Tang 4 Toa Nha Diamond Flower Tower 48 Lê Van Luong, P.Nhan Chinh, Q.Thanh Xuan Ha Noi','02435121977','www.xbgdhn.vn');
	INSERT INTO Nhacungcap VALUES('NCC07','Truong Dai hoc Tai chinh - Marketing', '778 Nguyen Kiem, P.4, Q.Phu Nhuan, TP.Ho Chi Minh','02839976462','thuvien.ufm.edu.vn');
	INSERT INTO Nhacungcap VALUES('NCC08','Cong Ty CP Sach Va Thiet Bi Truong Hoc Da Nang', '76-78 Bach Dang, Q. Hai Chau, Tp. Da Nang','02363821133','www.danangbook.com');
	INSERT INTO Nhacungcap VALUES('NCC09','Cong Ty TNHH Thuong Mai Dich Vu Quynh Phat', '232 Tran Thu Do, P. Phu Thanh, Q. Tan Phu, Tp. Ho Chi Minh','02838612167','www.quynhphat.com');
	INSERT INTO Nhacungcap VALUES('NCC10','Cong Ty Co Phan Phat Hanh Sach Khanh Hoa', '34-36 Thong Nhat, Tp. Nha Trang, Khanh Hoa','02583822120','www.sachkhanhhoa.vn');

delete from Dausach
--ISBN: D01L1
--Thêm d? li?u m?u vào b?ng ??u sách
    INSERT INTO Dausach VALUES ('D01L1','TL001', 'Kinh te va du bao', 'Bo Ke hoach va dau tu', 'Ha Noi', 7,'Tap chi Kinh te va Dia bao la Co quan cua Bo Ke hoach va Dau tu, phat hanh so dau tien vao thang 10 nam 1967 tren toan quoc. Tap chi Kinh te va Dia bao hoat dong theo Giay phep hoat dong bao chi in so 115/GP-BTTTT, ngay 14/5/2014 cua Bo truong Bo Thong tin va Truyen thong, duoc xuat ban bang tieng Viet va tieng Anh.');
    INSERT INTO Dausach VALUES ('D02L1','TL001', 'Thoi bao Kinh te Sai gon', 'So Cong thuong Tp. HCM', 'Tp.HCM', 3,'Tap chi Kinh te Sai Gon (Saigon Times Group) la ten goi chung cua mot Tap chi gom ba Tap chi tieng Viet (Tap chi Kinh te Sai Gon; Tap chi Kinh te Sai Gon Online; Sai Gon Tiep thi Online); hai Tap chi tieng Anh (Saigon Times Weekly; The Saigon Times), phu trach quang cao Thi truong dia phuong; hai To chuc phi loi nhuan la Saigon Times Club va Saigon Times Foundation');
    INSERT INTO Dausach VALUES ('D03L1','TL001', 'Phat trien kinh te', 'Dai hoc Kinh te Tp.HCM', 'Thanh pho Ho Chi Minh', 2,'Tap chi khoa hoc kinh te xuat ban hang thang');
    
    INSERT INTO Dausach VALUES ('D01L2','TL002', 'Chien luoc phan phoi san pham cua Cong ty TNHH Gia Minh Hong: Thuc trang va giai phap', 'Nguyen The Ngoc Trinh', 'Tp.HCM', 2,'Bac Trung cap K37');
    INSERT INTO Dausach VALUES ('D02L2','TL002', 'Mot so bien phap phong nga va han che rui ro tin dung tai Ngan hang', 'Duong The Thu Thuy', 'Tp.HCM', 1,'Bac cao dang C11');
    INSERT INTO Dausach VALUES ('D03L2','TL002', 'Phat trien cho vay tieu dung tai Ngan hang Thuong mai Co phan A Chau', 'Le Thanh Thuy', 'Tp.HCM', 2,'Bac cao dang C11');
    
    INSERT INTO Dausach VALUES ('D01L3','TL003', 'Nghien cuu chung khoan hoa quoc te - Ham y chinh sach cho Viet Nam', 'Pham Tien Dat', 'Tp.HCM', 2,'Bai bao tac gia nghien cuu ve nghiem vu quy trinh, khung phap ly cho hoat dong chung khoan hoa cua cac quoc gia tren the gioi. tac gia su dung phuong phap phan tich danh gia lap luan de dua ra cac ket luan, ham y. Cac quoc gia duoc tac gia nghien cuu gom Hoa Ky, Nhat, Singapore, Malaysia, Trung Quoc, du lieu nghien cuu tu 1998 - 2021. Tu ket qua nghien cuu tac gia se dua ra cac ham y cho Viet Nam: Khung phap ly cho hoat dong chung khoan hoa, can dong bo cac quy dinh cua Viet Nam, giai phap cho cac cong ty chung khoan va cac ngan hang thuong mai Viet Nam.');
    INSERT INTO Dausach VALUES ('D02L3','TL003', 'Phan tich bien dong gia thi truong ngoai hoi ASEAN-6', 'Ngo Thai Hung, Nguyen Thi Ngoc Ha, Pham Thi Thu Thao, Huynh Thi Thuy Duong', 'Truong Dai hoc Tai chinh - Marketing', 2,'Bai bao nghien cuu ve su bien dong gia giua cac thi truong ngoai hoi cua cac nuoc ASEAN-6 (Indonesia, Malaysia, Philippines, Singapore, Thai Lan va Viet Nam). Du lieu nghien cuu theo ngay: tu 1-1-2018 den 13-2-2023. De tien hanh nghien cuu, chung toi su dung mo hinh Spillover Index duoc phat trien boi Diebold va Yilmaz (2014) de phan tich lan toa ve gia va kiem dinh nhan qua Granger tren tung mien tan so khac nhau cua Breiting va Candelon (2006)');
    INSERT INTO Dausach VALUES ('D03L3','TL003', 'Thanh cong du lich MICE tai thanh pho Can Tho: Tiep can theo cac yeu to long trung thanh diem den', 'Vo Xuan Vinh, Phan Thi Hoan, Tran Dang Khoa, Nguyen Khanh Tung', 'Truong Dai hoc Kinh te Thanh pho Ho Chi Minh, Vien Kinh te - Xa hoi thanh pho Can Tho', 2,'Nghien cuu xem xet tac dong cua cac yeu to chat luong dich vu, hinh anh diem den va su hai long cua khach hang den su thanh cong cua du lich MICE thong qua long trung thanh diem den. Phuong phap mo hinh hoa cau truc SEM da duoc su dung voi mau khao sat la 316 khach du lich da tung den Can Tho it nhat mot lan. Ket qua nghien cuu cho thay tac dong cua cac yeu to den su thanh cong cua diem den du lich la tich cuc va co y nghia thong ke. Tren co so ket qua, tac gia phan tich va dua ra khuyen nghi ve y nghia quan tri doi voi viec dau tu vao cac yeu to hinh anh diem den va chat luong dich vu nham tang su hai long cua du khach va thu hut du khach quay lai tao nen su thanh cong cua diem den du lich MICE Can Tho.');
    INSERT INTO Dausach VALUES ('D04L3','TL003', 'Hoc truc tuyen trong giai doan chuyen doi so: Nghien cuu su hai long cua sinh vien dai hoc tai Thanh pho Ho Chi Minh', 'Vo Thi Kim Ngan, Tran Nguyen Khanh Hai', 'Truong Dai hoc Tai chinh - Marketing', 2,'Dao tao truc tuyen da va dang duoc xem la xu the trong giao duc noi chung va giao duc dai hoc noi rieng, hinh thuc dao tao nay dang duoc nhieu co so giao duc dai hoc trien khai doc lap hoac song hanh voi hinh thuc dao tao truyen thong. Nghien cuu nay duoc thuc hien nham xac dinh cac yeu to tac dong den su hai long cua sinh vien dai hoc tai TPHCM doi voi viec hoc truc tuyen trong giai doan chuyen doi so va de xuat mot so ham y quan tri de gia tang su hai long cua sinh vien doi voi viec hoc truc tuyen. Nghien cuu su dung phuong phap ket hop giua nghien cuu dinh tinh va nghien cuu dinh luong. Du lieu so cap duoc thu thap tu 378 bang cau hoi voi doi tuong la sinh vien dai hoc da va dang tham gia hoc truc tuyen tai TPHCM va duoc xu ly bang phan mem SPSS 20. Ket qua nghien cuu cho thay, cac yeu to anh huong den su hai long cua sinh vien doi voi viec hoc truc tuyen theo muc do tu cao toi thap gom: su tuong tac giua sinh vien va giao vien, su tuong tac giua sinh vien voi noi dung bai hoc, cong nghe, tuong tac giua sinh vien voi sinh vien, giao vien va chuong trinh dao tao. Tu do, tac gia de xuat mot so ham y quan tri ve nang cao nang luc, trinh do cua giao vien, phat trien ky nang, thai do cua sinh vien, xay dung va trien khai noi dung day va hoc nham tang cao su hai long cua sinh vien doi voi viec hoc truc tuyen.');
    INSERT INTO Dausach VALUES ('D05L3','TL003', 'Tac dong cua cam ket voi to chuc den hieu qua cong viec tai doanh nghiep Viet Nam', 'Luu Minh Vung, Cao Van On', 'Truong Dai hoc Cong nghe Dong Nai, Truong Dai hoc Kinh te - Ky thuat Binh Duong', 2,'Nghien cuu nay tim hieu cam ket voi to chuc thong qua cac yeu to khac tac dong den hieu qua cong viec tai doanh nghiep Viet Nam. Su dung phuong phap nghien cuu dinh luong, ky thuat mo hinh cau truc tuyen tinh binh phuong nho nhat tung phan (PLS-SEM) voi co mau la 303 nhan vien lam viec tai TPHCM. Tren nen ly thuyet su phu hop giua con nguoi va to chuc (P-O), ly thuyet tai san nhan vien (EE). Cam ket voi to chuc tac dong manh den hop dong tam va yeu toi duy tri nhan vien, dong thoi hai yeu to nay co tac dong den hieu qua cong viec cua nhan vien, trong do su tac dong cua hop dong tam ly la manh hon so voi duy tri nhan vien. Hon nua, hai gioi tinh (nam, nu) va quy mo doanh nghiep (doanh nghiep lon, doanh nghiep SME) khong co su khac biet co y nghia thong ke doi voi hieu qua cong viec cua nhan vien. Tai boi canh doanh nghiep Viet Nam co it nghien cuu ve chu de nay, do vay nghien cuu da gop phan nho bo sung vao khoang trong nghien cuu. Tuy nhien, nghien cuu co mot so han che nhu moi khao sat cac doanh nghiep Viet Nam tai TPHCM.');

    INSERT INTO Dausach VALUES ('D01L4','TL004', 'Nhung van de kinh te va chinh tri the gioi', 'Vien Han lam Khoa hoc Xa hoi Viet Nam', 'Ha Noi', 2,'Nhung van de kinh te the gioi do Vien Han lam Khoa hoc Xa hoi Viet Nam. Vien Kinh te va Chinh tri the gioi viet');
    INSERT INTO Dausach VALUES ('D02L4','TL004', 'The gioi phu nu. 15 : Phu nu Viet Nam', 'Bao Phu nu Viet Nam','Ha Noi', 5, 'Tap chi The gioi phu nu xuat ban hang tuan tu Bao Phu nu Viet Nam');

    INSERT INTO Dausach VALUES ('D01L5','TL005', 'Nghien cuu cac yeu to anh huong den y dinh mua hang Viet cua nguoi tieu dung Viet tai TPHCM', 'Nguyen Ha Phuong Tram...[va nh.ng. khac] thuc hien', 'TP. Ho Chi Minh', 1,'Bao cao tong ket do tai nghien cuu khoa hoc cua sinh vien, Linh vuc nghien cuu: marketing');
    INSERT INTO Dausach VALUES ('D02L5','TL005', 'Tac dung cua social media va hallyu den quyet dinh mua san pham Han Quoc', 'Truong Thi Hong thuc hien', 'TP. Ho Chi Minh ', 1,'Bao cao tong ket do tai nghien cuu khoa hoc cua sinh vien tham gia xet giai thuong "Tai nang Kinh te tre" - Lan 7, 2018');
    INSERT INTO Dausach VALUES ('D03L5','TL005', 'Nghien cuu cac yeu to anh huong den quyet dinh lua chon HomeStay', 'Le Nhat Kho Vy thuc hien', 'TP. Ho Chi Minh', 2,'Bao cao tong ket do tai nghien cuu khoa hoc cua sinh vien, Linh vuc nghien cuu: Khoa hoc xa hoi');
    INSERT INTO Dausach VALUES ('D04L5','TL005', 'Tac dong nhan thuc cong nghe thuc te ao tang cuong den quyet dinh su dung mua hang da kenh cua nguoi tieu dung tai TP. Ho Chi Minh: Tiep can tu ly thuyet khuech tan doi moi', 'Ha Kien Tan', 'Truong Dai hoc Thuy Loi', 3,'“Hau dai dich Covid-19, hanh vi cua khach hang dang co nhung thay doi lon. Nhieu khach hang chuyen sang hinh thuc mua hang online thong qua cac cong nghe moi nhat trong do co thuc te ao (VR) va cong nghe thuc te ao tang cuong (ARSA). Muc tieu cua bai bao nay tim hieu cac yeu to cong nghe VR va ARSA tac dong den thai do, cam ket va quyet dinh su dung mua hang da kenh Omnichannel thong qua ly thuyet khuech tan doi moi. Bang phuong phap PLS-SEM voi 259 phieu khao sat khach hang tai TPHCM co biet ve cong nghe VR va ARSA cho thay, cac yeu to nhu su phuc tap, kha nang thu nghiem, loi the tuong doi, kha nang tuong thich co tac dong su dung quyet dinh su dung mua hang da kenh Omnichannel thong qua yeu to trung gian thai do va cam ket. Dua tren cac nghien cuu truoc day, vi du nhu su phuc tap (de su dung), loi the tuong doi (tinh huu dung) va thai do, nghien cuu nay se bo sung cac yeu to moi chua duoc kiem dinh tai Viet nam nhu kha nang thu nghiem va kha nang tuong thich, trong cong nghe VR va ARSA. Sau cung de xuat cac so ham quan tri cho cac doanh nghiep de phat trien VR va ARSA tich hop vao da kenh, cung nhu han che va huong nghien cuu tiep theo');
    
    INSERT INTO Dausach VALUES ('D01L6','TL006', 'Thuc va dau tu truc tiep nuoc ngoai tai cac quoc gia dang phat trien', 'Nguyen The Kim Chi', ' Giao duc Viet Nam', 5,'Dau tu truc tiep nuoc ngoai da va dang tac dong manh den nen kinh te the gioi trong nhieu nam qua va la mot chuyen de quan trong doi voi cac quoc gia dang phat trien. De thu hut dau tu truc tiep nuoc ngoai mot cach hieu qua, hau het cac quoc gia phai dieu chinh chinh sach thue va phap luat thue, noi bat voi xu huong canh tranh ve thue voi cac nuoc lang gieng, hoac cac quoc gia cung dieu kien phat trien ve kinh te, xa hoi. Trong do, so voi cac loai thue khac, thue thu nhap doanh nghiep la loai thue truc thu, co co so tinh thue la thu nhap chiu thue cua cac doanh nghiep, nen co y nghia dieu tiet rat nhay cam, co tac dong sau rong den hoat dong san xuat kinh doanh, ke ca doanh nghiep nhan dau tu truc tiep tu nuoc ngoai.');
    INSERT INTO Dausach VALUES ('D02L6','TL006', 'Tac dung cua quan tri cong ty den thanh qua cong ty co phan Viet Nam', 'Pham Duc Huy', ' Giao duc Viet Nam', 2,'Luan an kiem tra tac dung cua quan tri cong ty den thanh qua cong');
    INSERT INTO Dausach VALUES ('D03L6','TL006', 'Tac dong cua gia tri tieu dung va tinh doi moi cua nguoi tieu dung', 'Du Thi Chung; Ngo Thi Thu','TP.HCM', 4,'De tai tim hieu tac dong dong thoi cua gia tri tieu dung, tinh doi bam sinh tinh doi moi theo san pham den y dinh chap nhan va hanh vi chap nhan san pham moi. Phuong phap nghien cuu duoc su dung trong de tai gom ca nghien cuu dinh tinh va dinh luong. Du lieu trong nghien cuu dinh tinh duoc thu thap thong qua cac cuoc thao luan voi 8 chuyen gia va 16 nguoi tieu dung, du lieu trong nghien cuu dinh luong duoc thu thap qua viec khao sat 915 nguoi tieu dung cac san pham dien tu ca nhan, dia diem tai Thanh pho Ho Chi Minh.');

    INSERT INTO Dausach VALUES ('D01L7','TL007','Anh huong cua cac gia tri cam nhan cua khach hang', 'La Thi Bich Hien', 'TP. Ho Chi Minh',5,'Luan van');
    INSERT INTO Dausach VALUES ('D02L7','TL007','Cac yeu to anh huong den y dinh cua khach hang su dung dich vu', 'Nguyen Hoang Bao Ngoc', 'TP. Ho Chi Minh', 2,'Luan van phan tich, xac dinh cac yeu to anh huong den y dinh cua khach hang su dung dich vu kham chua benh tu do de xuat huong xay dung chien luoc khuyen khich benh nhan chon su dung dich vu kham chua benh tai Benh vien Trung Vuong.');

    INSERT INTO Dausach VALUES ('D01L8','TL008','Toan co so cho kinh te', 'Nguyen Huy Hoang (chu bien); Nguyen Trung Dong','TP.HCM : Truong Dai hoc Tai chinh - Marketing', 2, 'Cuon sach nay co 4 chuong va phu luc tinh toan ma tran bang may tinh ca nhan, phu luc mot so thuoc ngu then chot Anh - Viet, cung mot so de tham khao de sinh vien co the ren luyen');
    INSERT INTO Dausach VALUES ('D02L8','TL008','Giao trinh khai pha du lieu', 'Ton That Hoa An (chu bien); Cao Thi Nhan', 'TP.HCM : Truong Dai hoc Tai chinh - Marketing',4, 'Cuon sach nay co 9 chuong duoc bien soan nham cung cap kien thuc co so cho tien trinh kham pha tri thuc tu du lieu.');
    INSERT INTO Dausach VALUES ('D03L8','TL008','Tai lieu hoc tap dao tao nhan vien trong khach san - nha hang', 'Tong cuc du lich', 'TP.HCM : Truong Dai hoc Tai chinh - Marketing', 3, 'Du an phat trien nguon nhan luc Du lich Viet Nam: Chuong trinh phat trien dao tao vien - ky nang dao tao.');
    INSERT INTO Dausach VALUES ('D04L8','TL008','Di bo va suc khoe','Nguyen Ngoc Kim Anh','Ha Noi : The thao va Du lich',5,'Trinh bay nhung kien thuc co ban ve vai tro di bo trong ren luyen suc khoe, loi ich , ky thuat di bo the thao');
    INSERT INTO Dausach VALUES ('D05L8','TL008','Financial Management: Core Concepts','Brooks, Raymond','Harlow : Pearson', 2,'Includes bibliographical references and index');
    
    
    INSERT INTO Dausach VALUES ('D01L9', 'TL009', 'Loan 12 su quan', 'Nguyen Dinh Tu', 'Nha xuat ban Van Hoa - Van Nghe', 3, 'Day la mot bo tieu thuyet da su dua tren mot so su kien lich su dau the ky 10. Truyen ke ve cuoc loan lac dien ra vao cuoi thoi nha Ngo, keo dai tu nam 944 sau khi Ngo Quyen mat cho den khi Dinh Bo Linh thong nhat dat nuoc, lap ra nha Dinh nam 968.');
    INSERT INTO Dausach VALUES ('D02L9', 'TL009', 'Minh su', 'Thai Ba Loi', 'Nha xuat ban Hoi Nha Van', 2, 'Tieu thuyet nay ke ve cuoc doi va su nghiep cua Nguyen Hoang. Vao nam Nguyen Hoang tron 80 tuoi, ong van tham gia chinh chien voi khi the hon nguoi phai mang tam voc cua trang si 20.');
    INSERT INTO Dausach VALUES ('D03L9', 'TL009', 'Song Con mua lu', 'Nguyen Mong Giac', 'Nha xuat ban Hoi Nha Van', 3, 'Bo truong thien tieu thuyet nay cua nha van Nguyen Mong Giac, duoc ban doc chu y truoc het vi be day 4 tap 2000 trang voi nhan vat trung tam la nguoi anh hung dan toc Nguyen Hue.');

    
    INSERT INTO Dausach VALUES ('D1L10', 'TL010', 'Chinh Phuong', 'Nam Cao', 'Nha xuat ban Van hoc', 5, 'Day la mot bo tieu thuyet da su dua tren mot so su kien lich su dau the ky 10. Truyen ke ve cuoc loan lac dien ra vao cuoi thoi nha Ngo, keo dai tu nam 944 sau khi Ngo Quyen mat cho den khi Dinh Bo Linh thong nhat dat nuoc, lap ra nha Dinh nam 968. Cuon sach nay duoc Nha xuat ban Van Hoa - Van Nghe phat hanh.');
    INSERT INTO Dausach VALUES ('D2L10', 'TL010', 'Doi thuong', 'Nguyen Ngoc Tu', 'Nha xuat ban Tre', 2, 'Tieu thuyet nay ke ve cuoc doi va su nghiep cua Nguyen Hoang. Vao nam Nguyen Hoang tron 80 tuoi, ong van tham gia chinh chien voi khi the hon nguoi phai mang tam voc cua trang si 20. Cuon sach nay duoc Nha xuat ban Tre phat hanh');
    INSERT INTO Dausach VALUES ('D3L10', 'TL010', 'Toi di hoc', 'Thanh Tinh', 'Nha xuat ban Kim Dong', 1, 'Truyen ngan “Toi di hoc” cua nha van Thanh Tinh la cau chuyen ngay dau tien di hoc cua nhan vat “toi”. Buoi sang mua thu trong veo voi nhung dam may trang nhe nhang troi tren bau troi xanh tham, nang vang ruc ro khap noi da tao nen mot khung canh that dep de cho ngay dau tien di hoc cua cac em thieu nhi. Cuon sach nay duoc Nha xuat ban Kim Dong phat hanh');


--Thêm d? li?u m?u vào b?ng Sách 
    
   	INSERT INTO Sach VALUES('S0001','D01L1',26000,2020,null);
    INSERT INTO Sach VALUES('S0002','D01L1',26000,2020,null);
    INSERT INTO Sach VALUES('S0003','D01L1',27000,2021,null);
    INSERT INTO Sach VALUES('S0004','D01L1',27000,2021,null);
    INSERT INTO Sach VALUES('S0005','D01L1',28000,2022,null);
    INSERT INTO Sach VALUES('S0006','D01L1',28000,2022,null);
    INSERT INTO Sach VALUES('S0007','D01L1',30000,2023,null);
    
	INSERT INTO Sach VALUES('S0008','D02L1', 25000,2016,null);
    INSERT INTO Sach VALUES('S0009','D02L1', 27000,2016,null);
	INSERT INTO Sach VALUES('S0010','D02L1', 35000,2023,null);

	INSERT INTO Sach VALUES('S0011','D03L1', 80000,2023,null);
    INSERT INTO Sach VALUES('S0012','D03L1', 80000,2023,null);

    --TL002
	INSERT INTO Sach VALUES('S0013','D01L2', 90000,2023,null);
    INSERT INTO Sach VALUES('S0014','D01L2', 95000,2023,null);
	INSERT INTO Sach VALUES('S0015','D02L2', 100000,2023,null);
	INSERT INTO Sach VALUES('S0016','D03L2', 115000,2023,null);
    INSERT INTO Sach VALUES('S0017','D03L2', 110000,2023,null);
    
    --TL003
    INSERT INTO Sach VALUES('S0018','D01L3', 30000,2014,null);
    INSERT INTO Sach VALUES('S0019','D01L3', 110000,2023,null);
    INSERT INTO Sach VALUES('S0020','D02L3', 30000,2014,null);
    INSERT INTO Sach VALUES('S0021','D02L3', 110000,2023,null);
    INSERT INTO Sach VALUES('S0022','D03L3', 30000,2014,null);
    INSERT INTO Sach VALUES('S0023','D03L3', 120000,2023,null);
    INSERT INTO Sach VALUES('S0024','D04L3', 10000,2014,null);
    INSERT INTO Sach VALUES('S0025','D04L3', 160000,2023,null);
    INSERT INTO Sach VALUES('S0026','D05L3', 35000,2014,null);
    INSERT INTO Sach VALUES('S0027','D05L3', 115000,2023,null);
    
    --TL004
	INSERT INTO Sach VALUES('S0028','D01L4', 45000,2023,null);
	INSERT INTO Sach VALUES('S0029','D01L4', 90000,2023,null);
	INSERT INTO Sach VALUES('S0030','D02L4', 13800,2015,null);
	INSERT INTO Sach VALUES('S0031','D02L4', 16000,2018,null);
    INSERT INTO Sach VALUES('S0032','D02L4', 20000,2020,null);
    INSERT INTO Sach VALUES('S0033','D02L4', 28000,2022,null);
    INSERT INTO Sach VALUES('S0034','D02L4', 40000,2023,null);
    
    --TL005
	INSERT INTO Sach VALUES('S0035','D01L5', 100000,2023,null);
	INSERT INTO Sach VALUES('S0036','D02L5', 120000,2023,null);
	INSERT INTO Sach VALUES('S0037','D03L5', 60000,2018,null);
    INSERT INTO Sach VALUES('S0038','D03L5', 200000,2023,null);
	INSERT INTO Sach VALUES('S0039','D04L5', 30000,2020,null);
    INSERT INTO Sach VALUES('S0040','D04L5', 50000,2022,null);
    INSERT INTO Sach VALUES('S0041','D04L5', 90000,2023,null);
    
    --TL006
	INSERT INTO Sach VALUES('S0042','D01L6', 23000,2021,null);
    INSERT INTO Sach VALUES('S0043','D01L6', 27000,2022,null);
    INSERT INTO Sach VALUES('S0044','D01L6', 27500,2022,null);
    INSERT INTO Sach VALUES('S0045','D01L6', 30000,2023,null);
    INSERT INTO Sach VALUES('S0046','D01L6', 40000,2022,null);
	INSERT INTO Sach VALUES('S0047','D02L6', 40000,2022,null);
    INSERT INTO Sach VALUES('S0048','D02L6', 80000,2023,null);
	INSERT INTO Sach VALUES('S0049','D03L6', 40000,2022,null);
    INSERT INTO Sach VALUES('S0050','D03L6', 45000,2022,null);
    INSERT INTO Sach VALUES('S0051','D03L6', 55000,2023,null);
    INSERT INTO Sach VALUES('S0052','D03L6', 60000,2023,null);
    
    --TL007
	INSERT INTO Sach VALUES('S0053','D01L7', 50000,2022,null);
    INSERT INTO Sach VALUES('S0054','D01L7', 60000,2022,null);
	INSERT INTO Sach VALUES('S0055','D01L7', 70000,2022,null);
	INSERT INTO Sach VALUES('S0056','D01L7', 80000,2023,null);
	INSERT INTO Sach VALUES('S0057','D01L7', 90000,2023,null);
	INSERT INTO Sach VALUES('S0058','D02L7', 50000,2022,null);
    INSERT INTO Sach VALUES('S0059','D02L7', 100000,2022,null);
	
    --TL008
	INSERT INTO Sach VALUES('S0060','D01L8', 30000,2022,null);
    INSERT INTO Sach VALUES('S0061','D01L8', 50000,2023,null);
	INSERT INTO Sach VALUES('S0062','D02L8', 30000,2020,null);
    INSERT INTO Sach VALUES('S0063','D02L8', 35000,2021,null);
    INSERT INTO Sach VALUES('S0064','D02L8', 38000,2022,null);
    INSERT INTO Sach VALUES('S0065','D02L8', 50000,2023,null);
	INSERT INTO Sach VALUES('S0066','D03L8', 30000,2021,null);
    INSERT INTO Sach VALUES('S0067','D03L8', 50000,2022,null);
    INSERT INTO Sach VALUES('S0068','D03L8', 80000,2023,null);
    INSERT INTO Sach VALUES('S0069','D04L8', 0,2022, 'Duoc tang');
    INSERT INTO Sach VALUES('S0070','D04L8', 0,2022, 'Duoc tang');
    INSERT INTO Sach VALUES('S0071','D04L8', 0,2022, 'Duoc tang');
    INSERT INTO Sach VALUES('S0072','D04L8', 0,2022, 'Duoc tang');
    INSERT INTO Sach VALUES('S0073','D04L8', 0,2022, 'Duoc tang');
	INSERT INTO Sach VALUES('S0074','D05L8', 0,2016, 'Duoc tang');
    INSERT INTO Sach VALUES('S0075','D05L8', 0,2016, 'Duoc tang');

    --TL009
    INSERT INTO Sach VALUES('S0076','D01L9', 120000,2023,null);
    INSERT INTO Sach VALUES('S0077','D01L9', 120000,2023,null);
    INSERT INTO Sach VALUES('S0078','D01L9', 120000,2023,null);
    INSERT INTO Sach VALUES('S0079','D02L9', 110000,2023,null);
    INSERT INTO Sach VALUES('S0080','D03L8', 110000,2023,null);
    INSERT INTO Sach VALUES('S0081','D03L9', 115000,2023,null);
    INSERT INTO Sach VALUES('S0082','D03L9', 115000,2023,null);
    INSERT INTO Sach VALUES('S0083','D03L9', 115000,2023,null);
    
    --TL010
    INSERT INTO Sach VALUES('S0084','D1L10', 80000,2022,null);
    INSERT INTO Sach VALUES('S0085','D1L10', 80000,2022,null);
    INSERT INTO Sach VALUES('S0086','D1L10', 100000,2023,null);
    INSERT INTO Sach VALUES('S0087','D1L10', 100000,2023,null);
    INSERT INTO Sach VALUES('S0088','D1L10', 100000,2023,null);
    INSERT INTO Sach VALUES('S0089','D2L10', 90000,2023,null);
    INSERT INTO Sach VALUES('S0090','D2L10', 90000,2023,null);
    INSERT INTO Sach VALUES('S0091','D3L10', 120000,2023,null);
--Thêm d? li?u m?u vào b?ng ??c gi?
	INSERT INTO DocGia VALUES ('DG001', 'Nguyen Thi Minh', to_date('2004-03-12','yyyy-MM-dd'), 'Nu', '0915007408', 'Q1, Tp.HCM',  'Sinh vien');
	INSERT INTO DocGia VALUES('DG002', 'Nguyen Thi Ngoc', to_date('2003-03-12','yyyy-MM-dd'),'Nu','098123123', 'Phu Nhuan, Tp.HCM',  'Sinh vien');
	INSERT INTO DocGia VALUES('DG003', 'Tran Anh Tuan', to_date('2002-05-20','yyyy-MM-dd'), 'Nam', '091321321', 'Q1, Tp.HCM',  'Sinh vien');
	INSERT INTO DocGia VALUES('DG004', 'Pham Nam Minh', to_date('2002-08-20','yyyy-MM-dd'), 'Nam', '090312312', 'Thanh Xuan, Ha Noi',  'Sinh vien');
	INSERT INTO DocGia VALUES('DG005', 'Nguyen Quoc Khanh', to_date('2004-08-14','yyyy-MM-dd'),'Nam', '0936868946', 'Binh Thanh, Tp.HCM', 'Sinh vien');
	INSERT INTO DocGia VALUES('DG006', 'Nguyen Duy', to_date('2001-06-14','yyyy-MM-dd'), 'Nam', '090812812', 'Cu Chi, Tp.HCM', 'Sinh vien');
	INSERT INTO DocGia VALUES('DG007', 'Nguyen Xuan Hung', to_date('2003-10-9','yyyy-MM-dd'), 'Nam', '0915007602',  'Hoc Mon, Tp.HCM','Sinh vien');
	INSERT INTO DocGia VALUES('DG008', 'Nguyen Xuan Dung', to_date('1978-7-9','yyyy-MM-dd'), 'Nam', '0915000233', 'Cam Ranh, Nha Trang', 'Giang vien');
	INSERT INTO DocGia VALUES('DG009', 'Nguyen Quoc Hung', to_date('1982-7-7','yyyy-MM-dd'), 'Nam', '0915007802',  'Long Thanh, Dong Nai', 'Giang vien');
	INSERT INTO DocGia VALUES('DG010', 'Nguyen Mai Huong', to_date('1986-11-9','yyyy-MM-dd'), 'Nu', '0975017602', 'Cu Chi, Tp.HCM', 'Giang vien');
	INSERT INTO DocGia VALUES('DG011', 'Pham Minh Tam', to_date('1991-02-25','yyyy-MM-dd'), 'Nam', '0321452167', 'Duc Huu, Long An', 'Giang vien');
	INSERT INTO DocGia VALUES('DG012', 'Tran Xuan Anh',to_date('1985-6-19','yyyy-MM-dd'), 'Nam', '0913007609',  'Ben Cat, Binh Duong', 'Giang vien');
	INSERT INTO DocGia VALUES('DG013', 'Tran Quoc An',to_date('1984-8-19','yyyy-MM-dd'), 'Nam', '0923007609', 'Di An, Binh Duong', 'Giang vien');
	INSERT INTO DocGia VALUES('DG014', 'Nguyen Tra Giang', to_date('1992-02-02','yyyy-MM-dd'), 'Nu', '0907898867', 'Thuan An, Binh Duong', 'Giang vien');
	INSERT INTO DocGia VALUES('DG015', 'Giang Van Thanh', to_date('1990-02-02','yyyy-MM-dd'), 'Nam', '09365428761', 'Hoc Mon, TP.Ho Chi Minh',  'Giang vien');
	INSERT INTO DocGia VALUES('DG016', 'Mai Duc Minh', to_date('1989-02-02','yyyy-MM-dd'),'Nam', '0934521896', 'Ban Loc, Long An',  'Nhan vien');
	INSERT INTO DocGia VALUES('DG017', 'Phan Van Khuong', to_date('1990-02-02','yyyy-MM-dd'),'Nam','0864123571', 'Chau Thanh, Long An',  'Nhan vien');
	INSERT INTO DocGia VALUES('DG018', 'Mai Hoang Duc', to_date('1992-02-02','yyyy-MM-dd'),'Nam','0987132468', 'Dau Tieng, Binh Duong',  'Nhan vien');
	INSERT INTO DocGia VALUES('DG019', 'Vo Cam Nhung', to_date('1997-02-02','yyyy-MM-dd'),'Nu', '0362122358', 'Quan 12,Tp.HCM', 'Nhan vien');
	INSERT INTO DocGia VALUES('DG020', 'Tran Viet Hung', to_date('1991-02-02','yyyy-MM-dd'),'Nam','0245612879', 'Binh Thanh, Tp.HCM', 'Nhan vien');

--Thêm d? li?u m?u vào b?ng Th? th?
	INSERT INTO ThuThu VALUES('TT001', 'Nguyen Quang Khoi', to_date('1980-10-12','yyyy-MM-dd'), 'Nam', '0975007632', 'Q1 , Tp.HCM');
	INSERT INTO ThuThu VALUES('TT002', 'Tran Xuan Huong',to_date('1979-7-9','yyyy-MM-dd'), 'Nu','0935000433', 'Phu Giao, Binh Duong');
	INSERT INTO ThuThu VALUES('TT003', 'Nguyen Quoc Thien', to_date('1978-7-7','yyyy-MM-dd'), 'Nam','0985007802', 'Dien Khanh, Nha Trang');
	INSERT INTO ThuThu VALUES('TT004', 'Nguyen Mai Quyen',to_date('1981-11-9','yyyy-MM-dd'), 'Nu','0975017688', 'Trang Bom, Dong Nai');
	INSERT INTO ThuThu VALUES('TT005', 'Tran Mai Thanh',to_date('1985-12-9','yyyy-MM-dd'), 'Nu', '0935666602','Tan Uyen, Binh Duong');
	INSERT INTO ThuThu VALUES('TT006', 'Pham Xuan Anh', to_date('1984-6-19','yyyy-MM-dd'), 'Nam','0913007677', 'Q2 , Tp.HCM');
	INSERT INTO ThuThu VALUES('TT007', 'Pham Ngoc Anh',to_date('1984-6-15','yyyy-MM-dd'), 'Nam','0913447677', 'Q3 , Tp.HCM');
	INSERT INTO ThuThu VALUES('TT008', 'Luu Ngoc Linh',to_date('1985-3-9','yyyy-MM-dd'), 'Nu', '02116584443', 'Ninh Hoa, Nha Trang');
	INSERT INTO ThuThu VALUES('TT009', 'Hoang Khanh Hung ', to_date('1982-8-11','yyyy-MM-dd'),'Nam', '02116584444' ,'Q1 , Tp.HCM');
	INSERT INTO ThuThu VALUES('TT010', 'Nguyen Thanh Duy', to_date('1988-10-9','yyyy-MM-dd'), 'Nam', '0354879621', 'Cam Ma, Dong Nai');
	INSERT INTO ThuThu VALUES('TT011', 'Le Thi Cuc', to_date('1989-05-04','yyyy-MM-dd'), 'Nu', '092987987', 'Cu Chi, Tp.HCM');
	INSERT INTO ThuThu VALUES('TT012', 'Mai Minh Man',to_date('1990-03-07','yyyy-MM-dd'), 'Nu', '098789789', 'Q9, Tp.HCM');
	INSERT INTO ThuThu VALUES('TT013', 'Vo Tu Hoang', to_date('2000-09-08','yyyy-MM-dd'), 'Nam', '091234234', 'Phu Trong, Tien Giang');
	INSERT INTO ThuThu VALUES('TT014', 'Tran Huu Thang', to_date('1985-05-12','yyyy-MM-dd'), 'Nam', '092678678', 'Tan Phu, Dong Nai');
	INSERT INTO ThuThu VALUES('TT015', 'Nguyen Duy Hoang', to_date('1987-03-05','yyyy-MM-dd'), 'Nam', '098456654', '67 Ki Long');
	INSERT INTO ThuThu VALUES('TT016', 'Mai Thi Luu', to_date('1992-03-17','yyyy-MM-dd'), 'Nu', '09181831444','Tan Tra, Long An');
	INSERT INTO ThuThu VALUES('TT017', 'Dao Thi Huong', to_date('1989-03-07','yyyy-MM-dd'), 'Nu', '09754322222', 'Phu Nhuan, Tp.HCM');
	INSERT INTO ThuThu VALUES('TT018', 'Phan Thanh Nhan', to_date('1987-02-4','yyyy-MM-dd'), 'Nu','09135332332', 'Cai Luy, Tien Giang');
	INSERT INTO ThuThu VALUES('TT019', 'Phan Anh Duong', to_date('1989-08-03','yyyy-MM-dd'), 'Nu','09812127678','Muc Hoa, Long An');
	INSERT INTO ThuThu VALUES('TT020', 'Phan Anh Nguyet', to_date('1990-01-08','yyyy-MM-dd'), 'Nu','09812342356', 'Thuan An, Binh Duong');

--Thêm d? li?u m?u vào b?ng Th? th? vi?n
	INSERT INTO TheThuVien VALUES('TTV01','DG001',to_date('2022-10-04','yyyy-MM-dd'),to_date('2027-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV02','DG002',to_date('2021-11-05','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV03','DG003',to_date('2021-10-01','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV04','DG004',to_date('2020-11-14','yyyy-MM-dd'),to_date('2024-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV05','DG005',to_date('2022-10-24','yyyy-MM-dd'),to_date('2026-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV06','DG006',to_date('2019-12-04','yyyy-MM-dd'),to_date('2023-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV07','DG007',to_date('2022-12-05','yyyy-MM-dd'),to_date('2026-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV08','DG008',to_date('2020-01-12','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV09','DG009',to_date('2021-01-10','yyyy-MM-dd'),to_date('2026-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV10','DG010',to_date('2022-01-09','yyyy-MM-dd'),to_date('2027-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV11','DG011',to_date('2023-01-15','yyyy-MM-dd'),to_date('2027-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV12','DG012',to_date('2022-01-25','yyyy-MM-dd'),to_date('2027-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV13','DG013',to_date('2023-01-20','yyyy-MM-dd'),to_date('2026-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV14','DG014',to_date('2023-01-25','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV15','DG015',to_date('2022-02-02','yyyy-MM-dd'),to_date('2027-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV16','DG016',to_date('2020-05-09','yyyy-MM-dd'),to_date('2023-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV17','DG017',to_date('2021-04-12','yyyy-MM-dd'),to_date('2024-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV18','DG018',to_date('2022-07-07','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV19','DG019',to_date('2020-12-01','yyyy-MM-dd'),to_date('2023-12-31','yyyy-MM-dd'));
	INSERT INTO TheThuVien VALUES('TTV20','DG020',to_date('2022-06-08','yyyy-MM-dd'),to_date('2025-12-31','yyyy-MM-dd'));

--Thêm d? li?u m?u vào b?ng Lo?i vi ph?m
	INSERT INTO LoaiVP VALUES ('VP000', 'Khong vi pham', 'Khong co');
	INSERT INTO LoaiVP VALUES ('VP001', 'Mat tai lieu', 'Phat gap 3 lan gia tri cua tai lieu (tinh theo gia bia)');
	INSERT INTO LoaiVP VALUES ('VP002', 'Tai lieu bi xe hoac rach 1/3 tro len', 'Phat gap 2 lan gia tri tai lieu');
	INSERT INTO LoaiVP VALUES ('VP003', 'Tai lieu bi ban, nhau nat (ghi chep, gach xoa, to mau)', 'Phat theo gia tri cua tai lieu và Thu vien thu hoi tai lieu do');
	INSERT INTO LoaiVP VALUES ('VP004', 'Tra tai lieu tre han (tai lieu muon ve nha)', 'Phat 1.000d/cuon/ngay');
	INSERT INTO LoaiVP VALUES ('VP005', 'Tai lieu muon doc tai cho nhung doc gia co tinh dem ve nha', 'Phat 1.000d/cuon/ngay');
    INSERT INTO LoaiVP VALUES ('VP006', 'Su dung may tinh cua thu vien de truy cap noi dung khong phu hop', 'Phat 100.000d va nhac nho');
    INSERT INTO LoaiVP VALUES ('VP007', 'Su dung may tinh cua thu vien tai noi dung khong phu hop', 'Phat 200.000d va nhac nho');
    INSERT INTO LoaiVP VALUES ('VP008', 'Gay on, lam phien nguoi khac', 'Phat 100.000d va nhac nho');
    INSERT INTO LoaiVP VALUES ('VP009', 'Dem thuc an vao thu vien', 'Phat 50.000d va nhac nho');
    INSERT INTO LoaiVP VALUES ('VP010', 'Su dung the thu vien cua nguoi khac', 'Phat 200.000d va tam thoi khoa the');

--Thêm d? li?u m?u vào b?ng Phi?u M??n
	INSERT INTO PhieuMuon VALUES ('PM001', 'DG001', 'TT001', to_date('2022-12-09','yyyy-MM-dd'), to_date('2022-12-09','yyyy-MM-dd'), 2, 'Muon doc tai cho');
	INSERT INTO PhieuMuon VALUES ('PM002', 'DG005', 'TT002', to_date('2023-01-09','yyyy-MM-dd'), to_date('2023-01-19','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM003', 'DG009', 'TT004', to_date('2023-01-10','yyyy-MM-dd'), to_date('2023-01-20','yyyy-MM-dd'), 2, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM004', 'DG011', 'TT012', to_date('2023-02-10','yyyy-MM-dd'),to_date('2023-02-20','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM005', 'DG003', 'TT006', to_date('2023-02-11','yyyy-MM-dd'), to_date('2023-02-21','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM006', 'DG002', 'TT011', to_date('2023-02-14','yyyy-MM-dd'), to_date('2023-02-14','yyyy-MM-dd'), 1, 'Muon doc tai cho');
	INSERT INTO PhieuMuon VALUES ('PM007', 'DG001', 'TT005', to_date('2023-03-06','yyyy-MM-dd'), to_date('2023-03-06','yyyy-MM-dd'), 2, 'Muon doc tai cho');
	INSERT INTO PhieuMuon VALUES ('PM008', 'DG002', 'TT001', to_date('2023-03-06','yyyy-MM-dd'), to_date('2023-03-16','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM009', 'DG008', 'TT007', to_date('2023-03-13','yyyy-MM-dd'), to_date('2023-03-23','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM010', 'DG011', 'TT001', to_date('2023-04-15','yyyy-MM-dd'), to_date('2023-04-25','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM011', 'DG012', 'TT008', to_date('2023-04-17','yyyy-MM-dd'), to_date('2023-04-27','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM012', 'DG017', 'TT010', to_date('2023-04-20','yyyy-MM-dd'), to_date('2023-04-30','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM013', 'DG009', 'TT004', to_date('2023-05-09','yyyy-MM-dd'), to_date('2023-05-19','yyyy-MM-dd'), 2, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM014', 'DG018', 'TT012', to_date('2023-05-11','yyyy-MM-dd'), to_date('2023-05-21','yyyy-MM-dd'), 2, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM015', 'DG020', 'TT011', to_date('2023-05-12','yyyy-MM-dd'), to_date('2023-05-22','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM016', 'DG005', 'TT019', to_date('2023-06-05','yyyy-MM-dd'), to_date('2023-06-05','yyyy-MM-dd'), 1, 'Muon doc tai cho');
	INSERT INTO PhieuMuon VALUES ('PM017', 'DG003', 'TT015', to_date('2023-06-10','yyyy-MM-dd'), to_date('2023-06-10','yyyy-MM-dd'), 1, 'Muon doc tai cho');
	INSERT INTO PhieuMuon VALUES ('PM018', 'DG008', 'TT017', to_date('2023-06-11','yyyy-MM-dd'), to_date('2023-06-21','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM019', 'DG004', 'TT018', to_date('2023-11-20','yyyy-MM-dd'), to_date('2023-11-30','yyyy-MM-dd'), 1, 'Muon ve nha');
	INSERT INTO PhieuMuon VALUES ('PM020', 'DG006', 'TT004', to_date('2023-11-21','yyyy-MM-dd'), to_date('2023-12-01','yyyy-MM-dd'), 2, 'Muon ve nha');
    INSERT INTO PhieuMuon VALUES ('PM021', 'DG003', 'TT003', to_date('2023-11-26','yyyy-MM-dd'), to_date('2023-12-05','yyyy-MM-dd'), 1, 'Muon ve nha');
    

--Thêm d? li?u m?u vào b?ng Chi ti?t Phi?u M??n 
	INSERT INTO CTPhieuMuon VALUES ('PM001', 'S0001');
	INSERT INTO CTPhieuMuon VALUES ('PM001', 'S0036');
	INSERT INTO CTPhieuMuon VALUES ('PM002', 'S0042');
	INSERT INTO CTPhieuMuon VALUES ('PM003', 'S0006');
	INSERT INTO CTPhieuMuon VALUES ('PM003', 'S0007');
	INSERT INTO CTPhieuMuon VALUES ('PM004', 'S0008');
	INSERT INTO CTPhieuMuon VALUES ('PM005', 'S0010');
	INSERT INTO CTPhieuMuon VALUES ('PM005', 'S0011');
	INSERT INTO CTPhieuMuon VALUES ('PM006', 'S0029');
	INSERT INTO CTPhieuMuon VALUES ('PM007', 'S0013');
	INSERT INTO CTPhieuMuon VALUES ('PM007', 'S0014');
	INSERT INTO CTPhieuMuon VALUES ('PM008', 'S0048');
	INSERT INTO CTPhieuMuon VALUES ('PM009', 'S0016');
	INSERT INTO CTPhieuMuon VALUES ('PM010', 'S0045');
	INSERT INTO CTPhieuMuon VALUES ('PM011', 'S0018');
	INSERT INTO CTPhieuMuon VALUES ('PM012', 'S0060');
	INSERT INTO CTPhieuMuon VALUES ('PM013', 'S0020');
	INSERT INTO CTPhieuMuon VALUES ('PM013', 'S0055');
	INSERT INTO CTPhieuMuon VALUES ('PM014', 'S0043');
	INSERT INTO CTPhieuMuon VALUES ('PM014', 'S0015');
	INSERT INTO CTPhieuMuon VALUES ('PM015', 'S0050');
	INSERT INTO CTPhieuMuon VALUES ('PM016', 'S0017');
	INSERT INTO CTPhieuMuon VALUES ('PM017', 'S0018');
	INSERT INTO CTPhieuMuon VALUES ('PM018', 'S0073');
	INSERT INTO CTPhieuMuon VALUES ('PM019', 'S0031');
	INSERT INTO CTPhieuMuon VALUES ('PM020', 'S0075');
	INSERT INTO CTPhieuMuon VALUES ('PM020', 'S0072');
    --new
    INSERT INTO CTPhieuMuon VALUES ('PM021', 'S0003');
--Thêm d? li?u m?u vào b?ng Phi?u Tr?
	INSERT INTO PhieuTra VALUES('PT001', 'PM001',  to_date('2022-12-09','yyyy-MM-dd'), 2, 2);
	INSERT INTO PhieuTra VALUES('PT002', 'PM002',  to_date('2023-01-18','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT003', 'PM003',  to_date('2023-01-21','yyyy-MM-dd'), 2, 1);
	INSERT INTO PhieuTra VALUES('PT004', 'PM003',  to_date('2023-01-22','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT005', 'PM004',  to_date('2023-02-15','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT006', 'PM005',  to_date('2023-03-20','yyyy-MM-dd'), 2, 1);
	INSERT INTO PhieuTra VALUES('PT007', 'PM005',  to_date('2023-03-21','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT008', 'PM006',  to_date('2023-02-16','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT009', 'PM007',  to_date('2023-03-06','yyyy-MM-dd'), 2, 2);
	INSERT INTO PhieuTra VALUES('PT010', 'PM008',  to_date('2023-03-16','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT011', 'PM009',  to_date('2023-03-20','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT012', 'PM010',  to_date('2023-04-25','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT013', 'PM011',  to_date('2023-04-26','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT014', 'PM012',  to_date('2023-04-29','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT015', 'PM013',  to_date('2023-05-15','yyyy-MM-dd'), 2, 1);
	INSERT INTO PhieuTra VALUES('PT016', 'PM013',  to_date('2023-05-20','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT017', 'PM014',  to_date('2023-05-20','yyyy-MM-dd'), 2, 2);
	INSERT INTO PhieuTra VALUES('PT018', 'PM015',  to_date('2023-05-21','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT019', 'PM016',  to_date('2023-06-06','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT020', 'PM017',  to_date('2023-06-10','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT021', 'PM018',  to_date('2023-06-21','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT022', 'PM019',  to_date('2023-12-01','yyyy-MM-dd'), 1, 1);
	INSERT INTO PhieuTra VALUES('PT023', 'PM020',  to_date('2023-12-01','yyyy-MM-dd'), 2, 1);
	INSERT INTO PhieuTra VALUES('PT024', 'PM020',  to_date('2023-12-02','yyyy-MM-dd'), 1, 1);

    --new 
--Thêm d? li?u vào b?ng CTPhieuTra:
    INSERT INTO CTPhieuTra VALUES('PT001', 'PM001', 'S0001', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT001', 'PM001', 'S0036', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT002', 'PM002', 'S0042', 'VP003', 23000);
	INSERT INTO CTPhieuTra VALUES('PT003', 'PM003', 'S0006', 'VP004', 10000);
	INSERT INTO CTPhieuTra VALUES('PT003', 'PM003', 'S0007', 'VP004', 20000);
	INSERT INTO CTPhieuTra VALUES('PT005', 'PM004', 'S0008', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT006', 'PM005', 'S0010', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT007', 'PM005', 'S0011', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT008', 'PM006', 'S0029', 'VP005', 20000);
	INSERT INTO CTPhieuTra VALUES('PT009', 'PM007', 'S0013', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT009', 'PM007', 'S0014', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT010', 'PM008', 'S0048', 'VP001', 270000);
	INSERT INTO CTPhieuTra VALUES('PT011', 'PM009', 'S0016', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT012', 'PM010', 'S0045', 'VP002', 60000);
	INSERT INTO CTPhieuTra VALUES('PT013', 'PM011', 'S0018', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT014', 'PM012', 'S0060', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT015', 'PM013', 'S0020', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT016', 'PM013', 'S0055', 'VP004', 1000);
	INSERT INTO CTPhieuTra VALUES('PT017', 'PM014', 'S0043', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT017', 'PM014', 'S0015', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT018', 'PM015', 'S0050', 'VP003', 45000);
	INSERT INTO CTPhieuTra VALUES('PT019', 'PM016', 'S0017', 'VP005', 10000);
	INSERT INTO CTPhieuTra VALUES('PT020', 'PM017', 'S0018', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT021', 'PM018', 'S0073', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT022', 'PM019', 'S0031', 'VP000', 0);
	INSERT INTO CTPhieuTra VALUES('PT023', 'PM020', 'S0075', 'VP000', 0);

--Thêm d? li?u m?u vào b?ng Phi?u Nh?p
	INSERT INTO PhieuNhap values('PN001','NCC01','TT002', to_date('2023-01-02','yyyy-MM-dd'),to_date('2023-01-10','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN002','NCC02','TT005', to_date('2023-01-01','yyyy-MM-dd'),to_date('2023-01-08','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN003','NCC03','TT007', to_date('2023-02-01','yyyy-MM-dd'),to_date('2023-02-14','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN004','NCC04','TT009', to_date('2023-03-01','yyyy-MM-dd'),to_date('2023-03-25','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN005','NCC05','TT010', to_date('2023-05-01','yyyy-MM-dd'),to_date('2023-05-26','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN006','NCC06','TT013', to_date('2023-06-01','yyyy-MM-dd'),to_date('2023-06-23','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN007','NCC07','TT017', to_date('2023-07-05','yyyy-MM-dd'),to_date('2023-07-24','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN008','NCC08','TT003', to_date('2023-08-05','yyyy-MM-dd'),to_date('2023-08-21','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN009','NCC09','TT019', to_date('2023-10-11','yyyy-MM-dd'),to_date('2023-10-31','yyyy-MM-dd'));
	INSERT INTO PhieuNhap values('PN010','NCC10','TT020', to_date('2023-11-05','yyyy-MM-dd'),to_date('2023-11-26','yyyy-MM-dd'));

--Thêm d? li?u m?u vào b?ng Chi ti?t Phi?u Nh?p
    INSERT INTO CTPhieuNhap values('PN001', 'D03L1', 2023, 2, 160000);
	INSERT INTO CTPhieuNhap values('PN001', 'D03L6', 2023, 2, 115000);
	INSERT INTO CTPhieuNhap values('PN002', 'D01L1', 2023, 2, 60000);
	INSERT INTO CTPhieuNhap values('PN002', 'D03L2', 2023, 2, 225000);
	INSERT INTO CTPhieuNhap values('PN002', 'D01L6', 2023, 2, 70000);
	INSERT INTO CTPhieuNhap values('PN003', 'D02L1', 2016, 2, 52000);
	INSERT INTO CTPhieuNhap values('PN003', 'D02L7', 2022, 2, 150000);
	INSERT INTO CTPhieuNhap values('PN004', 'D02L2', 2023, 1, 100000);
	INSERT INTO CTPhieuNhap values('PN004', 'D01L2', 2023, 2, 185000);
	INSERT INTO CTPhieuNhap values('PN005', 'D01L4', 2023, 2, 135000);
	INSERT INTO CTPhieuNhap values('PN005', 'D02L6', 2022, 1, 40000);
	INSERT INTO CTPhieuNhap values('PN006', 'D02L4', 2023, 13, 520000);
	INSERT INTO CTPhieuNhap values('PN007', 'D04L5', 2020, 15, 450000);
	INSERT INTO CTPhieuNhap values('PN007', 'D03L5', 2018, 15, 900000);
	INSERT INTO CTPhieuNhap values('PN007', 'D02L5', 2023, 8, 960000);
	INSERT INTO CTPhieuNhap values('PN007', 'D01L5', 2023, 7, 700000);
	INSERT INTO CTPhieuNhap values('PN007', 'D03L8', 2021, 20, 600000);
	INSERT INTO CTPhieuNhap values('PN007', 'D02L8', 2022, 15, 570000);
	INSERT INTO CTPhieuNhap values('PN007', 'D01L8', 2022, 30, 900000);
	INSERT INTO CTPhieuNhap values('PN008', 'D01L1', 2020, 26, 676000);
	INSERT INTO CTPhieuNhap values('PN008', 'D05L3', 2022, 3, 345000);
	INSERT INTO CTPhieuNhap values('PN009', 'D04L5', 2023, 4, 360000);
	INSERT INTO CTPhieuNhap values('PN009', 'D01L6', 2021, 5, 115000);
	INSERT INTO CTPhieuNhap values('PN009', 'D01L7', 2022, 3, 150000);
    
  
    --2 VIEW
    --2.1. Tao view vwDauSach_MuonNhieuNhat
    create or replace view vwSanPham_MuonNhieuNhat
    as
    SELECT s.isbn, COUNT(s.isbn) AS "So Luong Muon"
    FROM sach s
    JOIN ctphieumuon ctpm ON s.masach = ctpm.masach
    GROUP BY s.isbn
    HAVING COUNT(s.isbn) >= (
        SELECT MAX(CountIsbn)
        FROM (
            SELECT COUNT(s2.isbn) AS CountIsbn
            FROM sach s2
            JOIN ctphieumuon ctpm2 ON s2.masach = ctpm2.masach
            GROUP BY s2.isbn
        )
    )
    ORDER BY COUNT(s.isbn) DESC;
    
    select * from vwSanPham_MuonNhieuNhat;
    

    
    --2.2. Tao view Thong ke so tien nop phat
    --theo tung thang trong nam 2023
    create or replace view vwThongKe_TongNopPhat_TheoTungThang_2023
    as
    SELECT EXTRACT(MONTH FROM NVL(pt.ngaytra, SYSDATE)) AS "Thang",
    SUM(ctpt.phat) AS "Tong Phat"
    FROM ctphieutra ctpt
    JOIN phieutra pt ON ctpt.mat = pt.mat
    WHERE EXTRACT(YEAR FROM NVL(pt.ngaytra, SYSDATE)) = 2023
    GROUP BY EXTRACT(MONTH FROM NVL(pt.ngaytra, SYSDATE))
    order by EXTRACT(MONTH FROM NVL(pt.ngaytra, SYSDATE));
    
    select * from vwThongKe_TongNopPhat_TheoTungThang_2023

    --2.3. Tao view Thong ke sach bi hu hai
    create or replace view vwThongKeSachHuHai
    as
    select s.masach, ds.tensach,s.namxb, lvp.tenloaivp
    from sach s join ctphieutra ctpt on s.masach = ctpt.masach 
    join dausach ds on s.isbn = ds.isbn
    join loaivp lvp on ctpt.mavp = lvp.mavp
    where ctpt.mavp in 'VP002' or ctpt.mavp in 'VP003'
    
    select * from vwThongKeSachHuHai


    --2.44. Tao view Thong ke doc gia tra sach tre han
    create or replace view vwThongKeDocGiaTraTreHan
    as
    select distinct dg.madg, dg.hotendg,ptr.mat,
    ptr.ngaytra - pm.ngayhethan as "So ngay tre"
    from docgia dg join phieumuon pm on dg.madg = pm.madg 
    join phieutra ptr on ptr.mam = pm.mam
    join ctphieutra ctpt on ctpt.mat = ptr.mat
    where ctpt.mavp in 'VP004'
    
    select * from vwThongKeDocGiaTraTreHan
    
    --2.5. Tao view Thong ke doc gia khong tra sach
    create or replace view vwThongKeDocGiaKhongTraSach
    as
    select  ttv.mathe,dg.madg, dg.hotendg,ttv.hanthe
    from docgia dg join phieumuon pm on dg.madg = pm.madg 
    left join phieutra pt on pt.mam = pm.mam
    join thethuvien ttv on ttv.madg = dg.madg
    where pt.mat is null 
    
    select * from vwThongKeDocGiaKhongTraSach
    
    --3 STORE PROCEDURE
    --3.1 Tao thu tuc sp_DSSachGiaCao liet ke n sach co muc gia cao nhat, voi n nhap tu ban phim
    CREATE OR REPLACE PROCEDURE sp_DSSachGiaCao(n INT) AS
      CURSOR sach_curs IS
        SELECT ISBN, Tensach, Gia
        FROM (
            SELECT Dausach.ISBN, Tensach, Gia
            FROM Sach
            JOIN Dausach ON Sach.ISBN = Dausach.ISBN
            GROUP BY Dausach.ISBN, Tensach, Gia
            ORDER BY Gia DESC
        )
        WHERE ROWNUM <= n;
      v_isbn Dausach.ISBN%TYPE;
      v_tensach Dausach.Tensach%TYPE;
      v_gia Sach.Gia%TYPE;
      v_gia_format VARCHAR2(50);
    BEGIN
      OPEN sach_curs;
      LOOP
        FETCH sach_curs INTO v_isbn, v_tensach, v_gia;
        EXIT WHEN sach_curs%NOTFOUND;
        v_gia_format := TO_CHAR(v_gia, 'FM999,999,999,999') || ' VND';
        DBMS_OUTPUT.PUT_LINE('ISBN: ' || v_isbn);
        DBMS_OUTPUT.PUT_LINE('Tensach:' || v_tensach);
        DBMS_OUTPUT.PUT_LINE('Gia:' || v_gia_format);
        DBMS_OUTPUT.PUT_LINE('');
      END LOOP;
      CLOSE sach_curs;
    END sp_DSSachGiaCao;
    
    --Test 3.1
    SET SERVEROUTPUT ON;
    DECLARE
        n NUMBER;
    BEGIN
        n:=&n;
        sp_DSSachGiaCao(n);
    END;
    
    --3.2 Tao thu tuc sp_DGMStheoDoiTuong liet ke so lan muon sach cua doc gia
    --theo doi tuong Sinh vien/Giang vien/Nhan vien
    CREATE OR REPLACE PROCEDURE sp_DGMStheoDoiTuong (vdoituong docgia.DOITUONG%type)
    AS
        CURSOR c_dgms IS
            SELECT DG.MaDG, DG.HoTenDG, COUNT(CPM.MaM) AS SoLanMuon
            FROM DocGia DG
            LEFT JOIN PhieuMuon PM ON DG.MaDG = PM.MaDG
            LEFT JOIN CTPhieuMuon CPM ON PM.MaM = CPM.MaM
            WHERE DG.DoiTuong Like vdoituong
            GROUP BY DG.MaDG, DG.HoTenDG
            ORDER BY SoLanMuon DESC;
    BEGIN
        FOR dg IN c_dgms 
        LOOP
            DBMS_OUTPUT.PUT_LINE('STT: ' || c_dgms %ROWCOUNT || ', MaDG: ' ||
            dg.MaDG || ', HoTenDG: ' || dg.HoTenDG || ', SoLanMuon: ' || dg.SoLanMuon);
        END LOOP;
    END;
    
    --Test 3.2
    SET SERVEROUTPUT ON;
    ACCEPT v_DoiTuong CHAR PROMPT 'Nhap doi tuong (Sinh vien/Giang vien/Nhan vien): ';
    DECLARE
        v_DoiTuong DocGia.DoiTuong%TYPE;
    BEGIN
        v_DoiTuong := '&v_DoiTuong'; 
        v_DoiTuong := LOWER(v_DoiTuong );
        v_DoiTuong := UPPER(SUBSTR(v_DoiTuong , 1, 1)) || SUBSTR(v_DoiTuong , 2);
        sp_DGMStheoDoiTuong(v_DoiTuong);
    END;
    
    --3.3 Xay dung thu tuc P_DS in danh sach sach thuoc dau sach co ma isbn la n.
    --Thong tin gom: STT, Ma sach, 
    --Ten sach, Gia. Viet khoi lenh in danh sach cac dau sach co tong gia cao hon Price.-- Voi gia tri Price nhap ban phim
    CREATE OR REPLACE PROCEDURE P_DS(Price INT) AS
        CURSOR c_dausach IS
            SELECT DISTINCT Dausach.ISBN, Tensach, sum(sach.gia)
            FROM Dausach
            JOIN Sach ON Dausach.ISBN = Sach.ISBN
            group by Dausach.ISBN, Tensach
            having sum(sach.gia)> PRICE
            ORDER BY sum(sach.gia) ASC; 
    
        v_isbn Dausach.ISBN%TYPE;
        v_tensach Dausach.Tensach%TYPE;
        v_gia Sach.Gia%TYPE;
    BEGIN
        OPEN c_dausach;
        LOOP
            FETCH c_dausach INTO v_isbn,  v_tensach, v_gia;
            EXIT WHEN c_dausach%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('STT: ' || c_dausach%ROWCOUNT);
            DBMS_OUTPUT.PUT_LINE('Dau sach: ' || v_isbn);
            DBMS_OUTPUT.PUT_LINE('Ten sach: ' || v_tensach);
            DBMS_OUTPUT.PUT_LINE('Gia: ' || v_gia);
            DBMS_OUTPUT.PUT_LINE('-------------------------------');
    
        END LOOP;
        CLOSE c_dausach;
    END;
    
    --Test 3.3
    SET SERVEROUTPUT ON;
    DECLARE
        Price INT;
    BEGIN
        Price := &Price;
        P_DS(Price);
    
    --3.4 Tao thu tuc P_Sachdanhap de tinh tong so sach da nhap theo
    --nha cung cap tu bang Chi tiet Phieu Nhap.
    CREATE OR REPLACE PROCEDURE TongSoSachNhapTheoNCC (
        p_MaNCC IN Nhacungcap.MaNCC%TYPE,
        p_TongSach OUT INT
    ) AS
    BEGIN
        SELECT SUM(Soluong) INTO p_TongSach
        FROM CTPhieuNhap ctpn join PhieuNhap pn on ctpn.SoPN = pn.SoPN
        WHERE MaNCC = p_MaNCC;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_TongSach := 0;
    END;
    
    --Test 3.4
    SET SERVEROUTPUT ON;
    DECLARE
        v_MaNCC Nhacungcap.MaNCC%TYPE;
        v_TongSach INT;
    BEGIN
        v_MaNCC := '&v_MaNCC';
        TongSoSachNhapTheoNCC(v_MaNCC, v_TongSach);
        DBMS_OUTPUT.PUT_LINE('Tong sach da nhap tu nha cung cap ' ||
        v_MaNCC || ' la: ' || v_TongSach);
    END;
    
    --3.5 Tao thu tuc p_SLSach xem so luong sach cua mot dau sach,
    --neu so luong sach > 5 thi thong bao “Con sach”, 
    --nguoc lai thong bao “Sap het sach”, voi ma ISBN do nguoi dung nhap.
    CREATE OR REPLACE PROCEDURE sp_SLSach(p_ISBN IN Dausach.ISBN%TYPE) AS
        v_SoLuong INT;
    BEGIN
        SELECT COUNT(*) INTO v_SoLuong
        FROM Sach
        WHERE ISBN = p_ISBN;
    
        IF v_SoLuong > 5 THEN
            DBMS_OUTPUT.PUT_LINE('Dau sach ' || p_ISBN || ' con hang');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Dau sach ' || p_ISBN || ' sap het sach');
        END IF;
    END;
    
    --Test 3.5
    set serveroutput on;
    execute sp_SLSach('D03L8');
    execute sp_SLSach('D01L1');
    
    
        --4 Function
        --4.1 Tao ham f_SLPMcuaTT cho biet so luong phieu muon thu thu da tao voi tham so vao la ma thu thu
        create or replace function f_SLPMcuaTT (mtt ThuThu.MaTT%type)
        return number 
        as
            f1 number;
            v_TenThuThu ThuThu.HoTenTT%type;
        begin
            select count(MaM) into f1 from PhieuMuon where PhieuMuon.MaTT=mtt;
            select HoTenTT into v_TenThuThu from ThuThu where MaTT=mtt;
            dbms_output.put_line('');
            dbms_output.put_line('MaTT: '||mtt);
            dbms_output.put_line('Ten: '||v_TenThuThu);
            dbms_output.put_line('So luong phieu muon da tao: '||f1);
            dbms_output.put_line('');
            return f1;
        end f_SLPMcuaTT;

        
        --Test 4.1
        set serveroutput on;
        declare
            mtt ThuThu.MaTT%type;
            fl number;
        begin
            mtt := '&mtt';
            fl := f_SLPMcuaTT(mtt);
        end;
        
        --4.2 Tao ham f_TongSLSN cho biet tong so luong sach nhap trong tung phieu nhap 
        --(gom thong tin SoPN, MaNCC, Ho ten thu thu, Tong so luong)
        CREATE OR REPLACE FUNCTION f_TongSLSN
        RETURN SYS_REFCURSOR AS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
                SELECT pn.SoPN, pn.MaNCC, tt.HoTenTT, SUM(ctpn.Soluong) AS TongSLSachNhap
                FROM PhieuNhap pn
                JOIN CTPhieuNhap ctpn ON pn.SoPN = ctpn.SoPN
                JOIN ThuThu tt ON pn.MaTT = tt.MaTT
                GROUP BY pn.SoPN, pn.MaNCC, tt.HoTenTT;
            RETURN v_cursor;
        END f_TongSLSN;
        
        --Test 4.2
        set serveroutput on;
        DECLARE
            v_cursor SYS_REFCURSOR;
            v_SoPN PhieuNhap.SoPN%TYPE;
            v_MaNCC PhieuNhap.MaNCC%TYPE;
            v_HoTenTT ThuThu.HoTenTT%TYPE;
            v_TongSLSachNhap NUMBER;
        BEGIN
            v_cursor := f_TongSLSN;
            LOOP
                FETCH v_cursor INTO v_SoPN, v_MaNCC, v_HoTenTT, v_TongSLSachNhap;
                EXIT WHEN v_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('SoPN: ' || v_SoPN || ', MaNCC: '
                || v_MaNCC || ', HoTenTT: ' || v_HoTenTT || ',
                Tong so luong sach nhap: ' || v_TongSLSachNhap);
            END LOOP;
            CLOSE v_cursor;
        END;
        
        --4.3 Tao function de tra ve ten ð?u sach dua tren ma isbn dý?cc nhap tu ban phim
        CREATE OR REPLACE FUNCTION f_LayTenDauSach(p_ISBN IN Dausach.ISBN%TYPE)
        RETURN VARCHAR2
        IS
            v_TenSach Dausach.TenSach%TYPE;
        BEGIN
            SELECT TenSach INTO v_TenSach
            FROM Dausach
            WHERE ISBN = p_ISBN;
        
            RETURN v_TenSach;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN NULL;
        END;
        
        --Test 4.3
        set serveroutput on;
        DECLARE
            v_TenSach Dausach.Tensach%TYPE;
            v_MaISBN Dausach.ISBN%TYPE;
        BEGIN
            v_maisbn := '&v_MaISBN';
            v_TenSach := f_LayTenDauSach(v_maisbn);
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Ma ISBN da nhap: ' || v_MaISBN);
            IF v_TenSach IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('Ten sach: ' || v_TenSach);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Khong tim thay ten sach.');
            END IF;
        END;
        
        --4.4 Tao function F_CacPMTreHan tra ve thong tin cac phieu muon tre han
        CREATE OR REPLACE FUNCTION F_CacPMTreHan
        RETURN SYS_REFCURSOR
        IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
                SELECT *
                FROM (
                    SELECT PM.MaM, PM.Ngaymuon,
                        CASE
                            WHEN PT.MaT IS NULL THEN TRUNC(SYSDATE) - TRUNC(PM.Ngayhethan)
                            ELSE TRUNC(PT.Ngaytra) - TRUNC(PM.Ngayhethan)
                        END AS SoNgayTreHan
                    FROM PhieuMuon PM
                    LEFT JOIN PhieuTra PT ON PM.MaM = PT.MaM
                    WHERE TRUNC(SYSDATE) - TRUNC(PM.Ngayhethan) >= 10
                ) kq
                WHERE kq.SoNgayTreHan >= 10
                ORDER BY kq.MaM;
            RETURN v_cursor;
        END;
        
        --Test 4.4
        SET SERVEROUTPUT ON;
        DECLARE
            v_cursor SYS_REFCURSOR;
            v_MaM PhieuMuon.MaM%TYPE;
            v_Ngaymuon PhieuMuon.Ngaymuon%TYPE;
            v_Songaytrehan NUMBER;
        BEGIN
            v_cursor := F_CacPMTreHan();
            DBMS_OUTPUT.PUT_LINE('Cac phieu muon tre han tra sach: ');
        
            LOOP
                FETCH v_cursor INTO v_MaM, v_Ngaymuon, v_Songaytrehan;
                EXIT WHEN v_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('MaM: ' || v_MaM || ',
                Ngaymuon: ' || v_Ngaymuon || ', Songaytrehan: ' || v_Songaytrehan);
            END LOOP;
        
            CLOSE v_cursor;
        END;
        
        --4.5 Tao function f_TTNhapSach tra ve thong tin sach duoc nhap vao trong mot ngay cu the.
        CREATE OR REPLACE FUNCTION f_TTNhapSach(p_NgayNhap IN DATE)
        RETURN SYS_REFCURSOR
        IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
                SELECT pn.SoPN, ctpn.ISBN, ds.TenSach 
                FROM PhieuNhap pn
                JOIN CTPhieuNhap ctpn ON pn.SoPN = ctpn.SoPN
                JOIN DauSach ds ON ctpn.ISBN = ds.ISBN
                WHERE TRUNC(pn.NgayNhap) = TRUNC(p_NgayNhap);
        
            RETURN v_cursor;
        END;
        
        --Test 4.5
        SET SERVEROUTPUT ON;
        ACCEPT v_NgayNhap PROMPT 'Nhap ngay can kiem tra (DD-MM-YYYY): ' 
        
        DECLARE
            v_cursor SYS_REFCURSOR;
            v_NgayNhap DATE := TO_DATE('&v_NgayNhap','DD-MM-YYYY'); 
        
            v_SoPN PhieuNhap.SoPN%TYPE;
            v_ISBN DauSach.ISBN%TYPE;
            v_TenSach DauSach.TenSach%TYPE;
            v_Found BOOLEAN := FALSE;
        BEGIN
            v_cursor := F_TTNHAPSACH(v_NgayNhap);
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Ngay nhap: ' || v_NgayNhap);
            LOOP
                FETCH v_cursor INTO v_SoPN, v_ISBN, v_TenSach;
                EXIT WHEN v_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('SoPN: ' || v_SoPN || ', ISBN: ' || v_ISBN || ', TenSach: ' || v_TenSach);
                v_Found := TRUE;
            END LOOP;
            IF NOT v_Found THEN
                DBMS_OUTPUT.PUT_LINE('Khong co sach duoc nhap vao ngay nay.');
            END IF;
            CLOSE v_cursor;
        END;
    
    
    --5 PACKAGE
    --5.1 package in thong tin chi tiet cac doc gia duoc lap the thu vien
    --tu ngay 1 den ngay 2
    CREATE OR REPLACE PACKAGE ThongTinDocGia AS
        PROCEDURE InThongTinDocGia(ngay1 DATE, ngay2 DATE);
    END ThongTinDocGia;

        -- Package Body
        CREATE OR REPLACE PACKAGE BODY ThongTinDocGia AS
            PROCEDURE InThongTinDocGia(ngay1 DATE, ngay2 DATE) AS
                CURSOR cur_ThongTinDocGia IS
                    SELECT dg.hotendg, dg.ngaysinhdg, dg.gioitinhdg, dg.doituong
                    FROM docgia dg
                    JOIN thethuvien ttv ON dg.madg = ttv.madg
                    WHERE ttv.ngaytao BETWEEN ngay1 AND ngay2;
        
                hotendg docgia.hotendg%TYPE;
                ngaysinhdg docgia.ngaysinhdg%TYPE;
                gioitinhdg docgia.gioitinhdg%TYPE;
                doituong docgia.doituong%TYPE;
        
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Thong tin cac doc gia duoc lap the thu vien tu ngay '||
                TO_CHAR(ngay1, 'DD/MM/YYYY')|| ' den ngay '||  TO_CHAR(ngay2, 'DD/MM/YYYY'));
                FOR rec IN cur_ThongTinDocGia LOOP
                    hotendg := rec.hotendg;
                    ngaysinhdg := rec.ngaysinhdg;
                    gioitinhdg := rec.gioitinhdg;
                    doituong := rec.doituong;
                    
                    DBMS_OUTPUT.PUT_LINE('Ho ten: ' || hotendg);
                    DBMS_OUTPUT.PUT_LINE('Ngay sinh: ' || TO_CHAR(ngaysinhdg, 'DD/MM/YYYY'));
                    DBMS_OUTPUT.PUT_LINE('Gioi tinh: ' || gioitinhdg);
                    DBMS_OUTPUT.PUT_LINE('Doi tuong: ' || doituong);
                    DBMS_OUTPUT.PUT_LINE('--------------------------');
                END LOOP;
            END InThongTinDocGia;
        END ThongTinDocGia;

    --Kiem thu package
    SET SERVEROUTPUT ON;
    BEGIN
        ThongTinDocGia.InThongTinDocGia(TO_DATE('01/01/2019', 'DD/MM/YYYY'),
        TO_DATE('31/12/2021', 'DD/MM/YYYY'));
    END;
    
    --5.2. package them dau sach moi va hien thi thong tin dau sach
    create or replace package QuanLy_DauSach as
    procedure themdausach(p_isbn dausach.isbn%type,
    p_maloai dausach.maloai%type,
    p_tensach dausach.tensach%type,
    p_tacgia dausach.tacgia%type,
    p_nxb dausach.nxb%type,
    p_soluong dausach.soluong%type,
    p_thongtinsach dausach.thongtinsach%TYPE);
    
    procedure HienthiThongTinDauSach(p_ISBN in varchar2);
    
    end QuanLy_DauSach;
    
    CREATE OR REPLACE PACKAGE BODY QuanLy_DauSach AS
            PROCEDURE themdausach(
                p_isbn dausach.isbn%type,
                p_maloai dausach.maloai%type,
                P_tensach dausach.tensach%type,
                p_tacgia dausach.tacgia%type,
                p_nxb dausach.nxb%type,
                p_soluong dausach.soluong%type,
                p_thongtinsach dausach.thongtinsach%TYPE
            ) IS
            BEGIN
                INSERT INTO dausach (isbn, maloai,tensach,tacgia,nxb,soluong,thongtinsach)
                VALUES (p_isbn, p_maloai, P_tensach, p_tacgia,p_nxb,p_soluong,p_thongtinsach);
                COMMIT;
                DBMS_OUTPUT.PUT_LINE('Thêm sách thành công.');
            END themdausach;
        
            PROCEDURE HienthiThongTinDauSach(p_isbn IN VARCHAR2) IS
                p_maloai dausach.maloai%type;
                P_tensach dausach.tensach%type;
                p_tacgia dausach.tacgia%type;
                p_nxb dausach.nxb%type;
                p_soluong dausach.soluong%type;
                p_thongtinsach dausach.thongtinsach%TYPE;
            BEGIN
                SELECT maloai,tensach, tacgia,nxb,soluong,thongtinsach
                INTO p_maloai, p_tensach,p_tacgia,p_nxb,p_soluong,p_thongtinsach
                FROM dausach
                WHERE isbn = p_isbn;
        
                DBMS_OUTPUT.PUT_LINE('Thong tin sach:');
                DBMS_OUTPUT.PUT_LINE('Ma loai: ' || p_maloai);
                DBMS_OUTPUT.PUT_LINE('Ten sach: ' || P_tensach);
                DBMS_OUTPUT.PUT_LINE('Tac gia: ' || p_tacgia);
                DBMS_OUTPUT.PUT_LINE('So luong: ' || p_soluong);
                DBMS_OUTPUT.PUT_LINE('Thong tin sach: ' || p_thongtinsach);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('Khong tim thay sach co ma ' || p_isbn);
            END HienthiThongTinDauSach;
        END QuanLy_DauSach;

        --Kiem thu
        SET SERVEROUTPUT ON;
        BEGIN
            QuanLy_DauSach.HienthiThongTinDauSach('D02L5');
        END;
        
        SET SERVEROUTPUT ON;
        BEGIN
            QuanLy_DauSach.themdausach('D3L11', 'TL010', 'Toi di lam',
            'Thanh Tinh', 'Nha xuat ban Kim Dong',1, 
            'Truyen ngan “Toi di lam” cua nha van Thanh Tinh la cau chuyen ngay dau tien di lam cua nhan vat “toi”.
            Buoi sang mua thu trong veo voi nhung dam may trang nhe nhang troi tren bau troi xanh tham,
            nang vang ruc ro khap noi da tao nen mot khung canh that dep de cho ngay dau tien di hoc cua cac em thieu nhi. 
            Cuon sach nay duoc Nha xuat ban Kim Dong phat hanh');
        End;
        
    --5.3 package tim kiem thong tin dau sach
    CREATE OR REPLACE PACKAGE DauSach_Info AS
        PROCEDURE DauSach_TheoTheLoai (p_maloai IN dausach.maloai%TYPE);
    
        FUNCTION DauSach_TonTai (p_isbn IN dausach.isbn%TYPE) RETURN BOOLEAN;
        
        
        PROCEDURE In_ThongTin_DauSach (p_isbn IN dausach.isbn%TYPE);
    END DauSach_Info;
    
            CREATE OR REPLACE PACKAGE BODY DauSach_Info AS
            PROCEDURE DauSach_TheoTheLoai (p_maloai IN dausach.maloai%TYPE) IS
                CURSOR DauSachCursor IS
                    SELECT * FROM dausach WHERE maloai = p_maloai;
                P_DauSach_Info dausach%ROWTYPE;
            BEGIN
                FOR P_DauSach_Info IN DauSachCursor LOOP
                    -- Xu?t thông tin sách s? d?ng DBMS_OUTPUT
                    DBMS_OUTPUT.PUT_LINE(
                        'ISBN: ' || P_DauSach_Info.isbn ||
                        '; Ma loai: ' || P_DauSach_Info.maloai ||
                        '; Ten dau sach: ' || P_DauSach_Info.tensach ||
                        '; Tac gia: ' || P_DauSach_Info.tacgia ||
                        '; NXB: ' || P_DauSach_Info.nxb ||
                        '; So luong: ' || P_DauSach_Info.soluong ||
                        '; Thong tin dau sach: ' || P_DauSach_Info.thongtinsach
                    );
                END LOOP;
            END DauSach_TheoTheLoai;
        

            FUNCTION DauSach_TonTai (p_isbn IN dausach.isbn%TYPE) RETURN BOOLEAN IS
                sl_find NUMBER;
            BEGIN
                SELECT COUNT(*) INTO sl_find FROM dausach WHERE isbn = p_isbn;
                RETURN sl_find = 1;
            EXCEPTION
                WHEN OTHERS THEN
                    RETURN FALSE;
            END DauSach_TonTai;
        
            -- Procedure in thông tin sách
            PROCEDURE In_ThongTin_DauSach (p_isbn IN dausach.isbn%TYPE) IS
                p_dausach_info dausach%ROWTYPE;
            BEGIN
                -- Ki?m tra s? t?n t?i c?a sách
                IF DauSach_TonTai(p_isbn) THEN
                    -- L?y thông tin sách
                    SELECT * INTO p_dausach_info FROM dausach WHERE isbn = p_isbn;
        
                    -- Xu?t thông tin sách s? d?ng DBMS_OUTPUT
                    DBMS_OUTPUT.PUT_LINE('ISBN: ' || p_dausach_info.isbn );
                       DBMS_OUTPUT.PUT_LINE(' Ma loai: ' || p_dausach_info.maloai);
                       DBMS_OUTPUT.PUT_LINE(' Ten dau sach: ' || p_dausach_info.tensach);
                       DBMS_OUTPUT.PUT_LINE(' Tac gia: ' || p_dausach_info.tacgia );
                       DBMS_OUTPUT.PUT_LINE(' NXB: ' || p_dausach_info.nxb);
                       DBMS_OUTPUT.PUT_LINE(' So luong: ' || p_dausach_info.soluong );
                       DBMS_OUTPUT.PUT_LINE(' Thong tin dau sach: ' || p_dausach_info.thongtinsach);
                ELSE
                
                    DBMS_OUTPUT.PUT_LINE('dau sach co ma ' || p_isbn || ' khong ton tai.');
                END IF;
            END In_ThongTin_DauSach;
        END DauSach_Info;
        
        
        --Kiem thu
        DECLARE
            v_isbn dausach.isbn%TYPE := 'D03L1';
            v_maloai dausach.maloai%TYPE := 'TL003';
        BEGIN
            -- Call the procedures or functions from the package
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Thong tin dau sach theo ma loai ' || v_maloai);
            DauSach_Info.DauSach_TheoTheLoai(v_maloai);
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Thong tin dau sach can tim ' ||  v_isbn);
            DauSach_Info.In_ThongTin_DauSach(v_isbn);
        
            -- You can also check if a book exists using the function
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('Kiem tra dau sach ' ||  v_isbn|| ' co trong thu vien khong');
            IF DauSach_Info.DauSach_TonTai(v_isbn) THEN
                DBMS_OUTPUT.PUT_LINE('Dau sach ton tai.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Dau sach khong ton tai.');
            END IF;
        END;
        
        
        --5.4 package quan ly thu thu
        CREATE OR REPLACE PACKAGE QUANLY_THUTHU AS
          
            PROCEDURE ThemMoiThuThu(p_matt thuthu.matt%type,p_hoten thuthu.hotentt%type, 
            p_ngaysinh thuthu.ngaysinhtt%type,p_gioitinh thuthu.gioitinhtt%type,
            p_dienthoai thuthu.dthoaitt%type, p_diachi thuthu.diachitt%type);
            
            PROCEDURE CapNhat_SoLuong_TT( p_soluong out number);
            
            PROCEDURE ThongKeThuThuNamNu(p_SoLuongNam out NUMBER, p_SoLuongNu out NUMBER);
        
        
        END QUANLY_THUTHU;
        
        
           CREATE OR REPLACE PACKAGE BODY QUANLY_THUTHU AS
            
            PROCEDURE ThemMoiThuThu(
                p_matt thuthu.matt%type
                ,p_hoten thuthu.hotentt%type
                , p_ngaysinh thuthu.ngaysinhtt%type
                ,p_gioitinh thuthu.gioitinhtt%type
                ,p_dienthoai thuthu.dthoaitt%type
                ,p_diachi thuthu.diachitt%type
            ) IS
            BEGIN
                INSERT INTO ThuThu(matt, hotentt, ngaysinhtt, gioitinhtt, dthoaitt, diachitt)
                VALUES (p_matt, p_hoten, p_ngaysinh, p_gioitinh, p_dienthoai, p_diachi);
                COMMIT;
            END ThemMoiThuThu;
        
            PROCEDURE CapNhat_SoLuong_TT(p_soluong OUT NUMBER) IS
            BEGIN
                SELECT COUNT(*) INTO p_soluong FROM thuthu;
            END CapNhat_SoLuong_TT;
        
            PROCEDURE ThongKeThuThuNamNu(p_SoLuongNam OUT NUMBER, p_SoLuongNu OUT NUMBER) IS
            BEGIN
                SELECT COUNT(*) INTO p_SoLuongNam FROM ThuThu WHERE GioiTinhTT = 'Nam';
                SELECT COUNT(*) INTO p_SoLuongNu FROM ThuThu WHERE GioiTinhTT = 'Nu';
            END ThongKeThuThuNamNu;
        
        END QUANLY_THUTHU;
        
        --Kiem thu them moi thu thu
        SET SERVEROUTPUT ON;
        BEGIN
            QUANLY_THUTHU.ThemMoiThuThu('TT021', 'Phan Anh Ngoc',
            to_date('2000-01-10','yyyy-MM-dd'),
            'Nu','09812342213', 'Binh Thanh, TPHCM');
        END;
        
        
         
         
        --Kiem thu cap nhat so luong thu thu        
       SET SERVEROUTPUT ON;
        
        VARIABLE SoLuongNam NUMBER;
        VARIABLE SoLuongNu NUMBER;
        variable SoluongTT number
        
        BEGIN
            QUANLY_THUTHU.ThongKeThuThuNamNu(:SoLuongNam, :SoLuongNu);
             QUANLY_THUTHU.CapNhat_SoLuong_TT(:SoluongTT);
        END;
        
        PRINT SoLuongNam;
        PRINT SoLuongNu;
        print SoluongTT;
        
        
    
    --6 TRIGGER
    -- 6.1. Trigger before each row : Tao trigger tg_NgayMuonvaNgayHetHan
    --Ngay het han muon sach phai lon hon hoac bang ngay muon sach
    CREATE OR REPLACE TRIGGER tg_NgayMuonvaNgayHetHan
    BEFORE INSERT OR UPDATE ON PhieuMuon
    FOR EACH ROW
    BEGIN
      IF (:NEW.ngayhethan - :NEW.ngaymuon) < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Ngay het han muon sach phai lon hon hoac bang ngay muon sach');
      END IF;
    END;
    
    select ngayhethan - ngaymuon
    from phieumuon
    
    --kiem thu 1: Error
    delete from phieumuon where mam = 'PM022'
    INSERT INTO PhieuMuon VALUES ('PM022', 'DG001',
    'TT001', to_date('2023-11-21','yyyy-MM-dd'),
    to_date('2023-11-12','yyyy-MM-dd'),1 ,'Muon ve nha');

    -- kiem thu 2 : Success (ngayhethan cua PM001 là 2022-12-09)
    update PhieuMuon set ngaymuon = to_date('2022-12-7','yyyy-MM-dd') where MaM = 'PM001'
    
    --6.2. Trigger after each row Tu ðong cap nhat so luong sach con lai
    --trong dau sach khi co mot quyen sach duoc muon:
    CREATE OR REPLACE TRIGGER tg_CapNhatSoLuongSachTrongDauSach
    AFTER INSERT ON ctphieumuon
    FOR EACH ROW
    DECLARE
        v_SoLuong_Sach_Con dausach.soluong%TYPE;
        v_MaISBN sach.isbn%TYPE;
    BEGIN
        SELECT ds.soluong INTO v_SoLuong_Sach_Con FROM sach s join dausach ds on s.isbn = ds.isbn
        WHERE s.masach = :NEW.masach;
    
        select isbn into v_MaISBN from sach where masach = :NEW.masach;
        
        IF v_SoLuong_Sach_Con > 0 THEN
            v_SoLuong_Sach_Con := v_SoLuong_Sach_Con - 1;
    
            UPDATE dausach SET soluong = v_SoLuong_Sach_Con WHERE isbn = v_MaISBN;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Khong du sach de muon');
        END IF;
    END;
    
    --Kiem thu: so luong sach trong dau sach hien tai cua dau sach D01L1 la 5 
    INSERT INTO PhieuMuon VALUES ('PM022', 'DG003', 'TT003',
    to_date('2023-11-26','yyyy-MM-dd'), 
    to_date('2023-12-05','yyyy-MM-dd'), 1, 'Muon ve nha');
    insert into ctphieumuon values ('PM022','S0001');
    SELECT ds.soluong FROM sach s join dausach ds on s.isbn = ds.isbn
    WHERE s.masach = 'S0001';
    
    
    --6.3. Trigger before statement: Kiem tra so luong sach dang muon 
    --co vuot qua so luong sach trong thu vien khong
    CREATE OR REPLACE TRIGGER TG_KiemTra_SoLuong_Sach_Muon
    BEFORE INSERT ON ctphieumuon
    DECLARE
        v_Tong_So_Sach_Dang_Muon NUMBER;
        v_Tong_So_Sach_Chua_Muon NUMBER;
    BEGIN
        
            SELECT count(ctpm.masach) INTO v_Tong_So_Sach_Dang_Muon 
            FROM phieutra pt join ctphieutra ctpt on ctpt.mat = pt.mat 
            right join phieumuon pm on pt.mam = pm.mam 
            join ctphieumuon ctpm on ctpm.mam = pm.mam where ctpt.masach is null;
           
            Select count(*) INTO v_Tong_So_Sach_Chua_Muon
            from sach
            where masach not in 
                (SELECT ctpm.masach 
                FROM phieutra pt join ctphieutra ctpt on ctpt.mat = pt.mat 
                right join phieumuon pm on pt.mam = pm.mam 
                join ctphieumuon ctpm on ctpm.mam = pm.mam 
                where ctpt.masach is null);
    
       
        IF v_Tong_So_Sach_Dang_Muon > v_Tong_So_Sach_Chua_Muon THEN
            RAISE_APPLICATION_ERROR(-20002, 'So luong sach dang muon vuot qua so luong sach trong thu vien');
        END IF;
    END;
    
    --Kiem thu: so luong sach dang muon la 3 va so sach chua duoc muon la 88 
    INSERT INTO PhieuMuon VALUES ('PM022', 'DG006', 'TT004',
    to_date('2023-12-01','yyyy-MM-dd'), 
    to_date('2023-12-08','yyyy-MM-dd'), 1, 'Muon ve nha');
    insert into ctphieumuon values ('PM022','S0001');
    
    --6.4 Trigger after statement quan ly so luong the thu vien và doc gia
    CREATE OR REPLACE TRIGGER TG_SoLuong_TTV_DG
            AFTER INSERT OR UPDATE ON TheThuVien
        DECLARE
            v_SoLuong_TTV NUMBER;
            v_SoLuong_DG NUMBER;
        BEGIN
            SELECT COUNT(Mathe)
            INTO v_SoLuong_TTV
            FROM TheThuVien;
        
            SELECT COUNT(MaDG)
            INTO v_SoLuong_DG
            FROM DocGia;
        
            IF v_SoLuong_TTV > v_SoLuong_DG THEN
                RAISE_APPLICATION_ERROR(-20001, 'So luong the thu vien khong duoc lon hon so luong doc gia.');
            END IF;
        END TG_SoLuong_TTV_DG;

	INSERT INTO TheThuVien VALUES('TTV21','DG020',
    to_date('2022-06-08','yyyy-MM-dd'),
    to_date('2025-12-31','yyyy-MM-dd'));
    
    
    --6.5 Trigger Instead of: kiem tra xem doc gia da co the thu vien chua truoc khi tao the thu vien
            CREATE VIEW TheThuVien_View AS
            SELECT Mathe, MaDG, Ngaytao, HanThe
            FROM TheThuVien;
    
    
            CREATE OR REPLACE TRIGGER TG_KiemTra_TheThuVien
            INSTEAD OF INSERT OR UPDATE ON TheThuVien_View
            DECLARE
                v_ket_qua_ktr NUMBER;
            BEGIN
                IF INSERTING THEN
                    SELECT COUNT(*) INTO v_ket_qua_ktr
                    FROM TheThuVien
                    WHERE MaDG = :NEW.MaDG;
            
                    IF v_ket_qua_ktr > 0 THEN
                        RAISE_APPLICATION_ERROR(-20001, 'Doc gia da co the thu vien');
                    ELSE
                        INSERT INTO TheThuVien (Mathe, MaDG, Ngaytao, HanThe)
                        VALUES (:NEW.Mathe, :NEW.MaDG, :NEW.Ngaytao, :NEW.HanThe);
                    END IF;
                ELSIF UPDATING THEN
                    SELECT COUNT(*) INTO v_ket_qua_ktr
                    FROM TheThuVien
                    WHERE MaDG = :NEW.MaDG AND Mathe <> :OLD.Mathe;
            
                    IF v_ket_qua_ktr > 0 THEN
                        RAISE_APPLICATION_ERROR(-20001, 'Doc gia da co the thu vien');
                    ELSE
                        UPDATE TheThuVien
                        SET Ngaytao = :NEW.Ngaytao,
                            HanThe = :NEW.HanThe
                        WHERE Mathe = :OLD.Mathe;
                    END IF;
                END IF;
            END;
            
            

            --Kiem thu ERROR DG001 da co the thu vien
            SET SERVEROUTPUT ON;
            INSERT INTO TheThuVien_View (Mathe, MaDG, Ngaytao, HanThe)
            VALUES ('TTV21', 'DG001',
            TO_DATE('2023-12-01', 'yyyy-MM-dd'),
            TO_DATE('2028-12-31', 'yyyy-MM-dd'));
            DECLARE
                v_output VARCHAR2(32767);
            BEGIN
                DBMS_OUTPUT.PUT_LINE(v_output);
            END;
            
            
            --Kiem thu Success 
            INSERT INTO DocGia VALUES('DG021',
            'Nguyen San Quy', to_date('2001-03-02','yyyy-MM-dd'),
            'Nam','0244512879', 'Quan 12, Tp.HCM', 'Nhan vien');
            
            SET SERVEROUTPUT ON;
            INSERT INTO TheThuVien_View (Mathe, MaDG, Ngaytao, HanThe)
            VALUES ('TTV21', 'DG021', TO_DATE('2023-12-01', 'yyyy-MM-dd'), TO_DATE('2028-12-31', 'yyyy-MM-dd'));
            DECLARE
                v_output VARCHAR2(32767);
            BEGIN
                DBMS_OUTPUT.PUT_LINE(v_output);
            END;
            
            
            --6.6. Trigger compound: kiem tra doc gia da tra du so luong sach da mýõn chua
            CREATE OR REPLACE TRIGGER TG_KT_DG_TraSach
            FOR INSERT OR UPDATE ON CTPhieuTra
            COMPOUND TRIGGER
                TYPE return_info_type IS RECORD (
                    MaT ctphieutra.mat%type,
                    MaM ctphieutra.mam%type,
                    MaS ctphieutra.masach%type,
                    MaVP ctphieutra.mavp%type,
                    Phat ctphieutra.phat%type
                );
                TYPE return_info_list IS TABLE OF return_info_type INDEX BY PLS_INTEGER;
                
                g_return_info_list return_info_list;
                
                AFTER EACH ROW IS
                BEGIN
                    g_return_info_list(g_return_info_list.COUNT + 1).MaT := :NEW.MaT;
                    g_return_info_list(g_return_info_list.COUNT).MaM := :NEW.MaM;
                    g_return_info_list(g_return_info_list.COUNT).MaS := :NEW.MaSach;
                    g_return_info_list(g_return_info_list.COUNT).MaVP := :NEW.MaVP;
                    g_return_info_list(g_return_info_list.COUNT).Phat := :NEW.Phat;
                END AFTER EACH ROW;
            
                AFTER STATEMENT IS
                    v_returned_quantity NUMBER;
                    v_borrowed_quantity NUMBER;
                BEGIN
                    FOR i IN 1..g_return_info_list.COUNT LOOP
                        SELECT SoLuongM
                        INTO v_borrowed_quantity
                        FROM PhieuMuon
                        WHERE MaM = g_return_info_list(i).MaM;
                        
                        
                        SELECT NVL(count(*), 0)
                        INTO v_returned_quantity
                        FROM CTPhieuTra
                        WHERE MaM = g_return_info_list(i).MaM AND MaT = g_return_info_list(i).MaT;
            
                        IF v_returned_quantity < v_borrowed_quantity THEN
                            UPDATE PhieuTra
                            SET SoLuongT = v_returned_quantity
                            WHERE MaM = g_return_info_list(i).MaM AND MaT = g_return_info_list(i).MaT;
                             DBMS_OUTPUT.PUT_LINE( 'Phieu muon '
                             || g_return_info_list(i).MaM || '  da tra 1 quyen sach.');
                        ELSIF v_returned_quantity > v_borrowed_quantity THEN
                           RAISE_APPLICATION_ERROR(-20002, 'Phieu muon ' 
                           || g_return_info_list(i).MaM || ' da tra vuot qua so luong sach da muon.');
                        ELSE
                            RAISE_APPLICATION_ERROR(-20002,'Phieu muon ' 
                            || g_return_info_list(i).MaM || ' da tra du so luong sach.');
                        END IF;
                    END LOOP;
            
                    g_return_info_list.DELETE;
                END AFTER STATEMENT;
            END TG_KT_DG_TraSach;
            
                           
                --Kiem thu ERROR vi PM024 da du so luong tra
                SET SERVEROUTPUT ON;
                	INSERT INTO
                    CTPhieuTra 
                    VALUES('PT024', 'PM020', 'S0075', 'VP004', 1000);
                DECLARE
                    v_output VARCHAR2(32767);
                BEGIN
                    DBMS_OUTPUT.PUT_LINE(v_output);
                END;
                
                
                SET SERVEROUTPUT ON;
                -- Thuc hien thao tác them du lieu
                	INSERT INTO CTPhieuTra VALUES('PT024', 'PM020', 'S0074', 'VP004', 1000);
                DECLARE
                    v_output VARCHAR2(32767);
                BEGIN
                    DBMS_OUTPUT.PUT_LINE(v_output);
                END;
                
                
                --7. tao va cap quyen cho user va role
                -- Tao cac Role: 3
                CREATE ROLE admin_role;
                CREATE ROLE staff_role;
                CREATE ROLE guest_role;
                
                -- Tao cac User: 6
                CREATE USER admin_user IDENTIFIED BY admin123;
                CREATE USER staff_user1 IDENTIFIED BY thuthu1;
                CREATE USER staff_user2 IDENTIFIED BY thuthu2;
                CREATE USER guest_user1 IDENTIFIED BY docgia1;
                CREATE USER guest_user2 IDENTIFIED BY docgia2;
                CREATE USER guest_user3 IDENTIFIED BY docgia3;
                
                -- Gan Role cho User
                GRANT admin_role TO admin_user;
                GRANT staff_role TO staff_user1, staff_user2;
                GRANT guest_role TO guest_user1, guest_user2, guest_user3;
                
                -- Cap quyen cho role
                -- Cap quyen SELECT, INSERT, UPDATE, DELETE cho Role admin_role tren bang thuthu
                GRANT SELECT, INSERT, UPDATE, DELETE ON thuthu TO admin_role;
                
                -- Cap quyen SELECT, INSERT cho Role staff_role tren bang phieumuon
                GRANT SELECT, INSERT ON phieumuon TO staff_role;
                
                 -- Cap quyen SELECT cho Role guest_role tren bang dau sach
                GRANT SELECT ON dausach TO guest_role;
                
                -- Cap quyen truc tiep cho User (khong su dung Role)
                -- Cap quyen SELECT, INSERT, UPDATE, DELETE cho User admin_user trên bang docgia
                GRANT SELECT, INSERT, UPDATE, DELETE ON thethuvien TO admin_user;
                
                -- Cap quyen SELECT cho User staff_user1 tren bang loaivp
                GRANT SELECT ON employees TO staff_user1;
                
                -- Ví d?: Cap quyen SELECT cho User guest_user1 tren bang sach
                GRANT SELECT ON sach TO guest_user1;








    
    
    
    