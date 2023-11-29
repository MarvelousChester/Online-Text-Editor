<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="A06._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Online Text Editor</title>
    <link rel="stylesheet" href="stylesheet.css"/> 
</head>
<body>
     <form class="entire_page" id="entire_page" runat="server">
             <div class="header">
         <h1 id="title">Text Editor</h1>
       </div>
        <div id="text_editor_box">
            <div id="text_editor_tool_bar">
                <asp:Button runat="server" ID="saving" Text="Save"/>
                <asp:Button runat="server" ID="saving_as" Text="Save As"/> 
            
                <asp:Label runat="server" Text="Select File"></asp:Label>
                <asp:DropDownList runat="server" ID="file_drop_down_list" DataTextField="Select File"></asp:DropDownList> <!-- Have to Choose Data Source and make first, Select File -->
            </div>
            
            <br />
            <div class="text_editor_box">
                <asp:TextBox runat="server" ID="main_editor_text_editor" TextMode="MultiLine"></asp:TextBox>
                <div id="character_count_box">
                    <a class="non_editor_text">characters:</a>
                    <asp:TextBox runat="server" ID="character_count"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="bottom_footer"">&nbsp</div>
    </form>
</body>
</html>
