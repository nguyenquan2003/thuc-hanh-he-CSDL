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
    public partial class QLDatSan : Form
    {
        private int selectedSanId = -1;
        private string conStr = Properties.Settings.Default.conStr;
        private TrangChu _form1;
        private DateTime gioBatDau, gioKetThuc;
        public QLDatSan(TrangChu form1)
        {
            try
            {
                InitializeComponent();
                _form1 = form1;
                DisplayDatSanTable();
                LoadMaKH();
                foreach (Button button in Controls.OfType<Button>())
                {
                    if (button.Text.Contains("Sân"))
                    {
                        button.Click += button_Click;
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Loi: " + ex.Message);
            }
        }

        private void button_Click(object sender, EventArgs e)
        {
            Button clickedButton = sender as Button;

            if (clickedButton != null)
            {
                string buttonName = clickedButton.Text;
                int sanId;

                if (int.TryParse(buttonName.Substring(buttonName.Length - 1), out sanId))
                {
                    selectedSanId = sanId;
                    GetSanTime(selectedSanId);
                }
            }
        }

        private void GetSanTime(int sanId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    connection.Open();
                    string sql = "SELECT GioST, GioEnd FROM DatSan WHERE MaDatSan = @sanId";
                    SqlCommand cmd = new SqlCommand(sql, connection);
                    cmd.Parameters.AddWithValue("@sanId", sanId);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        gioBatDau = Convert.ToDateTime(reader["GioST"]);
                        gioKetThuc = Convert.ToDateTime(reader["GioEnd"]);

                        textBox1.Text = gioBatDau.ToString("HH:mm");
                        textBox3.Text = gioKetThuc.ToString("HH:mm");
                    }
                    else
                    {
                        MessageBox.Show($"Không tìm thấy thông tin cho Sân {sanId}");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void DisplayDatSanTable()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    connection.Open();
                    string sql = "SELECT * FROM DatSan";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    dataGridView1.DataSource = dataTable;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void LoadMaKH()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    connection.Open();
                    string sql = "SELECT makhachhang FROM khachhang";
                    SqlCommand cmd = new SqlCommand(sql, connection);

                    SqlDataReader read = cmd.ExecuteReader();
                    comboBox1.Items.Clear();
                    while (read.Read())
                    {
                        int makh = read.GetInt32(0);
                        comboBox1.Items.Add(makh);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Load ma khach hang that bai, Loi: " + ex);
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {

            if (selectedSanId != -1)
            {
                DateTime gioST = gioBatDau;
                DateTime gioEnd = gioKetThuc;
                int maKhachHang = int.Parse(comboBox1.SelectedItem.ToString());

                try
                {
                    using (SqlConnection connection = new SqlConnection(conStr))
                    {
                        connection.Open();

                        // Call the stored procedure
                        using (SqlCommand cmd = new SqlCommand("ThemDatSan", connection))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@GioST", gioST);
                            cmd.Parameters.AddWithValue("@GioEnd", gioEnd);
                            cmd.Parameters.AddWithValue("@MaSanBong", selectedSanId);
                            cmd.Parameters.AddWithValue("@MaKhachHang", maKhachHang);
                            cmd.ExecuteNonQuery();
                            GetAndDisplayPrice(selectedSanId);

                            DisplayDatSanTable();
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: " + ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Vui lòng chọn một sân trước khi đặt.");
            }
        }
        private void GetAndDisplayPrice(int sanId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    connection.Open();
                    string getPriceQuery = "SELECT GiaTien FROM LoaiSanBong WHERE MaLoai = (SELECT MaLoai FROM SanBong WHERE MaSanBong = @sanId)";
                    SqlCommand getPriceCmd = new SqlCommand(getPriceQuery, connection);
                    getPriceCmd.Parameters.AddWithValue("@sanId", sanId);
                    object result = getPriceCmd.ExecuteScalar();
                    if (result != null)
                    {
                        label1.Text = $"Giá sân: {result.ToString()} VND";
                    }
                    else
                    {
                        MessageBox.Show($"Không tìm thấy giá sân cho Sân {sanId}");
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void Form4_Load(object sender, EventArgs e)
        {

        }

        private void Form4_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult r;
            r = MessageBox.Show("Bạn muốn thoát?", "Thoát", MessageBoxButtons.YesNo);
            if (r == DialogResult.No)
                e.Cancel = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.Hide();
            TrangChu trangChu = new TrangChu();
            trangChu.Show();
        }

        private void QLDatSan_Load(object sender, EventArgs e)
        {

        }
    }
}
