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
    public partial class QLSancs : Form
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlConnection con;
        DataColumn[] key = new DataColumn[1];
        public QLSancs()
        {
            InitializeComponent();
            con = new SqlConnection(Properties.Settings.Default.conStr);
            if (con.State == ConnectionState.Closed)
                con.Open();
        }

        private void QLSancs_Load(object sender, EventArgs e)
        {
            try
            {
                da = new SqlDataAdapter("select * from SanBong", con);
                da.Fill(ds, "SanBong");

                dataGridView1.DataSource = ds.Tables["SanBong"];
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex);
            }
        }

        private void suaBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("CapNhatThongTinSanBong", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaSanBong", maSanBongText.Text);
                    cmd.Parameters.AddWithValue("@TenSanBong", tenSanBongText.Text);
                    cmd.Parameters.AddWithValue("@MaLoai", getMaLoaiRadio());
                    cmd.Parameters.AddWithValue("@MaNhaBong", getMaNhaBongRadio());

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Sửa thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
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
                    string ma = selectedRow.Cells["MaSanBong"].Value.ToString();
                    string name = selectedRow.Cells["TenSanBong"].Value.ToString(); 
                    int maLoai = int.Parse(selectedRow.Cells["MaLoai"].Value.ToString()); 
                    int maNhaBong = int.Parse(selectedRow.Cells["MaNhaBong"].Value.ToString());

                    maSanBongText.Text = ma;
                    tenSanBongText.Text = name;
                    setMaLoaiRadio(maLoai);
                    setLoaiNhaBongRadio(maNhaBong);
                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            
        }

        private void ResetDataGridView()
        {
            ds.Tables["SanBong"].Rows.Clear();
            // Nạp lại dữ liệu từ CSDL
            da.Fill(ds, "SanBong");

            // Gắn lại DataTable vào DataGridView và làm mới
            dataGridView1.DataSource = ds.Tables["SanBong"];
            dataGridView1.Refresh();
        }

        private void setMaLoaiRadio(int maLoai)
        {
            switch(maLoai)
            {
                case 1:
                    loaiSan1Radio.Checked = true;
                    break;
                case 2:
                    loaiSan2Radio.Checked = true;
                    break;
                //case 3:
                //    loaiSan3Radio.Checked = true;
                //    break;
                //case 4:
                //    loaiSan4Radio.Checked = true;
                //    break;
                //case 5:
                //    loaiSan5Radio.Checked = true;
                //    break;
            }
        }

        private int getMaLoaiRadio()
        {
            if (loaiSan1Radio.Checked == true)
            {
                return 1;
            }
            else if (loaiSan2Radio.Checked == true)
            {
                return 2;
            }
            //else if (loaiSan3Radio.Checked == true)
            //{
            //    return 3;
            //}
            //else if (loaiSan4Radio.Checked == true)
            //{
            //    return 4;
            //}
            else
            {
                return 5;
            }
        }

        private void setLoaiNhaBongRadio(int maLoai)
        {
            switch (maLoai)
            {
                case 1:
                    loaiNhaBong1Radio.Checked = true;
                    break;
                case 2:
                    loaiNhaBong2Radio.Checked = true;
                    break;
                case 3:
                    loaiNhaBong3Radio.Checked = true;
                    break;
                case 4:
                    loaiNhaBong4Radio.Checked = true;
                    break;
                case 5:
                    loaiNhaBong5Radio.Checked = true;
                    break;
            }
        }

        private int getMaNhaBongRadio()
        {
            if(loaiNhaBong1Radio.Checked == true)
            {
                return 1;
            }
            else if (loaiNhaBong2Radio.Checked == true)
            {
                return 2;
            }
            else if (loaiNhaBong3Radio.Checked == true)
            {
                return 3;
            }
            else if (loaiNhaBong4Radio.Checked == true)
            {
                return 4;
            }
            else
            {
                return 5;
            }
        }

        private void themBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("ThemSanBong", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TenSanBong", tenSanBongText.Text);
                    cmd.Parameters.AddWithValue("@MaLoai", getMaLoaiRadio());
                    cmd.Parameters.AddWithValue("@MaNhaBong", getMaNhaBongRadio());

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Thêm thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void resetBTN_Click(object sender, EventArgs e)
        {
            ResetDataGridView();
        }

        private void xoaBTN_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("XoaSanBong", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaSanBong", maSanBongText.Text);

                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Xóa thành công");
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
