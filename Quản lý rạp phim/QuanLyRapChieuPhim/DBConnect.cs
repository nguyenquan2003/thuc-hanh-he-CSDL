using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace QuanLyRapChieuPhim
{
    public class DBConnect
    {

        private string chuoiketnoi;
        public SqlConnection conn;

        public DBConnect(string user, string pass)
        {
            // đổi lại Data Source
            chuoiketnoi = @"Data Source=.;Initial Catalog=QuanLy_RapChieuPhim;User Id=" + user + ";Password=" + pass + ";";
            conn = new SqlConnection(chuoiketnoi);

        }

        public DBConnect()
        {
            chuoiketnoi = "Data Source=.;Initial Catalog=QuanLy_RapChieuPhim;Integrated Security=True";
            conn = new SqlConnection(chuoiketnoi);
        }

        public void Open()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
        }
        public void Close()
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
        public int getNonQuery(string sqlquery)
        {
            Open();
            SqlCommand cmd = new SqlCommand(sqlquery, conn);
            int kq = cmd.ExecuteNonQuery();
            Close();
            return kq;
        }
        public DataTable getDataTable(string sqlquery)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sqlquery, conn);
            //Nếu null thì bỏ qua
            if (da == null)
            {
                return new DataTable();
            }
            da.Fill(ds);
            return ds.Tables[0];
        }
        public object getScalar(string sqlquery)
        {
            Open();
            SqlCommand cmd = new SqlCommand(sqlquery, conn);
            object kq = (object)cmd.ExecuteScalar();
            Close();

            return kq;
        }
        public int updaTable(DataTable dtnew, string chuoitruyvan)
        {
            SqlDataAdapter da = new SqlDataAdapter(chuoitruyvan, conn);
            SqlCommandBuilder cb = new SqlCommandBuilder(da);
            int kq = da.Update(dtnew);

            return kq;
        }
    }
}
