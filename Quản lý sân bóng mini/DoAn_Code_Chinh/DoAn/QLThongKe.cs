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
    public partial class QLThongKe : Form
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlConnection con;
        DataColumn[] key = new DataColumn[1];
        public QLThongKe()
        {
            InitializeComponent();
            con = new SqlConnection(Properties.Settings.Default.conStr);
            if (con.State == ConnectionState.Closed)
                con.Open();
        }
        private void QLThongKe_Load(object sender, EventArgs e)
        {
            try
            {
                da = new SqlDataAdapter("select * from HOADON", con);
                da.Fill(ds, "HOADON");
                key[0] = ds.Tables["HOADON"].Columns[0];
                ds.Tables["HOADON"].PrimaryKey = key;
                dataGridView1.DataSource = ds.Tables["HOADON"];
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex.Message);
            }
        }
        private bool IsValidDateInput()
        {
            int day1, month1, year1, day2, month2, year2;

            // Kiểm tra xem các textbox chứa ngày có giá trị hợp lệ hay không
            if (!int.TryParse(textBox1.Text, out day1) || !int.TryParse(textBox2.Text, out month1) || !int.TryParse(textBox3.Text, out year1) ||
                !int.TryParse(textBox4.Text, out day2) || !int.TryParse(textBox5.Text, out month2) || !int.TryParse(textBox6.Text, out year2))
            {
                MessageBox.Show("Ngày nhập không hợp lệ. Vui lòng kiểm tra lại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }

            // Kiểm tra xem ngày tháng năm có hợp lệ hay không
            try
            {
                DateTime startDate = new DateTime(year1, month1, day1);
                DateTime endDate = new DateTime(year2, month2, day2);
                return true;
            }
            catch (ArgumentOutOfRangeException)
            {
                MessageBox.Show("Ngày nhập không hợp lệ. Vui lòng kiểm tra lại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
        }
        private void LoadDataBetweenDates(DateTime startDate, DateTime endDate)
        {
            using (SqlConnection connection = new SqlConnection(Properties.Settings.Default.conStr))
            {
                connection.Open();

                string query = "SELECT * FROM HOADON WHERE NgayThanhToan >= @StartDate AND NgayThanhToan < @EndDate";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StartDate", startDate);
                    command.Parameters.AddWithValue("@EndDate", endDate);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);

                        dataGridView1.DataSource = dataTable;

                        // Tính tổng tiền và hiển thị trong TextBox
                        decimal tongTien = 0;

                        foreach (DataRow row in dataTable.Rows)
                        {
                            // Giả sử cột TongTien trong DataTable là cột chứa tổng tiền của mỗi hóa đơn
                            // Thay đổi tên cột nếu cần thiết
                            if (row["ThanhTien"] != DBNull.Value)
                            {
                                tongTien += Convert.ToDecimal(row["ThanhTien"]);
                            }
                        }

                        tb_tongTien.Text = tongTien.ToString("F3"); // Hiển thị tổng tiền dưới dạng tiền tệ
                    }
                }
            }
        }
        private void btn_timKiem_Click(object sender, EventArgs e)
        {
            if (IsValidDateInput())
            {
                DateTime nt = new DateTime(int.Parse(textBox3.Text), int.Parse(textBox2.Text), int.Parse(textBox1.Text));
                DateTime ns = new DateTime(int.Parse(textBox6.Text), int.Parse(textBox5.Text), int.Parse(textBox4.Text));

                LoadDataBetweenDates(nt, ns);
            }
            else
            {
                MessageBox.Show("Ngày nhập không hợp lệ. Vui lòng kiểm tra lại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
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
