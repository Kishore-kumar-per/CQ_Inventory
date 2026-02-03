<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Inventory.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Inventory System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            margin: 0;
            padding: 0;
        }

        .login-container {
            max-width: 420px;
            margin: 80px auto;
            background-color: white;
            padding: 2.5rem 2rem;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        h2 {
            text-align: center;
            color: #4A3C8C;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            font-weight: bold;
            margin-bottom: 0.5rem;
            display: block;
            color: #333;
        }

        .form-control {
            width: 80%;
            padding: 10px 12px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #4A3C8C;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #6A5ACD;
        }

        .icon-input {
            position: relative;
        }

        .icon-input i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: #888;
        }

        .icon-input input {
            padding-left: 35px !important;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 1rem;
            font-weight:500;
        }

        .link-btn {
            background: none;
            border: none;
            color: #4A3C8C;
            font-size: 14px;
            text-align: right;
            cursor: pointer;
            margin-top: 10px;
        }

        .link-btn:hover {
            text-decoration: underline;
        }

        .hidden {
            display: none;
        }

        @media screen and (max-width: 480px) {
            .login-container {
                margin: 30px 15px;
                padding: 2rem 1.5rem;
            }
        }
</style>

<script type="text/javascript">

    // Show/Hide Forgot Password Panel
    function toggleForgot(showForgot) {
        document.getElementById('loginPanel').style.display = showForgot ? 'none' : 'block';
        document.getElementById('forgotPanel').style.display = showForgot ? 'block' : 'none';
    }

    // Show Loader on Login Click
    function showLoader() {
        document.getElementById('loadingOverlay').style.display = 'flex';
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2><i class="fas fa-sign-in-alt"></i> Inventory Login</h2>

            <!-- Login Form -->
            <div id="loginPanel">
                <div class="form-group icon-input">
                    <label for="txtUsername"> Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group icon-input">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>

<asp:Button 
    ID="btnLogin" 
    runat="server" 
    Text="Login" 
    CssClass="btn" 
    OnClientClick="showLoader();" 
    OnClick="btnLogin_Click" />

                <button type="button" class="link-btn" onclick="toggleForgot(true)">
                    <i class="fas fa-key"></i> Forgot Password?
                </button>
                <asp:Label ID="lblError" runat="server" CssClass="error-message" />
            </div>

            <!-- Forgot Password Form -->
            <div id="forgotPanel" class="hidden">
                <div class="form-group icon-input">
                    <label for="txtForgotEmail"> Registered Email</label>
                    <asp:TextBox ID="txtForgotEmail" runat="server" CssClass="form-control" />
                </div>

<asp:Button 
    ID="btnForgotPassword" 
    runat="server" 
    Text="Reset Password" 
    CssClass="btn"
    OnClientClick="showLoader();" 
    OnClick="btnForgotPassword_Click" />

                <button type="button" class="link-btn" onclick="toggleForgot(false)">
                    <i class="fas fa-arrow-left"></i> Back to Login
                </button>
                <asp:Label ID="lblForgotMessage" runat="server" CssClass="error-message" />
            </div>
        </div>
<style>
    /* Fade-in animation */
    @keyframes fadeInLoader {
        0% { opacity: 0; }
        100% { opacity: 1; }
    }

    /* Loader spin animation */
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    /* Attractive Overlay */
    #loadingOverlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(4px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        animation: fadeInLoader 0.3s ease-in-out;
    }

    /* Stylish circular loader */
    .loader-ring {
        width: 70px;
        height: 70px;
        border: 6px solid transparent;
        border-top: 6px solid #7b5df5;
        border-right: 6px solid #b398ff;
        border-radius: 50%;
        animation: spin 1s linear infinite;
        box-shadow: 0 0 18px rgba(123, 93, 245, 0.6);
    }
</style>

<div id="loadingOverlay">
    <div class="loader-ring"></div>
</div>

    </form>
</body>
</html>
