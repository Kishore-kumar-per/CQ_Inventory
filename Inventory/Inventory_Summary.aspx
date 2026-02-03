<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory_Summary.aspx.cs" Inherits="Inventory.Inventory_Summary" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Summary</title>
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

    /* MAIN CONTAINER */
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

    .summary-header {
        font-size: 24px;
        margin-bottom: 25px;
        font-weight: 700;
        color: #4A3C8C;
        text-align: left;
        border-left: 6px solid #4A3C8C;
        padding-left: 12px;
    }

    /* DASHBOARD CARDS */
    .summary-cards {
        display: flex;
        gap: 25px;
        margin-bottom: 25px;
        flex-wrap: wrap;
    }

    .card {
        flex: 1;
        min-width: 220px;
        padding: 22px;
        background: #f4f4ff;
        border-radius: 15px;
        font-size: 20px;
        font-weight: bold;
        color: #4A3C8C;
        box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        transition: 0.3s ease;
        text-align: center;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    /* TABLE / GRIDVIEW */
    .gridview-style {
        width: 100%;
        border-collapse: collapse;
        margin-top: 30px;
        border-radius: 10px;
        overflow: hidden;
    }

    .gridview-style th {
        background: #4A3C8C;
        color: white;
        font-size: 15px;
        padding: 12px;
        text-align: left;
    }

    .gridview-style td {
        padding: 12px;
        border: 1px solid #dcdcdc;
        font-size: 14px;
        background: #fff;
    }

    .gridview-style tr:nth-child(even) {
        background: #f3f3ff;
    }

    .gridview-style tr:hover {
        background: #ebe6ff;
        transition: 0.2s;
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

            <div class="summary-header">Inventory Summary Report</div>

            <div class="summary-cards">
                <div class="card">Total: <asp:Label ID="lblTotal" runat="server" Text="0" /></div>
                <div class="card">Working: <asp:Label ID="lblWorking" runat="server" Text="0" /></div>
                <div class="card">Not Working: <asp:Label ID="lblNotWorking" runat="server" Text="0" /></div>
                <div class="card">Ewaste: <asp:Label ID="lblEwaste" runat="server" Text="0" /></div>
            </div>

            <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="false" CssClass="gridview-style" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="Asset_Type" HeaderText="Device Type" />
                    <asp:BoundField DataField="TotalCount" HeaderText="Total" />
                    <asp:BoundField DataField="Working" HeaderText="Working" />
                    <asp:BoundField DataField="NotWorking" HeaderText="Not Working" />
                    <asp:BoundField DataField="Ewaste" HeaderText="Ewaste" />
                </Columns>
            </asp:GridView>

        </div>

    </form>
</body>
</html>
