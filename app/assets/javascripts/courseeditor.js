$("#courseeditor #lessons").sortable({
    update:function (event, ui) {
        update_lesson_position(ui.item);
    }
});

$("#courseeditor #lessons").disableSelection();

function update_lesson_position(item) {
    var list = $("#lessons");
    var neworder = new_positions(list);

    var course_slug = $("#courseeditor div:first-child").data("slug");
    var url = "/courses/" + course_slug + "/lessons/";

    do_requests(url, neworder);
}

function update_page_position() {
    var list = $("#pages");
    var neworder = new_positions(list);
    var course_slug = $("#courseeditor div:first-child").data("slug");
    var lesson_id = $("#pageeditor div:first-child").attr("id");
    var url = "/courses/" + course_slug + "/lessons/" + lesson_id + "/pages/";
    do_requests(url, neworder);
}

function update_resource_position(id) {
    var list = $("#page_" + id + " .resources");
    var neworder = new_positions(list);
    var course_slug = $("#courseeditor div:first-child").data("slug");
    var lesson_id = $("#pageeditor div:first-child").attr("id");
    var url = "/courses/" + course_slug + "/lessons/" + lesson_id + "/pages/" + id + "/resources/";
    do_requests(url, neworder);
}

function new_positions(list) {
    var neworder = new Array();
    list.find("> li").each(function (i) {

        var e = $(this);

        var id = e.attr("id").split("_")[1];
        e.find(".position").html(i + 1);
        var position = e.find(".position").html();

        neworder.push({
            'id':id,
            'position':position
        });
    });

    return neworder;
}

function do_requests(url, neworder) {

    for (i = 0; i <= neworder.length; i++) {

        var id = neworder[i].id;
        var position = neworder[i].position;

        $.ajax({
            type:"GET",
            url:url + id + "/updatePosition",
            data:{
                "position":position
            }
        });
    }
    alert("end of requests");
}

$(".tooltips a").tooltip();
   
