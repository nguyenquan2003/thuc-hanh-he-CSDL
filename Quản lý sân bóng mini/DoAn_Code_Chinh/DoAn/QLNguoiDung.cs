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
    public partial class QLNguoiDung : Form
    {
        public static string conStr = Properties.Settings.Default.conStr;

        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlConnection con;
        DataColumn[] key = new DataColumn[1];
        public QLNguoiDung()
        {
            InitializeComponent();
            con = new SqlConnection(Properties.Settings.Default.conStr);
            if (con.State == ConnectionState.Closed)
                con.Open();
        }

        private void hoTenText_TextChanged(object sender, EventArgs e)
        {

        }

        private void QLNguoiDung_Load(object sender, EventArgs e)
        {
            try
            {
                da = new SqlDataAdapter("select * from KhachHang", con);
                da.Fill(ds, "KhachHang");

                key[0] = ds.Tables["KhachHang"].Columns[0];
                ds.Tables["KhachHang"].PrimaryKey = key;

                LoadQuyenComboBox();
                dataGridView1.DataSource = ds.Tables["KhachHang"];
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex);
            }
        }

        private void LoadQuyenComboBox()
        {
            try
            {
                // Truy vấn cơ sở dữ liệu để lấy danh sách quyền
                using (SqlCommand cmd = new SqlCommand("SELECT MaQuyen FROM phanquyen", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Xóa tất cả các mục hiện tại trong ComboBox
                        comboBox1.Items.Clear();

                        // Thêm từng quyền vào ComboBox
                        while (reader.Read())
                        {
                            int maQuyen = reader.GetInt32(0);
                            comboBox1.Items.Add(maQuyen);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách quyền: " + ex.Message);
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            // Đảm bảo rằng cell đã được chọn nằm trong giới hạn hợp lệ
            if (e.RowIndex >= 0 && e.RowIndex < dataGridView1.Rows.Count)
            {
                // Lấy giá trị từ cell được chọn
                DataGridViewRow selectedRow = dataGridView1.Rows[e.RowIndex];

                // Hiển thị thông tin của hàng

                string ma = selectedRow.Cells["MaKhachHang"].Value.ToString();
                string name = selectedRow.Cells["HoTen"].Value.ToString(); // Thay "NameColumnName" bằng tên cột tương ứng
                string sdt = selectedRow.Cells["SoDienThoai"].Value.ToString(); // Thay "PriceColumnName" bằng tên cột tương ứng
                string email = selectedRow.Cells["Email"].Value.ToString();
                string tendn = selectedRow.Cells["TenDangNhap"].Value.ToString();
                string mk = selectedRow.Cells["MatKhau"].Value.ToString();

                masokhachhang.Text = ma;
                hoTenText.Text = name;
                emailText.Text = email;
                soDienThoaiText.Text = sdt;
                tenDangNhapText.Text = tendn;
                matKhauText.Text = mk;
            }
        }

        private void suaBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("CapNhatThongTinKhachHang", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaKhachHang", masokhachhang.Text);
                    cmd.Parameters.AddWithValue("@HoTen", hoTenText.Text);
                    cmd.Parameters.AddWithValue("@Email", emailText.Text);
                    cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoaiText.Text);
                    cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhapText.Text);
                    cmd.Parameters.AddWithValue("@MatKhau", matKhauText.Text);
                    cmd.Parameters.AddWithValue("@MaQuyen", comboBox1.SelectedIndex + 1);
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Sửa thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
        private void ResetDataGridView()
        {
            ds.Tables["KhachHang"].Rows.Clear();
            // Nạp lại dữ liệu từ CSDL
            da.Fill(ds, "KhachHang");

            // Gắn lại DataTable vào DataGridView và làm mới
            dataGridView1.DataSource = ds.Tables["KhachHang"];
            dataGridView1.Refresh();
            LoadQuyenComboBox();
        }
        private void resetBTN_Click(object sender, EventArgs e)
        {
            ResetDataGridView();
        }

        private void themBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("ThemKhachHang", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HoTen", hoTenText.Text);
                    cmd.Parameters.AddWithValue("@SoDienThoai", soDienThoaiText.Text);
                    cmd.Parameters.AddWithValue("@Email", emailText.Text);
                    cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhapText.Text);
                    cmd.Parameters.AddWithValue("@MatKhau", matKhauText.Text);
                    cmd.Parameters.AddWithValue("@MaQuyen", comboBox1.SelectedItem);
                    using (SqlCommand cmd2 = new SqlCommand("CreateUserAccount", con))
                    {
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.AddWithValue("@UserName", tenDangNhapText.Text);
                        cmd2.Parameters.AddWithValue("@Password", matKhauText.Text);
                        cmd2.Parameters.AddWithValue("@RoleName", tenQuyenText.Text);
                        cmd.ExecuteNonQuery();
                        cmd2.ExecuteNonQuery();
                        MessageBox.Show("Thêm thành công");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void xoaBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("XoaKhachHang", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaKhachHang", masokhachhang.Text);

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Xóa thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int maQuyen = int.Parse(comboBox1.SelectedItem.ToString());
                using (SqlCommand cmd = new SqlCommand("SELECT TenLoaiQuyen FROM phanquyen WHERE MaQuyen = @MaQuyen;", con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@MaQuyen", maQuyen);

                    string tenQuyen = (string)cmd.ExecuteScalar();

                    // Hiển thị tên quyền ở TextBox hoặc Label
                    tenQuyenText.Text = tenQuyen;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            TrangChu trangChu = new TrangChu();
            trangChu.Show();
        }
    }
}

