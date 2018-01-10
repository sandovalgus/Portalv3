

$(document).ready(function(){

  $("#search").keyup(function() {

  		console.log("presiono tecla");
  		var search = document.getElementById('search').value;
  		$.ajax({
           url: "/home/search",
           type: "GET",
           data: {  
           "search": search
           },
           dataType: "json",
           success: function(data) {
           		       		
           		console.log(data);

             }
         });
  });

});