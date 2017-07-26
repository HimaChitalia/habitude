$(document).on("click", 'a.js-delete-goal', function(event){
  event.preventDefault();
  var goal = this
  var children = $("div.goals-list > div").length
  var title = ""
  console.log(children)
  if (children > 2){
    title = "<h5 class='habitGoals'>Goals: </h5>"
    $("div.goalTitle").html(title)
  } else if (children === 2) {
    title = "<h5 class='habitGoal'>Goal: </h5>"
    $("div.goalTitle").html(title)
  }else if (children === 1) {
    title = "<h5 class='buildGoal'>There are no goals for this habit yet! Create one.</h5>"
    $("div.goalTitle").html(title)
  }
  debugger;
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
