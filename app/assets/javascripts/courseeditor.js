$( "#lessons" ).sortable({
  update: function(){
    update_lesson_position();
  }
});

$( "#lessons" ).disableSelection();

function update_lesson_position(){  
  list = $("#lessons");  
  neworder = new_positions(list);  
  
  course_id = $("#courseeditor div:first-child").attr("id");
  url = "/courses/"+course_id+"/lessons/";
  
  do_requests(url);  
}

function update_page_position(){
  list = $("#pages");
  neworder = new_positions(list); 
  
  course_id = $("#courseeditor div:first-child").attr("id");
  lesson_id = $("#pageeditor div:first-child").attr("id");
  url = "/courses/"+course_id+"/lessons/"+lesson_id+"/pages/";  
  
  do_requests(url);   
}

function new_positions(list){
  neworder = new Array();
  list.find("li").each(function(i){
    elem = $(this);
    elem.find(".position").html(i+1);
    id = elem.attr("id").split("_")[1];
    position = elem.find(".position").html();	
    neworder.push({
      'id': id,
      'position': position
    });
  });
  return neworder;
}

function do_requests(url){
  for(i=0;i<=neworder.length;i++){
    id = neworder[i].id;
	  position = neworder[i].position;
	  $.ajax({
	    type: "GET",
      url: url+id+"/updatePosition",
      data: {
        "position": position
      }
    });
	}
}
   

