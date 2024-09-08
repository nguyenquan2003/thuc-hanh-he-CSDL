using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Doan_hqtcsdl
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private Form curentchild;
        private void openForm(Form childform)
        {
            if (curentchild != null)
            {
                curentchild.Close();
            }
                curentchild = childform;
                childform.TopLevel = false;
                childform.FormBorderStyle = FormBorderStyle.None;
                childform.Dock = DockStyle.Fill;
                panelbody.Controls.Add(childform);
                panelbody.Tag = childform;
                childform.BringToFront();
                childform.Show();
            
        }
            private void panel3_VisibleChanged(object sender, EventArgs e)
                
        {
            Quantri qt = new Quantri();
            comboNhaBong.DataSource = qt.NhaBong();
            comboNhaBong.DisplayMember = "TenNhaBong";
            comboNhaBong.ValueMember = "MaNhaBong";
            comboSanBong.DataSource = qt.SanBong(Convert.ToInt32(comboNhaBong.SelectedValue));
            comboSanBong.DisplayMember = "TenSanBong";
            comboSanBong.ValueMember = "MaSanBong";
        }

        private void buttonTraCuu_Click(object sender, EventArgs e)
        {
            openForm(new formTimKimKhachHang());
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            if (curentchild != null)
            {
                curentchild.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            openForm(new TraCuuSan());
        }

        private void butHome_Click(object sender, EventArgs e)
        {
            if (curentchild != null)
            {
                curentchild.Close();
            }
        }

        private void comboNhaBong_SelectedValueChanged(object sender, EventArgs e)
        {
            Quantri qt = new Quantri();
            comboSanBong.DataSource = qt.SanBong(Convert.ToInt32(2));
            comboSanBong.DisplayMember = "TenSanBong";
            comboSanBong.ValueMember = "MaSanBong";

        }

        private void comboNhaBong_TextChanged(object sender, EventArgs e)
        {
            //Quantri qt = new Quantri();
            //comboSanBong.DataSource = qt.SanBong(Convert.ToInt32(comboNhaBong.SelectedValue));
            //comboSanBong.DisplayMember = "TenSanBong";
            //comboSanBong.ValueMember = "MaSanBong";
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            int nam = dateTimePicker1.Value.Year;
            int thang = dateTimePicker1.Value.Month;
            int ngay = dateTimePicker1.Value.Day;
            DateTime specificDateTime = new DateTime(nam, thang, ngay, Convert.ToInt32(textBoxSTgio.Text), Convert.ToInt32(textBoxSTPHUT.Text), 0);
            string hbatdau = specificDateTime.ToString("yyyy-MM-dd HH:mm:ss");
            DateTime specificDateTime2 = new DateTime(nam, thang, ngay, Convert.ToInt32(textBoxENDgio.Text), Convert.ToInt32(textBoxSTPHUT.Text), 0);
            string ketthuc = specificDateTime2.ToString("yyyy-MM-dd HH:mm:ss");
            DateTime hst = Convert.ToDateTime(hbatdau);
            DateTime hkt = Convert.ToDateTime(ketthuc);
            Quantri qt = new Quantri();
           
        

            try
            {
                qt.dATSAN(hbatdau, ketthuc, textBoxSODT.Text, Convert.ToInt32(comboSanBong.SelectedValue));
                MessageBox.Show("DA THEM THANH CONG");
            }
           
            catch (Exception ex)
            {

                MessageBox.Show(ex.ToString());
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            openForm(new HoaDon());
        }


        //{
        //    Quantri qt = new Quantri();
        //    comboSanBong.Items.Clear();


        //        comboSanBong.DataSource = qt.SanBong(1);
        //        comboSanBong.DisplayMember = "TenSanBong";
        //        comboSanBong.ValueMember = "MaSanBong";




    }
}
