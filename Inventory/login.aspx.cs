using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace Inventory
{
    public partial class login : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["InventoryDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Session.Clear();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim().ToUpper();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT PasswordHash FROM Inventory_Login WHERE Username = @Username";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();

                var storedPassword = cmd.ExecuteScalar() as string;

                if (!string.IsNullOrEmpty(storedPassword) && storedPassword == password)
                {
                    Session["User"] = username;
                    Response.Redirect("Search_Inventory.aspx");
                }
                else
                {
                    lblError.Text = "❌ Invalid username or password.";
                    lblForgotMessage.Text = "";
                }
            }
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            string email = txtForgotEmail.Text.Trim();

            if (!string.IsNullOrWhiteSpace(email))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT Username, PasswordHash FROM Inventory_Login WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string username = reader["Username"].ToString();
                            string password = reader["PasswordHash"].ToString();

                            SendPasswordByEmail(email, username, password);

                            lblForgotMessage.Text = "📩 Your password has been sent to your email.";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('📩 Password sent to your email successfully!');", true);
                        }
                        else
                        {
                            lblForgotMessage.Text = "❌ Email not found. Please check and try again.";
                        }
                    }
                }
                lblError.Text = "";
            }
            else
            {
                lblForgotMessage.Text = "⚠️ Please enter your registered email.";
            }
        }

        private void SendPasswordByEmail(string email, string username, string password)
        {
            MailMessage message = new MailMessage
            {
                From = new MailAddress("bkishore355@gmail.com"),
                Subject = "Your CQ Inventory Login Details",
                IsBodyHtml = true,
                Body = $"<html><body style='font-family:Segoe UI,Arial,sans-serif;background:#f9f9f9;padding:20px;'>" +
                       $"<div style='max-width:600px;margin:auto;background:#fff;border:1px solid #ddd;border-radius:10px;padding:20px;box-shadow:0 4px 8px rgba(0,0,0,0.05);'>" +
                       $"<h2 style='color:#6A1B9A;'>Password Recovery</h2>" +
                       $"<p style='font-size:15px;color:#333;'>Hello <strong>{username}</strong>,</p>" +
                       $"<p style='font-size:14px;color:#555;'>We received a request to retrieve your login credentials. Your password is:</p>" +
                       $"<div style='background:#f1f1f1;padding:12px;border-radius:5px;margin:20px 0;font-size:16px;color:#0d6efd;text-align:center;font-weight:bold;'>{password}</div>" +
                       $"<p style='color:#dc3545;font-size:14px;'><strong>Please change your password after logging in for your security.</strong></p>" +
                       $"<p style='font-size:14px;'>Best regards,<br/><span style='color:#6A1B9A;font-weight:bold;'>IT Team</span></p></div></body></html>"
            };

            message.To.Add(email);

            SmtpClient client = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("bkishore355@gmail.com", "jscj qqkq nlfl pfyt")
            };  

            client.Send(message);
        }
    }
}
