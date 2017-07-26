$(document).on("click", 'a.js-delete-goal', function(event){
  event.preventDefault();
  // deleteGoal(this)
  // console.log(this)
  var goal = this
  $.ajax({
        type: 'DELETE',
        url: goal.href,
        dataType: "json",
        data: {"_method":"delete"},
        complete: function(){
            alert("Deleted successfully");
        },
        error: function(result){
          "something went wrong" + result
        }
    });
})
