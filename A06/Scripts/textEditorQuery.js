
$(document).ready(function () {
   


    
    $("input[id$='saving']").click(function () {

        alert("Button Pressed")

    });

    $("input[id$='main_editor_text_editor'").on("input", function () {

        var len = $(this).val().length;

        $("input[id$='character_count'").text(len);
    });
});