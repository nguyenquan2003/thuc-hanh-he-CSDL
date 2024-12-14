using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyRapChieuPhim.Admin
{
    public partial class QLNHANVIENn : Form
    {
        DataProvider dataProvider = new DataProvider();

        Function func = new Function();

        string fileImage;
        public QLNHANVIENn()
        {
            InitializeComponent();
            init();
        }
        private void init()
        {
            rdo_Male.Checked = true;
            Invisible();
            load_cbo_Position();
        }
        private void load_cbo_Position()
        {
            DataTable dt = new DataTable();
            dt = dataProvider.ExecQuery("Select * from ChucVu");
            cbo_Position.DisplayMember = "TenCV";
            cbo_Position.ValueMember = "MaCV";
            cbo_Position.DataSource = dt;

            cbo_Position.SelectedIndex = 1;

            cbo_Position.DropDownStyle = ComboBoxStyle.DropDownList;
        }
        private void Invisible()
        {
            labelFullname.Visible = false;
            labelPhonenumber.Visible = false;
            labelAddress.Visible = false;
            labelSalary.Visible = false;
            labelPosition.Visible = false;
            labelNoti.Visible = false;
            labelUsername.Visible = false;
            labelPassword.Visible = false;
        }

        private string getGender()
        {
            string gender = "";
            if (rdo_Male.Checked)
            {
                gender = rdo_Male.Text;
            }
            else if (rdo_Female.Checked)
            {
                gender = rdo_Female.Text;
            }
            else
            {
                gender = rdo_Other.Text;
            }
            return gender;
        }
        private void add_employee_and_user()
        {
            // Tạo mã nhân viên mới
            string MaNV = func.CreateEmpID();
            string MaCV = cbo_Position.SelectedValue.ToString();
            string TenNV = txt_Fullname.Text;
            string SDT = txt_Phonenumber.Text;
            string DiaChi = txt_Address.Text;
            string GioiTinh = getGender();
            string Luong = txt_Salary.Text;
            string username = txt_Username.Text;
            string password = txt_Password.Text;

            //------------------------------- Phần Ảnh Thẻ -------------------------------------------
            string pathImg = string.IsNullOrEmpty(fileImage) ? null : fileImage;
            string Img;

            if (!string.IsNullOrEmpty(pathImg))
            {
                SaveImageToContainFolder(pathImg, MaNV);
                string extension = Path.GetExtension(pathImg);
                Img = Path.GetFileName(MaNV + extension);
            }
            else
            {
                Img = "";
            }
            //----------------------------------------------------------------------------------------

            // Thêm nhân viên và tài khoản người dùng
            StringBuilder query = new StringBuilder("EXEC proc_AddNhanVienAndUser");
            query.Append(" @MaCV, @TenNhanVien, @SoDienThoai, @DiaChi, @GioiTinh, @Luong, @AnhThe, @TaiKhoanNV, @PasswordNV ");

            var parameters = new Dictionary<string, object>
            {
                { "@MaCV", MaCV },
                { "@TenNhanVien", TenNV },
                { "@SoDienThoai", SDT },
                { "@DiaChi", DiaChi },
                { "@GioiTinh", GioiTinh },
                { "@Luong", Luong },
                { "@AnhThe", Img },
                { "@TaiKhoanNV", username },
                { "@PasswordNV", password }
            };

            int result = dataProvider.ExecNonQuery(query.ToString(), parameters);
            if (result > 0)
            {
                labelNoti.Text = "Thêm nhân viên và tạo tài khoản thành công!";
                labelNoti.Visible = true;
            }
            else
            {
                labelNoti.Text = "Có lỗi xảy ra! Vui lòng kiểm tra lại.";
                labelNoti.Visible = true;
            }
        }
        private void notification_txtEmpty()
        {
            TextBox[] textBoxes = { txt_Fullname, txt_Phonenumber, txt_Address, txt_Salary, txt_Username, txt_Password };
            foreach (TextBox tb in textBoxes)
            {
                if (string.IsNullOrWhiteSpace(tb.Text))
                {
                    if (tb.Name == "txt_Fullname")
                    {
                        labelFullname.Text = "Please enter fullname";
                        labelFullname.ForeColor = Color.Red;
                        labelFullname.Visible = true;
                    }
                    if (tb.Name == "txt_Phonenumber")
                    {
                        labelPhonenumber.Text = "Please enter phone number";
                        labelPhonenumber.ForeColor = Color.Red;
                        labelPhonenumber.Visible = true;
                    }
                    if (tb.Name == "txt_Address")
                    {
                        labelAddress.Text = "Please enter address";
                        labelAddress.ForeColor = Color.Red;
                        labelAddress.Visible = true;
                    }
                    if (tb.Name == "txt_Salary")
                    {
                        labelSalary.Text = "Please enter salary";
                        labelSalary.ForeColor = Color.Red;
                        labelSalary.Visible = true;
                    }
                    if (tb.Name == "txt_Username")
                    {
                        labelUsername.Text = "Please enter username";
                        labelUsername.ForeColor = Color.Red;
                        labelUsername.Visible = true;
                    }
                    if (tb.Name == "txt_Password")
                    {
                        labelPassword.Text = "Please enter password";
                        labelPassword.ForeColor = Color.Red;
                        labelPassword.Visible = true;
                    }
                }
                else
                {
                    if (tb.Name == "txt_Fullname")
                    {
                        labelFullname.Visible = false;
                    }
                    if (tb.Name == "txt_Phonenumber")
                    {
                        labelPhonenumber.Visible = false;
                    }
                    if (tb.Name == "txt_Address")
                    {
                        labelAddress.Visible = false;
                    }
                    if (tb.Name == "txt_Salary")
                    {
                        labelSalary.Visible = false;
                    }
                    if (tb.Name == "txt_Username")
                    {
                        labelUsername.Visible = false;
                    }
                    if (tb.Name == "txt_Password")
                    {
                        labelPassword.Visible = false;
                    }
                }
            }
        }
        private void SaveImageToContainFolder(string imagePath, string primaryKey)
        {
            if (!File.Exists(imagePath))
            {
                MessageBox.Show("The source image file does not exist.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            string exstension = Path.GetExtension(imagePath);
            string fileName = primaryKey + exstension;

            string destinationDirectory = Path.Combine(Application.StartupPath, "AnhTheNhanVien");
            string destinationPath = Path.Combine(destinationDirectory, fileName);

            if (!Directory.Exists(destinationDirectory))
            {
                Directory.CreateDirectory(destinationDirectory);
            }

            try
            {
                File.Copy(imagePath, destinationPath, true);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error copying the file: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void btn_SignUp_Click(object sender, EventArgs e)
        {

        }

        private void label10_Click(object sender, EventArgs e)
        {

        }

        private void txt_Fullname_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_Username_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_Phonenumber_TextChanged(object sender, EventArgs e)
        {

        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void groupBox5_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
