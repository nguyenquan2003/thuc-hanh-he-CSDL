namespace DoAn
{
    partial class DangNhap
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
            this.label6 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.tenTaiKhoanText = new System.Windows.Forms.TextBox();
            this.matKhauText = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.dangNhapBTN = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.label6.Location = new System.Drawing.Point(632, 142);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(162, 29);
            this.label6.TabIndex = 59;
            this.label6.Text = "ĐĂNG NHẬP";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(426, 197);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(88, 16);
            this.label1.TabIndex = 60;
            this.label1.Text = "Tên tài khoản";
            // 
            // tenTaiKhoanText
            // 
            this.tenTaiKhoanText.Location = new System.Drawing.Point(525, 197);
            this.tenTaiKhoanText.Name = "tenTaiKhoanText";
            this.tenTaiKhoanText.Size = new System.Drawing.Size(399, 22);
            this.tenTaiKhoanText.TabIndex = 61;
            // 
            // matKhauText
            // 
            this.matKhauText.Location = new System.Drawing.Point(525, 265);
            this.matKhauText.Name = "matKhauText";
            this.matKhauText.Size = new System.Drawing.Size(399, 22);
            this.matKhauText.TabIndex = 63;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(426, 265);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(61, 16);
            this.label2.TabIndex = 62;
            this.label2.Text = "Mật khẩu";
            // 
            // dangNhapBTN
            // 
            this.dangNhapBTN.Location = new System.Drawing.Point(647, 315);
            this.dangNhapBTN.Name = "dangNhapBTN";
            this.dangNhapBTN.Size = new System.Drawing.Size(118, 50);
            this.dangNhapBTN.TabIndex = 64;
            this.dangNhapBTN.Text = "Đăng nhập";
            this.dangNhapBTN.UseVisualStyleBackColor = true;
            this.dangNhapBTN.Click += new System.EventHandler(this.dangNhapBTN_Click);
            // 
            // DangNhap
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1385, 570);
            this.Controls.Add(this.dangNhapBTN);
            this.Controls.Add(this.matKhauText);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.tenTaiKhoanText);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label6);
            this.Name = "DangNhap";
            this.Text = "DangNhap";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox tenTaiKhoanText;
        private System.Windows.Forms.TextBox matKhauText;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button dangNhapBTN;
    }
}