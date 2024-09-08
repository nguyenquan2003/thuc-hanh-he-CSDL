
namespace Doan_hqtcsdl
{
    partial class TraCuuSan
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
            this.Sa = new System.Windows.Forms.Label();
            this.comboNhaBong = new System.Windows.Forms.ComboBox();
            this.datatt = new System.Windows.Forms.DataGridView();
            this.Column1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.buttonTra = new System.Windows.Forms.Button();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.textBoxSTgio = new System.Windows.Forms.TextBox();
            this.textBoxSTPHUT = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.buttontrasanphuhop = new System.Windows.Forms.Button();
            this.comboBoxLoaisan = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.comboBoxLoc = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.textBoxENDgio = new System.Windows.Forms.TextBox();
            this.textBoxEndPhut = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.datatt)).BeginInit();
            this.SuspendLayout();
            // 
            // Sa
            // 
            this.Sa.AutoSize = true;
            this.Sa.Location = new System.Drawing.Point(49, 33);
            this.Sa.Name = "Sa";
            this.Sa.Size = new System.Drawing.Size(53, 13);
            this.Sa.TabIndex = 0;
            this.Sa.Text = "Sân bóng";
            // 
            // comboNhaBong
            // 
            this.comboNhaBong.FormattingEnabled = true;
            this.comboNhaBong.Location = new System.Drawing.Point(131, 25);
            this.comboNhaBong.Name = "comboNhaBong";
            this.comboNhaBong.Size = new System.Drawing.Size(121, 21);
            this.comboNhaBong.TabIndex = 1;
            this.comboNhaBong.SelectedIndexChanged += new System.EventHandler(this.comboNhaBong_SelectedIndexChanged);
            // 
            // datatt
            // 
            this.datatt.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.datatt.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column1,
            this.Column2,
            this.Column3});
            this.datatt.Location = new System.Drawing.Point(21, 189);
            this.datatt.Name = "datatt";
            this.datatt.Size = new System.Drawing.Size(330, 150);
            this.datatt.TabIndex = 3;
            // 
            // Column1
            // 
            this.Column1.DataPropertyName = "tenLoai";
            this.Column1.HeaderText = "Loại Sân";
            this.Column1.Name = "Column1";
            // 
            // Column2
            // 
            this.Column2.DataPropertyName = "TenNhaBong";
            this.Column2.HeaderText = "Tên Nhà Bóng";
            this.Column2.Name = "Column2";
            // 
            // Column3
            // 
            this.Column3.DataPropertyName = "GiaTien";
            this.Column3.HeaderText = "Gía Tiền";
            this.Column3.Name = "Column3";
            // 
            // buttonTra
            // 
            this.buttonTra.Location = new System.Drawing.Point(118, 80);
            this.buttonTra.Name = "buttonTra";
            this.buttonTra.Size = new System.Drawing.Size(170, 47);
            this.buttonTra.TabIndex = 4;
            this.buttonTra.Text = "Tra thông tin  sân bóng";
            this.buttonTra.UseVisualStyleBackColor = true;
            this.buttonTra.Click += new System.EventHandler(this.buttonTra_Click);
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.CustomFormat = "yyyy-MM-dd";
            this.dateTimePicker1.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dateTimePicker1.Location = new System.Drawing.Point(549, 25);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(200, 20);
            this.dateTimePicker1.TabIndex = 5;
            // 
            // textBoxSTgio
            // 
            this.textBoxSTgio.Location = new System.Drawing.Point(537, 65);
            this.textBoxSTgio.Name = "textBoxSTgio";
            this.textBoxSTgio.Size = new System.Drawing.Size(100, 20);
            this.textBoxSTgio.TabIndex = 6;
            // 
            // textBoxSTPHUT
            // 
            this.textBoxSTPHUT.Location = new System.Drawing.Point(671, 65);
            this.textBoxSTPHUT.Name = "textBoxSTPHUT";
            this.textBoxSTPHUT.Size = new System.Drawing.Size(100, 20);
            this.textBoxSTPHUT.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(477, 72);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(45, 13);
            this.label1.TabIndex = 7;
            this.label1.Text = "Bắt đầu";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(643, 72);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(22, 13);
            this.label2.TabIndex = 8;
            this.label2.Text = "--->";
            // 
            // buttontrasanphuhop
            // 
            this.buttontrasanphuhop.Location = new System.Drawing.Point(563, 173);
            this.buttontrasanphuhop.Name = "buttontrasanphuhop";
            this.buttontrasanphuhop.Size = new System.Drawing.Size(118, 38);
            this.buttontrasanphuhop.TabIndex = 9;
            this.buttontrasanphuhop.Text = "Tra sân phù hợp";
            this.buttontrasanphuhop.UseVisualStyleBackColor = true;
            this.buttontrasanphuhop.Click += new System.EventHandler(this.buttontrasanphuhop_Click);
            // 
            // comboBoxLoaisan
            // 
            this.comboBoxLoaisan.FormattingEnabled = true;
            this.comboBoxLoaisan.Location = new System.Drawing.Point(560, 137);
            this.comboBoxLoaisan.Name = "comboBoxLoaisan";
            this.comboBoxLoaisan.Size = new System.Drawing.Size(121, 21);
            this.comboBoxLoaisan.TabIndex = 10;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(475, 145);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 13);
            this.label3.TabIndex = 11;
            this.label3.Text = "Loại sân";
            // 
            // comboBoxLoc
            // 
            this.comboBoxLoc.FormattingEnabled = true;
            this.comboBoxLoc.Location = new System.Drawing.Point(537, 252);
            this.comboBoxLoc.Name = "comboBoxLoc";
            this.comboBoxLoc.Size = new System.Drawing.Size(164, 21);
            this.comboBoxLoc.TabIndex = 12;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(410, 260);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(101, 13);
            this.label4.TabIndex = 13;
            this.label4.Text = "Sân bóng khả dụng";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(671, 342);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(35, 13);
            this.label5.TabIndex = 14;
            this.label5.Text = "label5";
            // 
            // textBoxENDgio
            // 
            this.textBoxENDgio.Location = new System.Drawing.Point(537, 94);
            this.textBoxENDgio.Name = "textBoxENDgio";
            this.textBoxENDgio.Size = new System.Drawing.Size(100, 20);
            this.textBoxENDgio.TabIndex = 6;
            // 
            // textBoxEndPhut
            // 
            this.textBoxEndPhut.Location = new System.Drawing.Point(671, 94);
            this.textBoxEndPhut.Name = "textBoxEndPhut";
            this.textBoxEndPhut.Size = new System.Drawing.Size(100, 20);
            this.textBoxEndPhut.TabIndex = 6;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(477, 101);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(45, 13);
            this.label6.TabIndex = 7;
            this.label6.Text = "Bắt đầu";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(643, 101);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(22, 13);
            this.label7.TabIndex = 8;
            this.label7.Text = "--->";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(671, 374);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(35, 13);
            this.label8.TabIndex = 14;
            this.label8.Text = "label5";
            // 
            // TraCuuSan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.comboBoxLoc);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.comboBoxLoaisan);
            this.Controls.Add(this.buttontrasanphuhop);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBoxEndPhut);
            this.Controls.Add(this.textBoxSTPHUT);
            this.Controls.Add(this.textBoxENDgio);
            this.Controls.Add(this.textBoxSTgio);
            this.Controls.Add(this.dateTimePicker1);
            this.Controls.Add(this.buttonTra);
            this.Controls.Add(this.datatt);
            this.Controls.Add(this.comboNhaBong);
            this.Controls.Add(this.Sa);
            this.Name = "TraCuuSan";
            this.Text = "TraCuuSan";
            this.VisibleChanged += new System.EventHandler(this.TraCuuSan_VisibleChanged);
            ((System.ComponentModel.ISupportInitialize)(this.datatt)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label Sa;
        private System.Windows.Forms.ComboBox comboNhaBong;
        private System.Windows.Forms.DataGridView datatt;
        private System.Windows.Forms.Button buttonTra;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column1;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column2;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column3;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.TextBox textBoxSTgio;
        private System.Windows.Forms.TextBox textBoxSTPHUT;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button buttontrasanphuhop;
        private System.Windows.Forms.ComboBox comboBoxLoaisan;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox comboBoxLoc;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox textBoxENDgio;
        private System.Windows.Forms.TextBox textBoxEndPhut;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
    }
}