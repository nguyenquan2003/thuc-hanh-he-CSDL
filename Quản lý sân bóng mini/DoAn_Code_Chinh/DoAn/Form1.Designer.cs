namespace DoAn
{
    partial class Form1
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.timKiemTheoComboBox = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.timBTN = new System.Windows.Forms.Button();
            this.thongTinText = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.bangComboBox = new System.Windows.Forms.ComboBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(603, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(293, 29);
            this.label1.TabIndex = 0;
            this.label1.Text = "CHỨC NĂNG TÌM KIẾM ";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(44, 47);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(134, 18);
            this.label2.TabIndex = 1;
            this.label2.Text = "Tìm kiếm trên bảng";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(505, 46);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(102, 18);
            this.label3.TabIndex = 2;
            this.label3.Text = "Tìm kiếm theo";
            // 
            // timKiemTheoComboBox
            // 
            this.timKiemTheoComboBox.FormattingEnabled = true;
            this.timKiemTheoComboBox.Location = new System.Drawing.Point(632, 46);
            this.timKiemTheoComboBox.Name = "timKiemTheoComboBox";
            this.timKiemTheoComboBox.Size = new System.Drawing.Size(172, 24);
            this.timKiemTheoComboBox.TabIndex = 3;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.timBTN);
            this.groupBox1.Controls.Add(this.thongTinText);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.bangComboBox);
            this.groupBox1.Controls.Add(this.timKiemTheoComboBox);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Location = new System.Drawing.Point(289, 74);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(881, 200);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "groupBox1";
            // 
            // timBTN
            // 
            this.timBTN.Location = new System.Drawing.Point(632, 106);
            this.timBTN.Name = "timBTN";
            this.timBTN.Size = new System.Drawing.Size(122, 63);
            this.timBTN.TabIndex = 7;
            this.timBTN.Text = "Tìm";
            this.timBTN.UseVisualStyleBackColor = true;
            this.timBTN.Click += new System.EventHandler(this.timBTN_Click);
            // 
            // thongTinText
            // 
            this.thongTinText.Location = new System.Drawing.Point(193, 126);
            this.thongTinText.Name = "thongTinText";
            this.thongTinText.Size = new System.Drawing.Size(387, 22);
            this.thongTinText.TabIndex = 6;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(44, 126);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(103, 18);
            this.label4.TabIndex = 5;
            this.label4.Text = "Nhập thông tin";
            // 
            // bangComboBox
            // 
            this.bangComboBox.FormattingEnabled = true;
            this.bangComboBox.Location = new System.Drawing.Point(193, 46);
            this.bangComboBox.Name = "bangComboBox";
            this.bangComboBox.Size = new System.Drawing.Size(201, 24);
            this.bangComboBox.TabIndex = 4;
            this.bangComboBox.SelectedIndexChanged += new System.EventHandler(this.bangComboBox_SelectedIndexChanged);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(289, 329);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(881, 272);
            this.dataGridView1.TabIndex = 5;
            // 
            // button1
            // 
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.button1.Location = new System.Drawing.Point(21, 16);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(65, 38);
            this.button1.TabIndex = 64;
            this.button1.Text = "Thoát";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1400, 627);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox timKiemTheoComboBox;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button timBTN;
        private System.Windows.Forms.TextBox thongTinText;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox bangComboBox;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button button1;
    }
}

