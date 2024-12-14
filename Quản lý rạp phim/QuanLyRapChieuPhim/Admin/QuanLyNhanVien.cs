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

namespace QuanLyRapChieuPhim
{
    public partial class QuanLyNhanVien : Form
    {

        DataProvider dataProvider = new DataProvider();

        Function func = new Function();

        string fileImage;
        public QuanLyNhanVien()
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
            string MaCV = cbo_Position.SelectedValue.ToString();
            string TenNV = txt_Fullname.Text;
            string SDT = txt_Phonenumber.Text;
            string DiaChi = txt_Address.Text;
            string GioiTinh = getGender();
            string Luong = txt_Salary.Text;
            string username = txt_Username.Text;
            string password = txt_Password.Text;


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
                { "@AnhThe", null },
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
            notification_txtEmpty();
            TextBox[] textBoxes = { txt_Fullname, txt_Phonenumber, txt_Address, txt_Salary, txt_Username, txt_Password };

            foreach (TextBox tb in textBoxes)
            {
                if (string.IsNullOrWhiteSpace(tb.Text))
                {
                    tb.Focus();
                    return;
                }
            }

            string query = "SELECT count(*) FROM TAIKHOAN WHERE TenDN = '" + txt_Username.Text + "'";

            object result = dataProvider.ExecScalar(query);

            if (int.Parse(result.ToString()) == 0)
            {
                add_employee_and_user();
            }
            else
            {
                labelNoti.Text = "";
                MessageBox.Show("Username already exists, please enter another name !", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void txt_Username_TextChanged(object sender, EventArgs e)
        {
            string query = "SELECT count(*) FROM TAIKHOAN WHERE TenDN = '" + txt_Username.Text + "'";

            object result = dataProvider.ExecScalar(query);

            if (int.Parse(result.ToString()) == 0)
            {
                pic_valid.Image = Properties.Resources.yes_35px;
            }
            else
            {
                pic_valid.Image = Properties.Resources.no_35px;
            }

            if (txt_Username.Text != "")
            {
                labelUsername.Visible = false;
            }

            if (txt_Username.Text == "")
            {
                pic_valid.Visible = false;
            }
            else
            {
                pic_valid.Visible = true;
            }
        }

        private void txt_Password_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && (e.KeyChar != '.'))
            {
                e.Handled = true;
            }

            if ((e.KeyChar == '.') && ((sender as TextBox).Text.IndexOf('.') > -1))
            {
                e.Handled = true;
            }
        }

        private void btn_Clear_Click(object sender, EventArgs e)
        {
            CardPhoto.Image = null;
            fileImage = "";
        }

        private void btn_ChooseImg_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFileDialog = new OpenFileDialog())
            {
                openFileDialog.Filter = "Image Files|*.jpg;*.jpeg;*.png;*.bmp";

                if (openFileDialog.ShowDialog() == DialogResult.OK)
                {
                    fileImage = openFileDialog.FileName;

                    if (string.IsNullOrEmpty(fileImage))
                    {
                        return;
                    }
                    Image img = Image.FromFile(fileImage);
                    CardPhoto.Image = img;
                }
            }
        }

        private void btn_Eye_Click(object sender, EventArgs e)
        {
            if (txt_Password.PasswordChar == '\0')
            {
                txt_Password.PasswordChar = '*';
                btn_Eye.Image = Properties.Resources.eyebrow;
            }
            else
            {
                txt_Password.PasswordChar = '\0';
                btn_Eye.Image = Properties.Resources.eye;
            }
        }

        private void btn_Reset_Click(object sender, EventArgs e)
        {
            Invisible();
            txt_Fullname.Clear();
            txt_Phonenumber.Clear();
            txt_Address.Clear();
            txt_Salary.Clear();
            load_cbo_Position();
            CardPhoto.Image = null;
            rdo_Male.Checked = true;
            pic_valid.Visible = false;
            txt_Username.Clear();
            txt_Password.Clear();
        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void tabPage2_Click(object sender, EventArgs e)
        {

        }
    }
}
