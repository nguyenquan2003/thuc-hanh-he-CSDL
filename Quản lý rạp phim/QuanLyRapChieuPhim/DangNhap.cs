using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyRapChieuPhim;
using QuanLyRapChieuPhim.NhanVienBanDoAn;
using QuanLyRapChieuPhim.NhanVienBanVe;
using System.Data.SqlClient;


namespace QuanLyRapChieuPhim
{
    public partial class DangNhap : Form
    {
        public DangNhap()
        {
            InitializeComponent();
            invisible();
        }

        DBConnect db;
        public static string currentUserID;

        private void invisible()
        {
            labelNotification.Text = string.Empty;
            labelPassword.Text = string.Empty;
            labelPUsername.Text = string.Empty;
        }
        private void notification_txtEmpty()
        {
            TextBox[] textBoxes = { txtTenDangNhap, txtMatKhau };
            foreach (TextBox tb in textBoxes)
            {
                if (string.IsNullOrWhiteSpace(tb.Text))
                {
                    if (tb.Name == "txtTenDangNhap")
                    {
                        labelPUsername.Text = "Please enter username";
                        labelPUsername.Visible = true;
                    }
                    if (tb.Name == "txtMatKhau")
                    {
                        labelPassword.Text = "Please enter password";
                        labelPassword.Visible = true;
                    }
                }
                else
                {
                    if (tb.Name == "txtTenDangNhap")
                    {
                        labelPUsername.Visible = false;
                    }
                    if (tb.Name == "txtMatKhau")
                    {
                        labelPassword.Visible = false;
                    }
                }
            }
        }
        private void btn_DN_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDangNhap.Text.Trim();
            string mk = txtMatKhau.Text.Trim();

            if (string.IsNullOrEmpty(tenDN) || string.IsNullOrEmpty(mk))
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            db = new DBConnect(tenDN, mk);
            db.Open();

            string checkRole = @"
                SELECT 
                    CASE
                        WHEN IS_MEMBER('Admin') = 1 THEN 'Admin'
                        WHEN IS_MEMBER('NhanVien_BanVe') = 1 THEN 'NhanVien_BanVe'
                        WHEN IS_MEMBER('NhanVien_BanDoAn') = 1 THEN 'NhanVien_BanDoAn'
                        ELSE 'Unknown'
                    END AS RoleName;
            ";

            string roleName = db.getScalar(checkRole).ToString();

            if (roleName == "Admin")
            {
                MessageBox.Show("Đăng nhập với vai trò: Admin", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                AdminHome adminForm = new AdminHome();
                adminForm.Show();
                this.Hide();
            }
            else if (roleName == "NhanVien_BanVe")
            {
                MessageBox.Show("Đăng nhập với vai trò: Nhân viên bán vé", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                NvBanVeHome nvBanVeForm = new NvBanVeHome();
                nvBanVeForm.Show();
                this.Hide();
            }
            else if (roleName == "NhanVien_BanDoAn")
            {
                MessageBox.Show("Đăng nhập với vai trò: Nhân viên bán đồ ăn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                DatDoAn nvBanDoAnForm = new DatDoAn();
                nvBanDoAnForm.Show();
                this.Hide();
            }
            else
            {
                labelNotification.Text = "Login failed: username or password is wrong!";
            }    
        }

        private void ShowHide_Click(object sender, EventArgs e)
        {
            if (txtMatKhau.PasswordChar == '*')
            {
                txtMatKhau.PasswordChar = '\0';
                ShowHide.Image = Properties.Resources.eye;
            }
            else
            {
                txtMatKhau.PasswordChar = '*';
                ShowHide.Image = Properties.Resources.eyebrow;
            }
        }
    }
}
