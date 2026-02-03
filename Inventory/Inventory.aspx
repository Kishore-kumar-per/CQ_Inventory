<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="Inventory.Inventory" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Device Inventory Entry</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
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
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #4A3C8C;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 1.5rem;
        }

        .form-group {
            flex: 1;
            min-width: 250px;
        }

        label {
            font-weight: 700;
            font-size: 16px;
            display: block;
            margin-bottom: 6px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            width: 100%;
            padding: 12px 24px;
            background-color: #4A3C8C;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #6A5ACD;
        }

        @media screen and (max-width: 768px) {
            .form-row {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav>
            <h2><i class="fas fa-laptop-code"></i> Inventory System</h2>
 <ul class="menu">
    <li><a href="login.aspx" style="color:white; text-decoration:none;"><i class="fas fa-home"></i> Login</a></li>
    <li><a href="Inventory.aspx" style="color:white; text-decoration:none;"><i class="fas fa-database"></i> Add Device</a></li>
    <li><a href="Search_Inventory.aspx" style="color:white; text-decoration:none;"><i class="fas fa-search"></i> Search</a></li>
    <li><a href="Inventory_Summary.aspx" style="color:white; text-decoration:none;"><i class="fas fa-chart-pie"></i> Summary</a></li>
</ul>

        </nav>

        <!-- Main Form Container -->
        <div class="container">
            <h3><i class="fas fa-plus-circle"></i> Add Device to Inventory</h3>
            <div class="form-row">
                                <div class="form-group">
                    <label>Asset ID<span style="color:red">*</span></label>
                    <asp:TextBox ID="txtAssetID" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Serial Number<span style="color:red">*</span></label>
                    <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-control"  />
                </div>



                <div class="form-group">
                    <label>Asset Name</label>
                    <asp:TextBox ID="txtAssetName" runat="server" CssClass="form-control"  />
                </div>

                <div class="form-group">
                    <label>Device Type<span style="color:red">*</span></label>
                    <asp:DropDownList ID="ddlDeviceType" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Device" Value="" />
                        <asp:ListItem Text="CPU" />
                        <asp:ListItem Text="IGX" />
                        <asp:ListItem Text="Keyboard" />
                        <asp:ListItem Text="Laptop" />
                        <asp:ListItem Text="Monitor" />
                        <asp:ListItem Text="Mouse" />
                        <asp:ListItem Text="Other" />
                        <asp:ListItem Text="PBX	" />
                        <asp:ListItem Text="Printer" />
                        <asp:ListItem Text="Projector" />
                        <asp:ListItem Text="Router" />
                        <asp:ListItem Text="Scanner" />
                        <asp:ListItem Text="Switch" />
                        <asp:ListItem Text="Server" />
                        <asp:ListItem Text="Telephone" />
                        <asp:ListItem Text="WiFi" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Brand<span style="color:red">*</span></label>
                    <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label>Model Number<span style="color:red">*</span></label>
                    <asp:TextBox ID="txtModelNo" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label>Purchase Date</label>
                    <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>

                <div class="form-group">
                    <label>Status<span style="color:red">*</span></label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Status" Value="" />
                        <asp:ListItem Text="Working" />
                        <asp:ListItem Text="Not Working" />
                        <asp:ListItem Text="Ewaste" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label>Location<span style="color:red">*</span></label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label>Assigned To</label>
                    <asp:TextBox ID="txtAssignedTo" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group" style="flex-basis: 100%;">
                    <label>Asset Notes</label>
                    <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                </div>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" OnClick="btnSubmit_Click" />
            <br /><br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        </div>
    </form>
</body>
</html>
