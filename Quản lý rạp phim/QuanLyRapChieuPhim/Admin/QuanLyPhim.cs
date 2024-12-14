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
    public partial class QuanLyPhim : Form
    {
        DBConnect db = new DBConnect();
        public QuanLyPhim()
        {
            InitializeComponent();
            this.Load += QuanLyPhim_Load;
            btnThem.Click += BtnThem_Click;
            btnXoa.Click += BtnXoa_Click;
            btnSua.Click += BtnSua_Click;
            btnThemTheLoai.Click += BtnThemTheLoai_Click;
            btnXoaTheLoai.Click += BtnXoaTheLoai_Click;
            btnSuaTheLoai.Click += BtnSuaTheLoai_Click;
        }

        private void BtnSua_Click(object sender, EventArgs e)
        {
            //Sửa một phim
            string maPhim = txtMaPhim.Text;
            string tenPhim = txtTenPhim.Text;
            string theLoai = cbbTheLoaiPhim.SelectedValue.ToString();
            string thoiLuong = txtThoiLuong.Text;
            string ngayCongChieu = dateTimePicker1.Value.ToString("yyyy-MM-dd");
            string query = "UPDATE Phim SET TENPHIM = N'" + tenPhim + "', THOILUONG = '" + thoiLuong + "', NGAYPHATHANH = '" + ngayCongChieu + "' WHERE MAPHIM = '" + maPhim + "'";
            string query2 = "UPDATE PHIM_THELOAI SET MATL = '" + theLoai + "' WHERE MAPHIM = '" + maPhim + "'";

            int result = db.getNonQuery(query);
            int result2 = db.getNonQuery(query2);
            if (result > 0 && result2 > 0)
            {
                MessageBox.Show("Sửa phim thành công");
                LoadDanhSachPhim();
            }
            else
            {
                MessageBox.Show("Sửa phim thất bại");
            }
        }

        private void BtnXoa_Click(object sender, EventArgs e)
        {
            //Xóa phim được chọn từ gridview
            string maPhim = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            if (maPhim == null)
            {
                MessageBox.Show("Mã phim không có !!!");
            }
            string query = "DELETE FROM PHIM_THELOAI WHERE MAPHIM = '" + maPhim + "' AND MATL = '"+cbbTheLoaiPhim.SelectedValue.ToString()+"'";
            string query2 = "DELETE FROM PHIM WHERE MAPHIM = '" + maPhim + "'";
            int result = db.getNonQuery(query);
            int result2 = db.getNonQuery(query2);
            if (result > 0 && result2 > 0)
            {
                MessageBox.Show("Xóa phim thành công");
                LoadDanhSachPhim();
            }
            else
            {
                MessageBox.Show("Xóa phim thất bại");
            }
        }

        private void BtnSuaTheLoai_Click(object sender, EventArgs e)
        {
            //Sửa thể loại phim được chọn từ datagridview
            string maTheLoai = txtMaTheLoai.Text;
            string tenTheLoai = txtTenTheLoai.Text;
            string query = "UPDATE THELOAI SET TENTHELOAI = N'" + tenTheLoai + "' WHERE MATL = '" + maTheLoai + "'";
            int result = db.getNonQuery(query);
            if (result > 0)
            {
                MessageBox.Show("Sửa thể loại phim thành công");
                LoadDanhSachTheLoaiPhim();
            }
            else
            {
                MessageBox.Show("Sửa thể loại phim thất bại");
            }
        }

        private void BtnXoaTheLoai_Click(object sender, EventArgs e)
        {
            //Xóa thể loại phim được chọn từ datagridview
            string maTheLoai = dgvDsTheLoai.CurrentRow.Cells[0].Value.ToString();
            if (maTheLoai == null)
            {
                MessageBox.Show("Mã thể loại không có !!!");
            }
            string query = "DELETE FROM THELOAI WHERE MATL = '" + maTheLoai + "'";
            int result = db.getNonQuery(query);
            if (result > 0)
            {
                MessageBox.Show("Xóa thể loại phim thành công");
                LoadDanhSachTheLoaiPhim();
            }
            else
            {
                MessageBox.Show("Xóa thể loại phim thất bại");
            }
        }

        private void BtnThemTheLoai_Click(object sender, EventArgs e)
        {
            //Thêm mới thể loại phim từ các thông tin nhập vào
            string maTheLoai = txtMaTheLoai.Text;
            string tenTheLoai = txtTenTheLoai.Text;
            string query = "INSERT INTO THELOAI VALUES ('" + maTheLoai + "', N'" + tenTheLoai + "')";
            int result = db.getNonQuery(query);
            if (result > 0)
            {
                MessageBox.Show("Thêm thể loại phim thành công");
                LoadDanhSachTheLoaiPhim();
            }
            else
            {
                MessageBox.Show("Thêm thể loại phim thất bại");
            }
        }

        private void BtnThem_Click(object sender, EventArgs e)
        {
            //Thêm mới một phim từ các thông tin nhập vào
            string maPhim = txtMaPhim.Text;
            string tenPhim = txtTenPhim.Text;
            string theLoai = cbbTheLoaiPhim.SelectedValue.ToString();
            string thoiLuong = txtThoiLuong.Text;
            string ngayCongChieu = dateTimePicker1.Value.ToString("yyyy-MM-dd");
            string query = "INSERT INTO Phim VALUES ('" + maPhim + "', N'" + tenPhim + "', '" + thoiLuong + "', '" + ngayCongChieu + "')";
            string query2 = "INSERT INTO PHIM_THELOAI VALUES ('" + maPhim + "', '" + theLoai + "')";
            int result = db.getNonQuery(query);
            int result2 = db.getNonQuery(query2);
            if (result > 0 && result2 > 0)
            {
                MessageBox.Show("Thêm phim thành công");
                LoadDanhSachPhim();
            }
            else
            {
                MessageBox.Show("Thêm phim thất bại");
            }

        }

        private void QuanLyPhim_Load(object sender, EventArgs e)
        {
            //Load danh sách tất cả các phim bằng DBConnect lên dgvDsPhim
            LoadDanhSachPhim();
            LoadDanhSachTheLoaiPhim();
        }

        private void LoadDanhSachTheLoaiPhim()
        {
            //Load danh sách thể loại phim
            string query = "SELECT * FROM THELOAI";
            DataTable data = db.getDataTable(query);
            dgvDsTheLoai.DataSource = data;
            cbbTheLoaiPhim.DataSource = data;
            cbbTheLoaiPhim.DisplayMember = "TENTHELOAI";
            cbbTheLoaiPhim.ValueMember = "MATL";
            //Gắn sự kiện selectionchanged thì khi chọn 1 thể loại phim thì sẽ hiển thị mã thể loại phim tương ứng
            dgvDsTheLoai.SelectionChanged += DgvDsTheLoai_SelectionChanged;
        }

        private void DgvDsTheLoai_SelectionChanged(object sender, EventArgs e)
        {
            //Gắn sự kiện selectionchanged thì khi chọn 1 thể loại phim thì sẽ hiển thị mã thể loại phim tương ứng
            if (dgvDsTheLoai.CurrentRow != null)
            {
                txtMaTheLoai.Text = dgvDsTheLoai.CurrentRow.Cells[0].Value.ToString();
                txtTenTheLoai.Text = dgvDsTheLoai.CurrentRow.Cells[1].Value.ToString();
            }
        }

        private void LoadDanhSachPhim()
        {
            //Load danh sách phim
            string query = "SELECT * FROM Phim";

            DataTable data = db.getDataTable(query);
            dataGridView1.DataSource = data;
            //Gắn sự kiện selectionchanged thì khi chọn 1 phim thì sẽ hiển thị phim tương ứng
            dataGridView1.SelectionChanged += DataGridView1_SelectionChanged;

        }

        private void DataGridView1_SelectionChanged(object sender, EventArgs e)
        {
            //Gắn sự kiện selectionchanged thì khi chọn 1 phim thì sẽ hiển thị phim tương ứng
            if (dataGridView1.CurrentRow != null)
            {
                txtMaPhim.Text = dataGridView1.CurrentRow.Cells[0].Value.ToString();
                txtTenPhim.Text = dataGridView1.CurrentRow.Cells[1].Value.ToString();
                txtThoiLuong.Text = dataGridView1.CurrentRow.Cells[2].Value.ToString();
                dateTimePicker1.Value = DateTime.Parse(dataGridView1.CurrentRow.Cells[3].Value.ToString());
                //cbbTheLoaiPhim.SelectedValue = dataGridView1.CurrentRow.Cells[0].Value.ToString();
            }
        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void tabPage2_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void tabPage3_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

        }
    }
}
