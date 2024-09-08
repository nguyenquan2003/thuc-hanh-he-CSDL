using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DoAn
{
    public partial class DangNhap : Form
    {
        public DangNhap()
        {
            InitializeComponent();
        }

        private void dangNhapBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.conStr))
                {
                    connection.Open();

                    // Tạo SqlCommand để kiểm tra đăng nhập
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM khachhang WHERE tendangnhap = @TenDangNhap AND matkhau = @MatKhau", connection))
                    {
                        cmd.Parameters.AddWithValue("@TenDangNhap", tenTaiKhoanText.Text);
                        cmd.Parameters.AddWithValue("@MatKhau", matKhauText.Text);

                        int result = (int)cmd.ExecuteScalar();

                        if (result > 0)
                        {
                            Properties.Settings.Default.conStr = @"Data Source = JONAS\SQLEXPRESS; Initial Catalog = QLSanBongMini; User ID = " + tenTaiKhoanText.Text + "; Password = " + matKhauText.Text + "";
                            MessageBox.Show("Đăng nhập thành công" + Properties.Settings.Default.conStr);
                            TrangChu trangChu = new TrangChu();
                            trangChu.Show();
                            this.Hide();
                            // Thực hiện các hành động sau khi đăng nhập thành công
                        }
                        else
                        {
                            MessageBox.Show("Đăng nhập thất bại. Vui lòng kiểm tra lại tên đăng nhập và mật khẩu.");
                        }
                        
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
    }
}
