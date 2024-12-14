using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyRapChieuPhim.NhanVienBanVe
{
    public partial class NvBanVeHome : Form
    {
        public NvBanVeHome()
        {
            InitializeComponent();
        }

        private void CloseAllChildForms()
        {
            foreach (Form childForm in this.MdiChildren)
            {
                childForm.Close();
            }
        }

        private void DatVeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            DatVe f = new DatVe();
            f.MdiParent = this;
            f.Show();
        }

        private void dsDatVeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CloseAllChildForms();
            DsVeDaDat f = new DsVeDaDat();
            f.MdiParent = this;
            f.Show();
        }
    }
}
