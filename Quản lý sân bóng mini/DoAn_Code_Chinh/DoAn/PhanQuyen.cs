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
    public partial class PhanQuyen : Form
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlConnection con;
        public PhanQuyen()
        {
            InitializeComponent();
            con = new SqlConnection(Properties.Settings.Default.conStr);
            //con = new SqlConnection(@"Data Source = JONAS\SQLEXPRESS; Initial Catalog = QLSanBongMini; User ID = binh1; Password = 123;");
            if (con.State == ConnectionState.Closed)
                con.Open();
        }

        private void PhanQuyen_Load(object sender, EventArgs e)
        {
            try
            {
                da = new SqlDataAdapter("select * from phanquyen", con);
                da.Fill(ds, "PhanQuyen");

                List<string> role = new List<string>
                {
                    "Select",
                    "Insert",
                    "Update",
                    "Delete",
                };

                gan_LoadQuyenComboBox();
                pq_LoadQuyenComboBox();
                LoadBangComboBox();
                LoadTenDangnhapComboBox();
                //test();

                pq_quyenComboBox.DataSource = role;
                pq_TenQuyenCombobox.SelectedIndex = 0;
                pq_trenBangCombobox.SelectedIndex = 0;

                dataGridView1.DataSource = ds.Tables[0];
            }
            catch (Exception ex)
            {
                MessageBox.Show("Loi: " + ex);
            }
        }

        private void taoQuyenBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("CreateRole", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@RoleName", tao_TenQuyenText.Text);
                    cmd.ExecuteNonQuery();
                    ResetDataGridView();
                    gan_LoadQuyenComboBox();
                    pq_LoadQuyenComboBox();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void ResetDataGridView()
        {
            ds.Tables["PhanQuyen"].Rows.Clear();
            // Nạp lại dữ liệu từ CSDL
            da.Fill(ds, "PhanQuyen");

            // Gắn lại DataTable vào DataGridView và làm mới
            dataGridView1.DataSource = ds.Tables["PhanQuyen"];
            dataGridView1.Refresh();
        }

        private void pq_LoadQuyenComboBox()
        {
            try
            {
                // Truy vấn cơ sở dữ liệu để lấy danh sách quyền
                using (SqlCommand cmd = new SqlCommand("SELECT TenLoaiQuyen FROM phanquyen", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Xóa tất cả các mục hiện tại trong ComboBox
                        pq_TenQuyenCombobox.Items.Clear();
                        gan_TenQuyenNguoiDungCombobox.Items.Clear();

                        // Thêm từng quyền vào ComboBox
                        while (reader.Read())
                        {
                            string tenQuyen = reader.GetString(0);
                            pq_TenQuyenCombobox.Items.Add(tenQuyen);
                            gan_TenQuyenNguoiDungCombobox.Items.Add(tenQuyen);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách quyền: " + ex.Message);
            }
        }

        private void gan_LoadQuyenComboBox()
        {
            try
            {
                // Truy vấn cơ sở dữ liệu để lấy danh sách quyền
                using (SqlCommand cmd = new SqlCommand("SELECT name FROM sys.schemas", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Xóa tất cả các mục hiện tại trong ComboBox
                        gan_TenQuyenHeThongCombobox.Items.Clear();

                        // Thêm từng quyền vào ComboBox
                        while (reader.Read())
                        {
                            string tenQuyen = reader.GetString(0);
                            gan_TenQuyenHeThongCombobox.Items.Add(tenQuyen);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách quyền: " + ex.Message);
            }
        }

        private void LoadTenDangnhapComboBox()
        {
            try
            {
                // Truy vấn cơ sở dữ liệu để lấy danh sách quyền
                using (SqlCommand cmd = new SqlCommand("SELECT name FROM sys.database_principals WHERE type_desc = 'SQL_USER';", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Xóa tất cả các mục hiện tại trong ComboBox
                        tenDangNhapComboBox.Items.Clear();

                        // Thêm từng quyền vào ComboBox
                        while (reader.Read())
                        {
                            string tenDN = reader.GetString(0);
                            tenDangNhapComboBox.Items.Add(tenDN);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách quyền: " + ex.Message);
            }
        }


        private void LoadBangComboBox()
        {
            try
            {
                // Truy vấn cơ sở dữ liệu để lấy danh sách tên bảng
                using (SqlCommand cmd = new SqlCommand("SELECT table_name FROM information_schema.tables", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Xóa tất cả các mục hiện tại trong ComboBox
                        pq_trenBangCombobox.Items.Clear();

                        // Thêm từng tên bảng vào ComboBox
                        while (reader.Read())
                        {
                            string tenBang = reader.GetString(0);
                            pq_trenBangCombobox.Items.Add(tenBang);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách bảng: " + ex.Message);
            }
        }

        private void pq_OkBTN_Click(object sender, EventArgs e)
        {       
            try
            {
                // Lấy thông tin từ các controls trên WinForm
                string roleName = pq_TenQuyenCombobox.SelectedItem.ToString();
                string permissionType = pq_quyenComboBox.SelectedItem.ToString();
                string tableName = pq_trenBangCombobox.SelectedItem.ToString();

                // Gọi stored procedure từ SQL Server
                using (SqlCommand cmd = new SqlCommand("AddPermissionsToRole", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Thêm tham số vào stored procedure
                    cmd.Parameters.AddWithValue("@RoleName", roleName);
                    cmd.Parameters.AddWithValue("@PermissionType", permissionType);
                    cmd.Parameters.AddWithValue("@TableName", tableName);

                    // Thực hiện stored procedure
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Đã thêm quyền truy cập thành công.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi thêm quyền truy cập: " + ex.Message);
            }
        }

        private void resetBTN_Click(object sender, EventArgs e)
        {
            ResetDataGridView();
        }


        private void ganQuyenBTN_Click(object sender, EventArgs e)
        {
            try
            {
                // Lấy thông tin từ các controls trên WinForm
                string userName = tenDangNhapComboBox.SelectedItem.ToString(); 
                string roleName = gan_TenQuyenHeThongCombobox.SelectedItem.ToString();

                // Gọi stored procedure từ SQL Server
                using (SqlCommand cmd = new SqlCommand("GrantSelectPermissionToUser", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Thêm tham số vào stored procedure
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@RoleName", roleName);

                    // Thực hiện stored procedure
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Đã gán quyền thành công.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi gán quyền: " + ex.Message);
            }
        }

        private void thuHoiQuyenBTN_Click(object sender, EventArgs e)
        {
            try
            {
                // Lấy thông tin từ các controls trên WinForm
                string userName = tenDangNhapComboBox.SelectedItem.ToString();
                string roleName = gan_TenQuyenHeThongCombobox.SelectedItem.ToString();

                // Gọi stored procedure từ SQL Server
                using (SqlCommand cmd = new SqlCommand("RevokeUserRole", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Thêm tham số vào stored procedure
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@RoleName", roleName);

                    // Thực hiện stored procedure
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Đã thu hồi quyền thành công.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi thu hồi quyền: " + ex.Message);
            }
        }


        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                // Đảm bảo rằng cell đã được chọn nằm trong giới hạn hợp lệ
                if (e.RowIndex >= 0 && e.RowIndex < dataGridView1.Rows.Count)
                {
                    // Lấy giá trị từ cell được chọn
                    DataGridViewRow selectedRow = dataGridView1.Rows[e.RowIndex];

                    // Hiển thị thông tin của hàng
                    string ma = selectedRow.Cells["TenLoaiQuyen"].Value.ToString();

                    
                    using(SqlCommand cmd = new SqlCommand("GetPermissionDetails", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@TenQuyen", ma);

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            // Đổ dữ liệu vào DataGridView
                            dataGridView2.DataSource = dt;
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex.Message);  
            }
        }

        private void pq_thuHoiBTN_Click(object sender, EventArgs e)
        {
            try
            {
                // Lấy thông tin từ các controls trên WinForm
                string roleName = pq_TenQuyenCombobox.SelectedItem.ToString();
                string permissionType = pq_quyenComboBox.SelectedItem.ToString();
                string tableName = pq_trenBangCombobox.SelectedItem.ToString();

                // Gọi stored procedure từ SQL Server
                using (SqlCommand cmd = new SqlCommand("RevokePermissionFromRole", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Thêm tham số vào stored procedure
                    cmd.Parameters.AddWithValue("@RoleName", roleName);
                    cmd.Parameters.AddWithValue("@PermissionType", permissionType);
                    cmd.Parameters.AddWithValue("@TableName", tableName);

                    // Thực hiện stored procedure
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("Đã thu hồi quyền truy cập thành công.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi thu hồi quyền truy cập: " + ex.Message);
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
