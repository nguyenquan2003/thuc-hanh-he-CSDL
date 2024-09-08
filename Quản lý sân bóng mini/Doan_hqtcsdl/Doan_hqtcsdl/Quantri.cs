using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
namespace Doan_hqtcsdl
{
    class Quantri
    {
        string con = "Data Source=PHAPVO\\PHAPPHAP;Initial Catalog = QLSanBongMinii; Integrated Security = True";
        public Quantri()
        {

        }
        public DataTable NhaBong()
        {
            SqlConnection connect = new SqlConnection(con);
            string sql = "select MaNhaBong, TenNhaBong from NhaBong";
            SqlDataAdapter apter = new SqlDataAdapter(sql, connect);
            DataTable table = new DataTable();
            apter.Fill(table);
            return table;
        }
        public DataTable SanBong(int maNhaBong)
        {
            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("layTenSanBong",connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            // Thêm các tham số nếu có
            adapter.SelectCommand.Parameters.AddWithValue("@MaNhaBong", maNhaBong);

            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
        public DataTable XemthongtinSanBong(int maNhaBong)
        {
            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("XemthongtinSan", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@MaNhaBong", maNhaBong);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
        public DataTable XemSanBonghople(int maNhaBong,string gioST,string gioend,int maLoai)
        {
           
            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("tracuusanbongphuhop", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@MaNhaBong", maNhaBong);
            adapter.SelectCommand.Parameters.AddWithValue("@gioST",gioST);
            adapter.SelectCommand.Parameters.AddWithValue("@gioend",gioend);
            adapter.SelectCommand.Parameters.AddWithValue("@maloai", maLoai);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }

        public DataTable LoaiSan(int MaSanBong)
        {
            SqlConnection connect = new SqlConnection(con);
            string sql = "select DISTINCT sANBONG.MaLoai,tenLoai from LoaiSanBong,SanBong where SanBong.MaLoai = LoaiSanBong.MaLoai AND SanBong.MaNhaBong = "+MaSanBong+"";
            SqlDataAdapter apter = new SqlDataAdapter(sql, connect);
            DataTable table = new DataTable();
            apter.Fill(table);
            return table;
        }
        public DataTable XemthongtinKH(string sodt)
        {
            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("timKHtheoSodt", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@sodt", sodt);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
        public DataTable addKH(string sodt,string hoten,string email)
        {
            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("themKH", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@sodt", sodt);
            adapter.SelectCommand.Parameters.AddWithValue("@hoten", hoten);
            adapter.SelectCommand.Parameters.AddWithValue("@email", email);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
        public DataTable XoaKH(int makh)
        {
            SqlConnection connect = new SqlConnection(con);
            string sql = "delete from KhachHang where MaKhachHang="+makh+"";
            SqlDataAdapter apter = new SqlDataAdapter(sql, connect);
            DataTable table = new DataTable();
            apter.Fill(table);
            return table;
        }
        public DataTable dATSAN( string gioST, string gioend,string sodt,int maSanBong)
        {

            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("themDATSAN", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@giobd", gioST);
            adapter.SelectCommand.Parameters.AddWithValue("@giokt", gioend);
            adapter.SelectCommand.Parameters.AddWithValue("@maSanBong", maSanBong);
            adapter.SelectCommand.Parameters.AddWithValue("@sodt", sodt);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }
        public DataTable themhoadon(string sodt,string time)
        {

            SqlConnection connect = new SqlConnection(con);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("themHoaDonn", connect);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@ngayTT", time);
            adapter.SelectCommand.Parameters.AddWithValue("@sodt", sodt);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }

    }
}
