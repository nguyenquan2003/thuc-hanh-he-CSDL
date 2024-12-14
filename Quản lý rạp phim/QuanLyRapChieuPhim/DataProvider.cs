using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyRapChieuPhim
{
    internal class DataProvider
    {
        public string ConnectionString = "Data Source=.;Initial Catalog=QuanLy_RapChieuPhim;Integrated Security=True";

        public DataTable ExecQuery(string query, Dictionary<string, object> parameters = null)
        {
            DataTable data = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.AddWithValue(param.Key, param.Value);
                        }
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(data);
                    }
                }
            }
            return data;
        }


        public int ExecNonQuery(string query, Dictionary<string, object> parameters = null)
        {
            int data = 0;
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.AddWithValue(param.Key, param.Value);
                        }
                    }

                    data = cmd.ExecuteNonQuery();
                }
            }
            return data;
        }


        public object ExecScalar(string query, Dictionary<string, object> parameters = null)
        {
            if (string.IsNullOrEmpty(query))
            {
                throw new ArgumentException("Query không được để trống!", nameof(query));
            }

            try
            {
                object data = null;

                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Kiểm tra và thêm tham số nếu có
                        if (parameters != null)
                        {
                            foreach (var param in parameters)
                            {
                                cmd.Parameters.AddWithValue(param.Key, param.Value ?? DBNull.Value); // Handle null parameters
                            }
                        }

                        // Thực thi truy vấn
                        data = cmd.ExecuteScalar();
                    }
                }

                return data;
            }
            catch (Exception ex)
            {
                // Log lỗi ra file hoặc hiển thị thông báo
                Console.WriteLine($"Lỗi khi thực thi truy vấn: {ex.Message}");
                return null; // Trả về null khi lỗi
            }
        }
    }

}
