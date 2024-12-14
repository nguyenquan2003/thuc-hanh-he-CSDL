using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyRapChieuPhim
{
    public partial class DatVe : Form
    {
        public DatVe()
        {
            InitializeComponent();
        }

        //DBConnect db = new DBConnect();

        //string maNhanVien = DangNhap.currentUserID;

        //private void DatVe_Load(object sender, EventArgs e)
        //{
        //    string slt_phim = "SELECT * FROM PHIM";
        //    string slt_suatchieu = "SELECT * FROM SUATCHIEU";

        //    DataTable dt1 = db.getDataTable(slt_phim);
        //    cb_ChonPhim.DataSource = dt1;
        //    cb_ChonPhim.DisplayMember = "TENPHIM";
        //    cb_ChonPhim.ValueMember = "MAPHIM";

        //    DataTable dt2 = db.getDataTable(slt_suatchieu);

        //    dt2.Columns.Add("ThoiGian");
        //    foreach (DataRow row in dt2.Rows)
        //    {
        //        TimeSpan gioBD = (TimeSpan)row["THOIGIANBD"];
        //        TimeSpan gioKT = (TimeSpan)row["THOIGIANKT"];
        //        row["ThoiGian"] = gioBD.ToString(@"hh\:mm") + " - " + gioKT.ToString(@"hh\:mm");
        //    }
        //    cb_SuatChieu.DataSource = dt2;
        //    cb_SuatChieu.DisplayMember = "ThoiGian";
        //    cb_SuatChieu.ValueMember = "MASC";
        //}

        //private void btnTaoHoaDon_Click(object sender, EventArgs e)
        //{
        //    string mahd = "HD";
        //    mahd = mahd + DateTime.Now.ToString("ddMMyyyy");

        //    string slt_MaHD = "select top 1 MAHD from HOADON where MAHD like '%" + mahd + "%' order by MAHD desc";

        //    string maHDCuoiCung = (string)db.getScalar(slt_MaHD);

        //    if(maHDCuoiCung == null)
        //    {
        //        mahd = mahd + "001";
        //    }
        //    else
        //    {
        //        string chon3kitu = maHDCuoiCung.Substring(10);
        //        int stt = int.Parse(chon3kitu) + 1;
        //        if(stt.ToString().Length == 1)
        //        {
        //            mahd = mahd + "00" + stt;
        //        }
        //        else if (stt.ToString().Length == 2)
        //        {
        //            mahd = mahd + "0" + stt;
        //        }
        //        else
        //        {
        //            mahd = mahd + stt;
        //        }
        //    }
        //    txtMaHD.Text = mahd;
        //    txtNgayLap.Text = DateTime.Now.ToString("dd/MM/yyyy");
        //    txtMaNV.Text = maNhanVien;

        //    string makh = "KH";
        //    makh = makh + DateTime.Now.ToString("ddMMyyyy");

        //    string slt_MaKH = "select top 1 MAKH from KHACHHANG where MAKH like '%" + makh + "%' order by MAKH desc";

        //    string maKHCuoiCung = (string)db.getScalar(slt_MaKH);

        //    if (maKHCuoiCung == null)
        //    {
        //        makh = makh + "001";
        //    }
        //    else
        //    {
        //        string chon3kitu = maKHCuoiCung.Substring(10);
        //        int stt = int.Parse(chon3kitu) + 1;
        //        if (stt.ToString().Length == 1)
        //        {
        //            makh = makh + "00" + stt;
        //        }
        //        else if (stt.ToString().Length == 2)
        //        {
        //            makh = makh + "0" + stt;
        //        }
        //        else
        //        {
        //            makh = makh + stt;
        //        }
        //    }

        //    txtMaKH.Text = makh;

        //    //if (maKHCuoiCung == null)
        //    //{
        //    //    txtMaKH.Text = "KH001";
        //    //}
        //    //else
        //    //{
        //    //    string maSo = maKHCuoiCung.Substring(2);
        //    //    int soMoi = int.Parse(maSo) + 1;
        //    //    txtMaKH.Text = "KH" + soMoi.ToString("D3");
        //    //}
        //}

        //private void button1_Click(object sender, EventArgs e)
        //{
        //    Button b = (Button)sender;

        //    if (b.BackColor == Color.Yellow)
        //    {
        //        MessageBox.Show("Ghế đã được chọn");
        //    }

        //    else
        //    {
        //        if (b.BackColor == Color.GreenYellow)
        //        {
        //            txtThanhTien.Text = "" + (int.Parse(txtThanhTien.Text) - 100000);
        //            b.BackColor = Color.Transparent;
        //        }
        //        else
        //        {
        //            txtThanhTien.Text = "" + (int.Parse(txtThanhTien.Text) + 100000);
        //            b.BackColor = Color.GreenYellow;
        //        }
        //    }
        //}

        //private void btnThanhToan_Click(object sender, EventArgs e)
        //{
        //    if(string.IsNullOrEmpty(txtTenKH.Text) || string.IsNullOrEmpty(txtSoDT.Text))
        //    {
        //        MessageBox.Show("Vui lòng nhập đầy đủ thông tin khách hàng!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //    }
        //    else
        //    {
        //        List<Button> dsGheChon = tableLayoutPanel1.Controls.OfType<Button>().ToList();

        //        string mahd = txtMaHD.Text;
        //        string makh = txtMaKH.Text;
        //        string manv = txtMaNV.Text;
        //        string tenkh = txtTenKH.Text;
        //        string sdt = txtSoDT.Text;
        //        DateTime ngayLapDate = DateTime.Parse(txtNgayLap.Text);
        //        string ngaylap = ngayLapDate.ToString("yyyy-MM-dd");
        //        string thanhtien = txtThanhTien.Text;

        //        string query_kh = "INSERT INTO KHACHHANG (MAKH, HOTEN, SODT) " +
        //                    "VALUES ('" + makh + "', N'" + tenkh + "', '" + sdt + "')";

        //        string query_hd = "insert into HOADON (MAHD, MAKH, MANV, NGAYLAP, THANHTIEN) " +
        //                    "VALUES ('" + mahd + "', '" + makh + "', '" + manv + "', '" + ngaylap + "', " + thanhtien + ")";

        //        db.getNonQuery(query_kh);
        //        db.getNonQuery(query_hd);

        //        foreach (var b in dsGheChon)
        //        {
        //            if (b.BackColor == Color.GreenYellow)
        //            {
        //                b.BackColor = Color.Yellow;

        //                string tenGhe = b.Text.Substring(4);
        //                int soGhe = int.Parse(tenGhe);

        //                string mave = "VE";
        //                mave = mave + DateTime.Now.ToString("ddMMyyyy");

        //                string masc = cb_SuatChieu.SelectedValue.ToString();

        //                string slt_MaVE = "select top 1 MAVE from VE order by MAVE desc";
        //                string MaVECuoiCung = (string)db.getScalar(slt_MaVE);

        //                if (MaVECuoiCung == null)
        //                {
        //                    mave = mave + "001";
        //                }
        //                else
        //                {
        //                    string chon3kitu = MaVECuoiCung.Substring(10);
        //                    int stt = int.Parse(chon3kitu) + 1;
        //                    if (stt.ToString().Length == 1)
        //                    {
        //                        mave = mave + "00" + stt;
        //                    }
        //                    else if (stt.ToString().Length == 2)
        //                    {
        //                        mave = mave + "0" + stt;
        //                    }
        //                    else
        //                    {
        //                        mave = mave + stt;
        //                    }
        //                }

        //                string query_ve = "INSERT INTO VE (MAVE, MASUATCHIEU, MAHD, TENGHE, TRANGTHAI) " +
        //                            "VALUES ('" + mave + "', '" + masc + "', '" + mahd + "', '" + soGhe + "', N'Đã đặt')";

        //                db.getNonQuery(query_ve);
        //            }
        //        }
        //    }
        //}
    }
}