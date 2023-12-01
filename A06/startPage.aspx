<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startPage.aspx.cs" Inherits="A06._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Online Text Editor</title>
    <link rel="stylesheet" href="stylesheet.css"/> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" type="text/javascript"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <script type="text/javascript">
        var jQueryXMLHttpRequest;
        var currentOpenedFile = "";
        var textWritten = false;
        //var textLoaded = false;
        $(document).ready(function () {


            
            // Add Conditional here, if first time, MaYBE
            fillListWithFileNames();
            /*
                Purpose: User Types, it will update character and unhide the button
            */
            $("#main_editor_text_editor").on("input", function () {
                var len = $("#main_editor_text_editor").val().length;

                $("#character_count").text(len);

                // Unhide the Button/ Ungray it here
                $("#saving_bt").prop("disabled", false);
                $("#saving_as_bt").prop("disabled", false);

                
                 textWritten = true;
                


            });

            /*
                Load file button is clicked it will make a post request ot get the contents of a the file that is requsted
            */
            $("#load_file_bt").click(function () {


                if (textWritten == true) {

                    // ASK ARE THEY SURE
                    $.confirm({
                        title: "Are you sure?",
                        content: "You have unsaved changes, are you sure you want to overrwrite?",
                        buttons: {
                            confirm: function () {
                                var fileName = $("#file_drop_down_list option:selected").text();
                                getFileContent(fileName);
                                textWritten = false;
                               

                            },
                            cancel: function () {

                            }
                        }
                    });

                }
                else {
                    var fileName = $("#file_drop_down_list option:selected").text();
                    getFileContent(fileName);
                    textWritten = false;
                   
                }
            

                // Prevent Form Submission
                return false;
            });


            $("#saving_bt").click(function () {

                // Check if current file Opened or not
                if (currentOpenedfile != "") {

                    // Trigger Save As Option
                }
                saveFile(currentOpenedFile);
                return false;


            })
        });

        /*
            Name: fillListWithFileNames
            Purpose: Makes a post with JQuery AJAX to get the text files in the directory from server and then will put into a list for user to select from
            Param : None
            Return: None
        */
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

        /*
          Name: fillListWithFileNames
          Purpose: Makes a post to server to get the content of file using Jquery Ajax
          Param : None
          Return: None
        */
        function getFileContent(name) {

            var jsonData = { fileToLoad: name};
            var jsonString = JSON.stringify(jsonData);

            jQueryXMLHttpRequest = $.ajax({
                type: "POST",
                url: "startPage.aspx/GetFileContent",
                data: jsonString,
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (content, status) {
                    
                    // Check if null was not given else fill list with samples files
                    if (content != null & content.d != null) {

                        response = $.parseJSON(content.d);
                       
                        $("#main_editor_text_editor").val(response.content);
                        
                        currentOpenedFile = name;
                    }
                },
                fail: function () {

                    $("main_editor_text_editor").val("Error: Failed to load text file");
                }
            });
        }


        function saveFile(name) {

            // Stores Content and Name of File
            var jsonData = { fileToSave: name, content: $("main_editor_text_editor").val() };
            var jsonString = JSON.stringify(jsonData);



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
                <button id="saving_bt"  disabled="true">Save</button> 
                <button id="saving_as_bt"  disabled="true">Save As</button>            
                <asp:Label runat="server" Text="Select File"></asp:Label>
                <select id="file_drop_down_list">
                    <option value=""> </option>
                </select> <!-- Have to Choose Data Source and make first, Select File -->
                <button id="load_file_bt" >Load File</button>

            </div>
            
            <br />
            <div class="text_editor_box">
                
                <textarea id="main_editor_text_editor"></textarea>
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
