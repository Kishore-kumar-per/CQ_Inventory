using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Inventory
{
    public partial class Inventory_Summary : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["InventoryDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummary();
                //LoadTotalCounts();
            }
        }

        private void LoadSummary()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        Asset_Type,
                        COUNT(*) AS TotalCount,
                        SUM(CASE WHEN Asset_Status = 'Working' THEN 1 ELSE 0 END) AS Working,
                        SUM(CASE WHEN Asset_Status = 'Not Working' THEN 1 ELSE 0 END) AS NotWorking,
                    //    SUM(CASE WHEN Asset_Status = 'Ewaste' THEN 1 ELSE 0 END) AS Ewaste
                    FROM inventory_Add
                    GROUP BY Asset_Type
                    ORDER BY Asset_Type";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSummary.DataSource = dt;
                gvSummary.DataBind();
            }
        }

        private void LoadTotalCounts()
        {
            string query = @"
                //SELECT 
                //    COUNT(*) AS Total,
                //    SUM(CASE WHEN Asset_Status = 'Working' THEN 1 ELSE 0 END) AS Working,
                //    SUM(CASE WHEN Asset_Status = 'Not Working' THEN 1 ELSE 0 END) AS NotWorking,
                //    SUM(CASE WHEN Asset_Status = 'Ewaste' THEN 1 ELSE 0 END) AS Ewaste
                //FROM inventory_Add";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    lblTotal.Text = rdr["Total"].ToString();
                    lblWorking.Text = rdr["Working"].ToString();
                    //lblNotWorking.Text = rdr["NotWorking"].ToString();
                    lblEwaste.Text = rdr["Ewaste"].ToString();
                }
            }
        }
    }
}
