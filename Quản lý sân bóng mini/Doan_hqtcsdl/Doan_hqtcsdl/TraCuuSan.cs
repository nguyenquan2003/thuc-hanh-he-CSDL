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
    public partial class TraCuuSan : Form
    {
        public TraCuuSan()
        {
            InitializeComponent();
        }

        private void TraCuuSan_VisibleChanged(object sender, EventArgs e)
        {

            Quantri qt = new Quantri();
            comboNhaBong.DataSource = qt.NhaBong();
            comboNhaBong.DisplayMember = "TenNhaBong";
            comboNhaBong.ValueMember = "MaNhaBong";
            comboBoxLoaisan.DataSource = qt.LoaiSan(1);
            comboBoxLoaisan.DisplayMember = "tenLoai";
            comboBoxLoaisan.ValueMember = "MaLoai";
        }

        private void buttonTra_Click(object sender, EventArgs e)
        {
            Quantri qt = new Quantri();
            datatt.DataSource = qt.XemthongtinSanBong(Convert.ToInt32(comboNhaBong.SelectedValue));
        }

        private void buttontrasanphuhop_Click(object sender, EventArgs e)
        {
            
            int nam = dateTimePicker1.Value.Year;
            int thang = dateTimePicker1.Value.Month;
            int ngay = dateTimePicker1.Value.Day;
            DateTime specificDateTime = new DateTime(nam, thang, ngay,Convert.ToInt32(textBoxSTgio.Text), Convert.ToInt32(textBoxSTPHUT.Text),0);
            string hbatdau = specificDateTime.ToString("yyyy-MM-dd HH:mm:ss");
            DateTime specificDateTime2 = new DateTime(nam, thang, ngay, Convert.ToInt32(textBoxENDgio.Text), Convert.ToInt32(textBoxSTPHUT.Text), 0);
            string ketthuc = specificDateTime2.ToString("yyyy-MM-dd HH:mm:ss");
            DateTime hst = Convert.ToDateTime(hbatdau);
            DateTime hkt = Convert.ToDateTime(ketthuc);
            Quantri qt = new Quantri();
            comboBoxLoc.DataSource = qt.XemSanBonghople(Convert.ToInt32(comboNhaBong.SelectedValue), hbatdau, ketthuc, Convert.ToInt32(comboBoxLoaisan.SelectedValue));
            comboBoxLoc.DisplayMember = "TenSanBong";

        }

        private void comboNhaBong_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Quantri qt = new Quantri();
            //comboBoxLoaisan.DataSource = qt.LoaiSan(Convert.ToInt32(comboNhaBong.SelectedValue));
            //comboBoxLoaisan.DisplayMember = "tenLoai";
            //comboBoxLoaisan.ValueMember = "MaLoai";

        }

       
    }
}
