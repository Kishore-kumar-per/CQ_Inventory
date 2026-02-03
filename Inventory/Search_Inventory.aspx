<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search_Inventory.aspx.cs" Inherits="Inventory.Search_Inventory" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Device Inventory</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

<style>

    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(to right, #d7e3ff, #edf2ff);
        margin: 0;
        padding: 0;
    }

        nav {
            background-color: #4A3C8C;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        nav h2 {
            margin: 0;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 15px;
        }

        .menu li {
            padding: 8px 16px;
            border-radius: 8px;
            background-color: #5D50A1;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        .menu li:hover {
            background-color: #8B7DD8;
        }

    .container {
        width: 90%;
        max-width: 1200px;
        margin: 30px auto;
        background: white;
        padding: 28px;
        border-radius: 16px;
        box-shadow: 0 12px 30px rgba(0,0,0,0.1);
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    h3 {
        font-size: 22px;
        margin-bottom: 25px;
        font-weight: 700;
        color: #4A3C8C;
        border-left: 6px solid #4A3C8C;
        padding-left: 12px;
    }

    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px 30px;
        margin-bottom: 25px;
    }

    .form-group label {
        font-size: 14px;
        font-weight: 600;
        color: #4A3C8C;
        margin-bottom: 6px;
        display: block;
    }

    .form-control {
        width: 100%;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #bfc6e2;
        font-size: 14px;
        transition: 0.2s ease;
    }

    .form-control:focus {
        border-color: #4A3C8C;
        box-shadow: 0 0 4px rgba(74,60,140,0.4);
    }

    .btn {
        padding: 12px 20px;
        background: #4A3C8C;
        border: none;
        color: white;
        width: 100%;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s ease;
    }

    .btn:hover {
        background: #6C5BCF;
        transform: translateY(-2px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 25px;
        border-radius: 10px;
        overflow: hidden;
    }

    .table th {
        background: #4A3C8C;
        color: white;
        padding: 12px;
        text-align: left;
        font-size: 15px;
    }

    .table td {
        padding: 12px;
        border: 1px solid #e1e1e1;
        background: #fff;
        font-size: 14px;
        line-height: 1.6;
    }

    .table tr:nth-child(even) {
        background: #f3f3ff;
    }

    .table tr:hover {
        background: #ebe6ff;
        transition: 0.2s;
    }

    .edit-button {
        color: #4A3C8C;
        font-weight: 600;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 6px;
        background: #e7e1ff;
        transition: 0.2s ease;
    }

    .edit-button:hover {
        background: #cfc5ff;
        transform: scale(1.05);
    }

</style>

</head>

<body>
<form id="form1" runat="server">

        <nav>
            <h2><i class="fas fa-laptop-code"></i> Inventory System</h2>
 <ul class="menu">
    <li><a href="login.aspx" style="color:white; text-decoration:none;"><i class="fas fa-home"></i> Login</a></li>
    <li><a href="Inventory.aspx" style="color:white; text-decoration:none;"><i class="fas fa-database"></i> Add Device</a></li>
    <li><a href="Search_Inventory.aspx" style="color:white; text-decoration:none;"><i class="fas fa-search"></i> Search</a></li>
    <li><a href="Inventory_Summary.aspx" style="color:white; text-decoration:none;"><i class="fas fa-chart-pie"></i> Summary</a></li>
</ul>

        </nav>

    <div class="container">

        <h3><i class="fas fa-search"></i> Filter Devices</h3>

        <div class="form-row">

            <div class="form-group">
                <label>Asset ID</label>
                <asp:TextBox ID="txtAssetID" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <label>Serial No</label>
                <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <label>Location</label>
                <asp:TextBox ID="txtlocation" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <label>Device Type</label>
                <asp:DropDownList ID="ddlDeviceType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Device" Value="" />
                    <asp:ListItem>CPU</asp:ListItem>
                    <asp:ListItem>IGX</asp:ListItem>
                    <asp:ListItem>Keyboard</asp:ListItem>
                    <asp:ListItem>Laptop</asp:ListItem>
                    <asp:ListItem>Monitor</asp:ListItem>
                    <asp:ListItem>Mouse</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                    <asp:ListItem>PBX</asp:ListItem>
                    <asp:ListItem>Printer</asp:ListItem>
                    <asp:ListItem>Projector</asp:ListItem>
                    <asp:ListItem>Router</asp:ListItem>
                    <asp:ListItem>Scanner</asp:ListItem>
                    <asp:ListItem>Server</asp:ListItem>
                    <asp:ListItem>Switch</asp:ListItem>
                    <asp:ListItem>Telephone</asp:ListItem>
                    <asp:ListItem>WiFi</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Status" Value="" />
                    <asp:ListItem>Working</asp:ListItem>
                    <asp:ListItem>Not Working</asp:ListItem>
                    <asp:ListItem>Ewaste</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn"
                    OnClick="btnSearch_Click" />
            </div>

        </div>

        <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="False">
            <Columns>

                <asp:BoundField DataField="Asset_ID" HeaderText="Asset ID" />
                <asp:BoundField DataField="Serial_No" HeaderText="Serial No" />
                <asp:BoundField DataField="Asset_Type" HeaderText="Device Type" />
                <asp:BoundField DataField="Model_Num" HeaderText="Model Number" />
                <asp:BoundField DataField="Asset_Status" HeaderText="Status" />
                <asp:BoundField DataField="Asset_Brand" HeaderText="Brand" />
                <asp:BoundField DataField="Location" HeaderText="Location" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkEdit" runat="server"
                            NavigateUrl='<%# Eval("Asset_ID", "Inventory.aspx?ID={0}&serial=Edit") %>'
                            CssClass="edit-button">
                            Edit
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>

</form>
</body>
</html>
