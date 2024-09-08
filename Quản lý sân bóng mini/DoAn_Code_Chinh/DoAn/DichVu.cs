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
    public partial class DichVu : Form
    {
        SqlConnection con;
        private TrangChu _form1;
        public DichVu(TrangChu form1)
        {
            try
            {
                InitializeComponent();
                _form1 = form1;
                con = new SqlConnection(Properties.Settings.Default.conStr);
                DisplayDichVuTable();

            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex.Message);
            }
        }

        private void DichVu_Load(object sender, EventArgs e)
        {

        }

        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            base.OnFormClosing(e);
            _form1.Show();
        }
        private void Form3_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult r;
            r = MessageBox.Show("Ban muốn thoat ?", "Thoát", MessageBoxButtons.YesNo);
            if (r == DialogResult.No)
                e.Cancel = true;
        }
        private void DisplayDichVuTable()
        {
            try
            {
                con.Open();
                string sql = "SELECT * FROM dichvu";
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                dataGridView1.DataSource = dataTable;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
            con.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int soLuong = (int)numericUpDown1.Value;
            // Giả sử giá dịch vụ là cột "GiaTien" trong DataTable
            int giaTien = Convert.ToInt32(dataGridView1.CurrentRow.Cells["GiaTien"].Value);

            // Tính thành tiền và cập nhật label6
            int thanhTien = soLuong * giaTien;
            label6.Text = $"Thành tiền: {thanhTien} VND";
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                // Lấy thông tin từ hàng được chọn
                DataGridViewRow selectedRow = dataGridView1.Rows[e.RowIndex];

                string tenDichVu = selectedRow.Cells["TenDV"].Value.ToString();
                MessageBox.Show($"Bạn đã chọn dịch vụ: {tenDichVu}");
            }
        }
    }
}
