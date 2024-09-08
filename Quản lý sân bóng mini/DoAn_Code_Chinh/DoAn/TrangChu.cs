using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DoAn
{
    public partial class TrangChu : Form
    {
        public TrangChu()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            QLNguoiDung qLNguoiDung = new QLNguoiDung();
            qLNguoiDung.Show();
            this.Hide();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLSancs qLSancs = new QLSancs();
            qLSancs.Show();
            this.Hide();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            QLDatSan qLDatSan = new QLDatSan(this);
            qLDatSan.Show();
            this.Hide();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Form1 form1 = new Form1();
            form1.Show();
            this.Hide();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            PhanQuyen phanQuyen = new PhanQuyen();
            phanQuyen.Show();
            this.Hide();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            QLThongKe qLThongKe = new QLThongKe();
            qLThongKe.Show();
            this.Hide();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            DangNhap dangNhap = new DangNhap();
            dangNhap.Show();
            this.Hide();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            DichVu dichVu = new DichVu(this);
            dichVu.Show();
            this.Hide();
        }
    }
}
