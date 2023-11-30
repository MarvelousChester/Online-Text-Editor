<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startPage.aspx.cs" Inherits="A06._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Online Text Editor</title>
    <link rel="stylesheet" href="stylesheet.css"/> 
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" type="text/javascript"></script>
 
    <script type="text/javascript">
        var jQueryXMLHttpRequest; 
        $(document).ready(function () {
            // GEt List 
            fillListWithFileNames();

            /*
                Purpose: User Types, it will update character and unhide the button
            */
            $("#main_editor_text_editor").on("input", function () {
                var len = $("#main_editor_text_editor").val().length;

                $("#character_count").text(len);

                // Unhide the Button/ Ungray it here
                $("#saving").prop("disabled", false);
                $("#saving_as").prop("disabled", false);

            });
        });
        function fillListWithFileNames() {
            // Jquery to get file list in json format
            // Builds JSON string with list of files in directory
            jQueryXMLHttpRequest = $.ajax({
                type: "POST",
                url: "startPage.aspx/GetFileList",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                // Parse Data
                success: function (fileNames, status) {

                    // Check if null was not given else fill list with samples files
                    if (fileNames != null & fileNames.d != null) {

                        var response;
                        response = $.parseJSON(fileNames.d);
                        alert(response.fileNames);
                        var optionStringHtml = "<option value=" + response.fileNames + ">" + response.fileNames + "</option>";
                        $
                        // Append to List
                        $.each(response.fileNames, function (index, name) {

                            var optionStringHtml = "<option value='" + name + "'>" + name + "</option>";
                             $("#file_drop_down_list").append(optionStringHtml);
                        });

                    }
                },
                fail: function (data) {
                    // Do Nothing
                }
            });
        }
        // Drop Down List Select, IF select grab thee text and display it -> Indicate a mess as well that it has been selected

        // BUtton Press Function Jquery Save

        // Button Press Function Jquery Save As
      
   
    </script>

</head>
<body>
     <form class="entire_page" id="entire_page" runat="server">
             <div class="header">
         <h1 id="title">Text Editor</h1>
       </div>
        <div id="text_editor_box">
            <div id="text_editor_tool_bar">
                <asp:Button runat="server" ID="saving" Text="Save" ClientIDMode="Static" disabled="true" />
                <asp:Button runat="server" ID="saving_as" Text="Save As" disabled="true"/> 
            
                <asp:Label runat="server" Text="Select File"></asp:Label>
                <select id="file_drop_down_list">
                    <option value=""> </option>
                </select> <!-- Have to Choose Data Source and make first, Select File -->
                <asp:Button runat="server" ID="load" Text="Load File"/> 

            </div>
            
            <br />
            <div class="text_editor_box">
                <asp:TextBox runat="server" ID="main_editor_text_editor" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
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
