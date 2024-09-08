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
    public partial class HoaDon : Form
    {
        public HoaDon()
        {
            InitializeComponent();
        }

        private void HoaDon_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            int nam = dateTimePicker1.Value.Year;
            int thang = dateTimePicker1.Value.Month;
            int ngay = dateTimePicker1.Value.Day;
            DateTime specificDateTime = new DateTime(nam, thang, ngay);
            Quantri qt = new Quantri();
            qt.themhoadon(textBoxsodt.Text,specificDateTime.ToString("yyyy - MM - dd"));
        }

        private void button2_Click(object sender, EventArgs e)
        {
            MessageBox.Show("HÓA ĐƠN CỦA QUÝ KHÁCH TỔNG TIỀN LÀ 350000\n Tiền sân:300000\nTiền dịch vụ:50000");
        }
    }
}
