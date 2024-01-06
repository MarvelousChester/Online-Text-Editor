<!-- Project Name: Online Text Editor -->
<!-- Date: 12/2/2023 -->
<!-- Purpose: HTML page for text editor -->

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startPage.aspx.cs" Inherits="A06._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Online Text Editor</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <script src="Scripts/textEditorQuery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="StyleSheet.css"/> 
        
</head>
<body>
     <form class="entire_page" id="entire_page" runat="server">
             <div class="header">
         <h1 id="title">Text Editor</h1>
       </div>
        <div id="text_editor_box">
            <div id="text_editor_tool_bar">
                <button id="saving_bt"  disabled="true">Save</button> 
                <button id="saving_as_bt"  disabled="true">Save As</button>            
                <asp:Label runat="server" Text="Select File"></asp:Label>
                <select id="file_drop_down_list" class="file_drop_down">
                   <option value="" disabled selected> </option>
                </select> <!-- Have to Choose Data Source and make first, Select File -->
                <button id="load_file_bt" >Load File</button>
                <input type="text" id="save_as_file_name" value="Save As Name" style="color:darkgray"/>
                <label id="status"></label>
                <label id="error_status"></label>
            </div>

            <br />
            <div class="text_editor_box">
                <textarea id="main_editor_text_editor" style="resize: none;" ></textarea>
                <div id="character_count_box">
                    <a class="non_editor_text">characters:</a>
                    <span id="character_count"></span>
                </div>
            </div>
        </div>
        <div class="bottom_footer"">&nbsp</div>
    </form>
</body>
</html>
