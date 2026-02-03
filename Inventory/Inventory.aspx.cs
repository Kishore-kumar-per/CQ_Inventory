using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Inventory
{
    public partial class Inventory : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["InventoryDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["serial"] == "Edit")
                {
                    Edit();
                }
                else
                {
                    txtAssetID.ReadOnly = false;

                }

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["serial"] == "Edit")
            {
                Update();
                txtAssetID.ReadOnly = true;

            }
            else
            {
                add();
            }
        }

        private void ClearFields()
        {
            txtSerialNo.Text = "";
            txtAssetID.Text = "";
            txtAssetName.Text = "";
            ddlDeviceType.SelectedIndex = 0;
            txtBrand.Text = "";
            txtModelNo.Text = "";
            txtPurchaseDate.Text = "";
            ddlStatus.SelectedIndex = 0;
            txtLocation.Text = "";
            txtAssignedTo.Text = "";
            txtNotes.Text = "";
        }

        void add()
        {
            if (txtAssetID.Text.Trim() != "" &&
                txtSerialNo.Text.Trim() != "" &&
                txtLocation.Text.Trim() != "" &&
                ddlDeviceType.SelectedValue != "" &&
                ddlStatus.SelectedValue != "")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO inventory_Add 
                    ([Serial_No], [Asset_ID], [Asset_Name], [Asset_Type], [Asset_Brand], [Model_Num], 
                     [Purchase_Date], [Asset_Status], [Location], [Assigned_To], [Asset_Notes]) 
                    VALUES 
                    (@SerialNo, @AssetID, @AssetName, @DeviceType, @Brand, @ModelNo, 
                     @PurchaseDate, @Status, @Location, @AssignedTo, @Notes)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@AssetID", txtAssetID.Text.Trim());
                    cmd.Parameters.AddWithValue("@AssetName", txtAssetName.Text.Trim());
                    cmd.Parameters.AddWithValue("@DeviceType", ddlDeviceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Brand", txtBrand.Text.Trim());
                    cmd.Parameters.AddWithValue("@ModelNo", txtModelNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@PurchaseDate", txtPurchaseDate.Text.Trim());
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@AssignedTo", txtAssignedTo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Notes", txtNotes.Text.Trim());

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('✅ Device added successfully.');", true);
                        ClearFields();
                    }
                    catch (SqlException ex)
                    {
                        string errorMsg = (ex.Number == 2627)
                            ? "⚠ Serial Number already exists. Please use a unique Serial Number."
                            : "❌ Database error: " + ex.Message.Replace("'", "\\'");

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('{errorMsg}');", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('⚠ Please fill all required fields: Serial No, Asset ID, Location, Device Type, and Status.');", true);
            }
        }

        void Edit()
        {
            string ID = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(ID))
                return;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = $"SELECT * FROM inventory_Add where Asset_ID='{ID}' ";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Asset_ID", ID);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    adapter.Fill(ds);

                    if (ds.Tables[0].Rows.Count >= 1)
                    {
                        DataRow row = ds.Tables[0].Rows[0];
                        txtSerialNo.Text = row["Serial_No"].ToString();
                        txtAssetID.Text = row["Asset_ID"].ToString();
                        txtAssetName.Text = row["Asset_Name"].ToString();

                        if (ddlDeviceType.Items.FindByValue(row["Asset_Type"].ToString()) != null)
                            ddlDeviceType.SelectedValue = row["Asset_Type"].ToString();

                        txtBrand.Text = row["Asset_Brand"].ToString();
                        txtModelNo.Text = row["Model_Num"].ToString();

                        if (DateTime.TryParse(row["Purchase_Date"].ToString(), out DateTime purchaseDate))
                            txtPurchaseDate.Text = purchaseDate.ToString("yyyy-MM-dd");

                        if (ddlStatus.Items.FindByValue(row["Asset_Status"].ToString()) != null)
                            ddlStatus.SelectedValue = row["Asset_Status"].ToString();

                        txtLocation.Text = row["Location"].ToString();
                        txtAssignedTo.Text = row["Assigned_To"].ToString();
                        txtNotes.Text = row["Asset_Notes"].ToString();

                        txtAssetID.ReadOnly = true; // Prevent editing the primary key
                    }
                }
            }
        }
        void Update()
        {
            // Mandatory field check (use AND instead of OR)
            if (!string.IsNullOrWhiteSpace(txtAssetID.Text) ||
                !string.IsNullOrWhiteSpace(txtSerialNo.Text) ||
                !string.IsNullOrWhiteSpace(txtLocation.Text) ||
                ddlDeviceType.SelectedValue != "" ||
                ddlStatus.SelectedValue != "")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE inventory_Add 
                             SET 
                                Serial_No = @SerialNo,
                                Asset_Name = @AssetName,
                                Asset_Type = @DeviceType,
                                Asset_Brand = @Brand,
                                Model_Num = @ModelNo,
                                Purchase_Date = @PurchaseDate,
                                Asset_Status = @Status,
                                Location = @Location,
                                Assigned_To = @AssignedTo,
                                Asset_Notes = @Notes
                             WHERE Asset_ID = @AssetID";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@AssetID", txtAssetID.Text.Trim()); // Matches WHERE clause
                    cmd.Parameters.AddWithValue("@AssetName", txtAssetName.Text.Trim());
                    cmd.Parameters.AddWithValue("@DeviceType", ddlDeviceType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Brand", txtBrand.Text.Trim());
                    cmd.Parameters.AddWithValue("@ModelNo", txtModelNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@PurchaseDate", txtPurchaseDate.Text.Trim());

                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@AssignedTo", txtAssignedTo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Notes", txtNotes.Text.Trim());

                    try
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('✅ Device updated successfully.');", true);
                            ClearFields();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('⚠ Device not found. Please check Asset ID.');", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        string errorMsg = (ex.Number == 2627)
                            ? "⚠ Serial Number already exists. Please use a unique Serial Number."
                            : "❌ Database error: " + ex.Message.Replace("'", "\\'");

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('{errorMsg}');", true);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('⚠ Please fill all required fields: Asset ID, Serial No, Location, Device Type, and Status.');", true);
            }
        }

    }
}
