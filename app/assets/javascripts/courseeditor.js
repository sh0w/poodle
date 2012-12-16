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
           
  for(i=0;i<=neworder.length;i++){
    lesson_id = neworder[i].id;
	  position = neworder[i].position;
	  $.ajax({
	    type: "GET",
      url: "/courses/"+course_id+"/lessons/"+lesson_id+"/updatePosition",
      data: {
        "lesson_id": lesson_id,
        "course_id": course_id,
        "position": position
      }
    });
	}
}

function update_page_position(){
  list = $("#pages");
  neworder = new_positions(list); 
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

   

