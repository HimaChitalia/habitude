$(document).on("click", 'a.js-delete-goal', function(event){
  event.preventDefault();
  var goal = this
  goal.parentElement.remove()
  $.ajax({
        type: 'DELETE',
        url: goal.href,
        dataType: "json",
        data: {"_method":"delete"},
        complete: function(){
            alert("Deleted Successfully");
        },
        error: function(result){
          "something went wrong" + result
        }
    });
})
