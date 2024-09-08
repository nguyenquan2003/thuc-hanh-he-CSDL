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
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace DoAn
{
    public partial class Form1 : Form
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        SqlConnection con;
        DataColumn[] key = new DataColumn[1];
        string tenBangDuocChon;
        public Form1()
        {
            InitializeComponent();
            con = new SqlConnection(Properties.Settings.Default.conStr);
            if (con.State == ConnectionState.Closed)
                con.Open();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            try
            {
                // Khởi tạo danh sách tên bảng
                List<string> tenBangs = new List<string>
                {
                    "NhaBong",
                    "SanBong",
                    "KhachHang",
                    "DatSan",
                    "HoaDon"
                };

                // Gán danh sách tên bảng cho ComboBox
                bangComboBox.DataSource = tenBangs;

                da = new SqlDataAdapter("select * from NhaBong", con);
                da.Fill(ds, "NhaBong");

                da = new SqlDataAdapter("select * from SanBong", con);
                da.Fill(ds, "SanBong");

                da = new SqlDataAdapter("select * from KhachHang", con);
                da.Fill(ds, "KhachHang");

                da = new SqlDataAdapter("select * from DatSan", con);
                da.Fill(ds, "DatSan");

                da = new SqlDataAdapter("select * from HoaDon", con);
                da.Fill(ds, "HoaDon");

                //dataGridView1.DataSource = ds.Tables[0];
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi" + ex);
            }
        }

        private void bangComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                // Lấy tên bảng được chọn từ ComboBox
                tenBangDuocChon = bangComboBox.SelectedItem.ToString();

                // Xóa dữ liệu hiện tại trong DataGridView
                dataGridView1.DataSource = null;
                dataGridView1.Rows.Clear();
                dataGridView1.Columns.Clear();

                // Lấy dữ liệu mới từ cơ sở dữ liệu
                da = new SqlDataAdapter($"select * from {tenBangDuocChon}", con);
                ds.Clear(); // Xóa dữ liệu hiện tại trong DataSet
                da.Fill(ds, $"{tenBangDuocChon}");

                // Gán dữ liệu mới vào DataGridView
                dataGridView1.DataSource = ds.Tables[$"{tenBangDuocChon}"];

                // Cập nhật ComboBox cho tìm kiếm
                timKiemTheoComboBox.Items.Clear();
                foreach (DataColumn column in ds.Tables[tenBangDuocChon].Columns)
                {
                    timKiemTheoComboBox.Items.Add(column.ColumnName);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Loi: " + ex.Message);
            }
        }


        private void timBTN_Click(object sender, EventArgs e)
        {
            try
            {
                string timKiemTheo = timKiemTheoComboBox.SelectedItem.ToString();
                string timKiemValue = thongTinText.Text;

                using (SqlCommand cmd = new SqlCommand("SearchData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TableName", tenBangDuocChon);
                    cmd.Parameters.AddWithValue("@SearchColumn", timKiemTheo);
                    cmd.Parameters.AddWithValue("@SearchValue", timKiemValue);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        ds.Clear();
                        adapter.Fill(ds, tenBangDuocChon);
                        dataGridView1.DataSource = ds.Tables[tenBangDuocChon];
                    }
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
