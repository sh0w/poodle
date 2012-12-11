

   $( "#lessons" ).sortable({
     update: function(event, ui) {
	list = $(this);

        neworder = new Array();

        list.find("li").each(function(i){
	  elem = $(this);
          elem.find(".position").html(i+1);

	  id = elem.attr("id").replace('lesson_','');
	  position = elem.find(".position").html();	

	  neworder.push({
	    'id': id,
	    'position': position
	  });

	});

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
   });
   $( "#lessons" ).disableSelection();



