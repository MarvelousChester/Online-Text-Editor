/*
    Project Name: Online Text Editor
    Purpose: Contains JavaScript and Jquery for the text edtior functionalities. It also contaisn the POST requsts to the web server and actively updates the website.
    Date: 12/2/2023
*/

var jQueryXMLHttpRequest;
var currentOpenedFile = "";
var textWritten = false;
var saveAsNameGiven = false;
var fileSaved = false;
//var textLoaded = false;
$(document).ready(function () {


   
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
        $("#status").html("*")

        textWritten = true;


    });

    /*
       Click trigger for textbox
    */
    $("#save_as_file_name").on("click", function () {

        
        $("#save_as_file_name").val("");
        $("#save_as_file_name").css("color", "black");
        
        saveAsNameGiven = true;
    });

    /*
        Load file button is clicked it will make a post request ot get the contents of a the file that is requsted
    */
    $("#load_file_bt").click(function () {

        $("#save_as_file_name").val("")
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
        $("#save_as_file_name").val("")
        
        // Check if current file Opened or not
        //  if (currentOpenedfile != "") {

        // Trigger Save As Option
        //}
        if (currentOpenedFile == "") {
            $("#save_as_file_name").val("No File Opened, Enter Name");
            $("#save_as_file_name").css("color", "red");
        }
        else {
            saveFile(currentOpenedFile);

            textWritten = false;
        }
        return false;

    });

    $("#saving_as_bt").click(function () {

        saveAs()
        textWritten = false;
        return false;
    });

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
            $("#file_drop_down_list").val(currentOpenedFile);
        },
        fail: function (data) {
            // Do Nothing
        }
    });


}

/*
  Name:  getFileContent
  Purpose: Makes a post to server to get the content of file using Jquery Ajax
  Param : None
  Return: None
*/
function getFileContent(name) {

    var jsonData = { fileToLoad: name };
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
                $("#status").html("File Loaded!");
            }
        },
        fail: function () {

            $("main_editor_text_editor").val("Error: Failed to load text file");
        }
    });
}

/*
  Name: saveFile
  Purpose: Makes a post to server with file name and content of file in json format and saves it to server. 
  Param : None
  Return: bool true if successful, false if not
*/
function saveFile(name) {

    // Stores Content and Name of File
    var textContent = $("#main_editor_text_editor").val();
    var jsonData = { fileToSave: name, content: textContent };
    var jsonString = JSON.stringify(jsonData);



    jQueryXMLHttpRequest = $.ajax({
        type: "POST",
        url: "startPage.aspx/SaveFile",
        data: jsonString,
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (status) {

            $("#status").html("File Saved!");
            fileSaved = true;
        },
        fail: function () {

            $alert("Saving Failed");
            fileSaved = false;
        }
    });

}

/*
    Name : saveAs()
    Purpose: Checks if user written any save as file name and if not will prompt message, else it will save the file call save function. It will then delay for 0.5 sec and then update list
    parameters: NONE
    Return: None
*/
function saveAs() {

   
    var fileName = $("#save_as_file_name").val();

    const invalidFileCharPtrn = new RegExp('[<>:"/\|?*]');
    var invalidCharFound = invalidFileCharPtrn.test(fileName); 
    // Add Getting Name
    
    if (saveAsNameGiven == false || fileName == "") {

        $("#save_as_file_name").val("Cannot Be Empty");
        $("#save_as_file_name").css("color", "red");
    }
    else if (invalidCharFound == true) {
        $("#save_as_file_name").val('Cannot contain:<>:"/\|?*');
        $("#save_as_file_name").css("color", "red");
    }
    else {
        saveFile(fileName);
        // Maybe move this new function
        currentOpenedFile = fileName;
        // Delays so time enough for file to be created
        setTimeout(function () {
            $("#file_drop_down_list").empty();
            fillListWithFileNames();

        }, 500);
       
    }
    saveAsNameGiven = false;

}