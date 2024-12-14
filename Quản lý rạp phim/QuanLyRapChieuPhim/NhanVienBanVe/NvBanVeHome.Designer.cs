namespace QuanLyRapChieuPhim.NhanVienBanVe
{
    partial class NvBanVeHome
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.DatVeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dsDatVeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.DatVeToolStripMenuItem,
            this.dsDatVeToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1320, 28);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // DatVeToolStripMenuItem
            // 
            this.DatVeToolStripMenuItem.Name = "DatVeToolStripMenuItem";
            this.DatVeToolStripMenuItem.Size = new System.Drawing.Size(64, 24);
            this.DatVeToolStripMenuItem.Text = "Đặt vé";
            this.DatVeToolStripMenuItem.Click += new System.EventHandler(this.DatVeToolStripMenuItem_Click);
            // 
            // dsDatVeToolStripMenuItem
            // 
            this.dsDatVeToolStripMenuItem.Name = "dsDatVeToolStripMenuItem";
            this.dsDatVeToolStripMenuItem.Size = new System.Drawing.Size(134, 24);
            this.dsDatVeToolStripMenuItem.Text = "Danh sách vé đặt";
            this.dsDatVeToolStripMenuItem.Click += new System.EventHandler(this.dsDatVeToolStripMenuItem_Click);
            // 
            // NvBanVeHome
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1320, 647);
            this.Controls.Add(this.menuStrip1);
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "NvBanVeHome";
            this.Text = "NvBanVeHome";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem DatVeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem dsDatVeToolStripMenuItem;
    }
}