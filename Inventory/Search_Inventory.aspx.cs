using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Inventory
{
    public partial class Search_Inventory : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["InventoryDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["serial"] == "Edit")
                {
                    Edit();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string assetId = txtAssetID.Text.Trim();
            string SerialNo = txtSerialNo.Text.Trim();
            string location = txtlocation.Text.Trim();
            string deviceType = ddlDeviceType.SelectedValue;
            string status = ddlStatus.SelectedValue;

            List<string> filters = new List<string>();
            SqlCommand cmd = new SqlCommand();

            string query = "SELECT * FROM inventory_Add WHERE Updated_By = 'Kishorekumar.B'";

            if (!string.IsNullOrEmpty(assetId))
            {
                filters.Add("Asset_ID LIKE @Asset_ID");
                cmd.Parameters.Add("@Asset_ID", SqlDbType.VarChar).Value = "%" + assetId + "%";
            }

            if (!string.IsNullOrEmpty(SerialNo))
            {
                filters.Add("Serial_No LIKE @Serial_No");
                cmd.Parameters.Add("@Serial_No", SqlDbType.VarChar).Value = "%" + SerialNo + "%";
            }

            if (!string.IsNullOrEmpty(location))
            {
                filters.Add("Location LIKE @Location");
                cmd.Parameters.Add("@Location", SqlDbType.VarChar).Value = "%" + location + "%";
            }

            if (!string.IsNullOrEmpty(deviceType))
            {
                filters.Add("Asset_Type = @Asset_Type");
                cmd.Parameters.Add("@Asset_Type", SqlDbType.VarChar).Value = deviceType;
            }

            if (!string.IsNullOrEmpty(status))
            {
                filters.Add("Asset_Status = @Asset_Status");
                cmd.Parameters.Add("@Asset_Status", SqlDbType.VarChar).Value = status;
            }

            if (filters.Count > 0)
            {
                query += " AND " + string.Join(" AND ", filters);
            }

            cmd.CommandText = query;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();

                if (dt.Rows.Count == 0)
                {
                    GridView1.EmptyDataText = "No matching records found.";
                    GridView1.DataBind();
                }
            }
        }

        void Edit()
        {
            string id = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(id)) return;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM inventory_Add WHERE Asset_ID = @Asset_ID AND deleted = 0";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Asset_ID", SqlDbType.VarChar).Value = id;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        Response.Redirect("Inventory.aspx?ID=" + id);
                    }
                }
            }
        }
    }
}
