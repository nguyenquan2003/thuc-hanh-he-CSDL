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
    public partial class formTimKimKhachHang : Form
    {
        public formTimKimKhachHang()
        {
            InitializeComponent();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Quantri qt = new Quantri();
            dataGridView1.DataSource = qt.XemthongtinKH(textBoxSDT.Text);
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Quantri qt = new Quantri();
            qt.addKH(textBoxsodt.Text, textBoxTen.Text, textBoxemail.Text);
            textBoxTen.Clear();
            textBoxsodt.Clear();
            textBoxemail.Clear();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
               
                DataGridViewRow selectedRow = dataGridView1.Rows[e.RowIndex];

              
                textBoxTen.Text = selectedRow.Cells[1].Value.ToString();
                textBoxsodt.Text = selectedRow.Cells[2].Value.ToString();
                textBoxemail.Text = selectedRow.Cells[3].Value.ToString();

            }
        }

        private void buttonXoa_Click(object sender, EventArgs e)
        {
            Quantri qt = new Quantri();
            DataGridViewRow firstRow = dataGridView1.Rows[0];
            DataGridViewCell cell = firstRow.Cells[0];
            qt.XoaKH(Convert.ToInt32(cell.Value));
        }
    }
}
