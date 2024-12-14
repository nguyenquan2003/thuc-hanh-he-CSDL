using QuanLyRapChieuPhim.Admin;
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
    public partial class AdminHome : Form
    {
        public AdminHome()
        {
            InitializeComponent();
        }

        private void CloseAllChildForms()
        {
            foreach (Form childForm in this.MdiChildren)
            {
                childForm.Close();
            }
        }
        private void AdminHome_Load(object sender, EventArgs e)
        {
            CloseAllChildForms();
            TrangChu f = new TrangChu();
            f.MdiParent = this;
            f.Show();
        }
        private void trangChuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            TrangChu f = new TrangChu();
            f.MdiParent = this;
            f.Show();
        }
        private void nhanVienToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            QuanLyNhanVien f = new QuanLyNhanVien();
            f.MdiParent = this;
            f.Show();
        }

        private void phimToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            QuanLyPhim f = new QuanLyPhim();
            f.MdiParent = this;
            f.Show();
        }

        private void suatChieuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            QuanLySuatChieu f = new QuanLySuatChieu();
            f.MdiParent = this;
            f.Show();
        }

        private void doanhThuToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            ThongKeDoanhThu f = new ThongKeDoanhThu();
            f.MdiParent = this;
            f.Show();
        }

        private void thôngTinToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            Profile f = new Profile();
            f.MdiParent = this;
            f.Show();
        }

        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DangNhap signinform = new DangNhap();
            signinform.Show();
            this.Hide();
        }
    } 
}
