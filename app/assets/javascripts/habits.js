$(function () {
  $(".js-next").on("click", function(element) {
    element.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    path = Routes.habit_path(nextId);
    $.get(path + ".json", function(data) {
      var hName = "<h2 class='habitName'>Habit name: " + data.name + "</h2>"
      var hId = data.id
      var uPath = Routes.user_path(data.user.id)
      var uName = "<h5 class='habitUser'>User: <a href='"+ uPath + "'>" + data.user.name + "</a></h5>"
      var hDes = "<h5 class='habitDes'>Description: " + data.description + "</h5>"
      $(".habitUser").html(uName);
      $(".habitName").html(hName);
      $(".habitDes").html(hDes);

      var c = data.categories;
      var categories = $(c)
      $(".habitCategories").text("Categories: ")
      $(".habitCategory").text("Category: ")
      var catNames = []
      categories.each(function( index ) {
        var categoryId = this.id;
        var path = Routes.category_path(categoryId)
        var cName = "<h5 class='categoryName'><a href='"+ path + "'> » " + this.name + "</a></h5>";
        catNames.push(cName);
      });
      $(".categories-list").text("")
      $(".categories-list").append(catNames);

      var g = data.goals;
      var goals = $(g)
      var habitGoalsNames = [];
      $(".goalTitle").text("")
      if (goals.length >= 1) {
        if (goals.length === 1) {
        $(".goalTitle").append("<h5 class='habitGoals'>Goal: </h5>")
      } else {
        $(".goalTitle").append("<h5 class='habitGoals'>Goals: </h5>")
      }
        goals.each(function(index ) {
          var goalId = this.id;
          var goalPath = Routes.habit_goal_path(hId, goalId)
          var gInfo = `<h5 class='goalName'><a href="${goalPath}"> » ${this.name}</a></h5>
          <a href="/habits/${hId}/goals/${goalId}" data-confirm="Destroy gaol: '${this.name}'?" class="js-delete-goal" >Delete Goal</a>
          `
          habitGoalsNames.push(gInfo)
        });
        $(".buildGoal").text("")
        $(".noGoal").text("")
        $(".goals-list").text("")
        $(".goals-list").append(habitGoalsNames);
      } else {
        $(".goals-list").text("")
        $(".goalTitle").html("<h5 class='noGoal'>There are no goals for this habit yet!</h5>")
      };

      $(".js-next").attr("data-id", data["id"]);
    });
  });
});

path = "/habits/2/addgoals"



var buildGoal = function (form){
  var values = form.serialize();
  var habitIdforGoal = $(".js-next").attr("data-id")
  var path = "/habits/" + habitIdforGoal + "/addgoals"
  var goalValue = $("input[id=habit_goals_attributes_0_name]").val();
  var textEmpty = $("input[id=habit_goals_attributes_0_name]")
  $.post(path, values)
      .done(function(data) {
          textEmpty.val('');
          var hId = data.id
          var goalArray = data.goals
          var newGoal = goalArray.pop()
          var goalId = newGoal.id;
          var goalPath = Routes.habit_goal_path(hId, goalId)
          var children = $("div.goals-list > div").length
          var title = ""
          var goalDiv =  `
                          <div class="goalDiv-${newGoal.id}">
                          <h5 class="goalName"><a href='${goalPath}'> » ${newGoal.name}</a></h5>
                          <a href="${goalPath}" data-confirm="Destroy Goal: '${newGoal.name}'?" class="js-delete-goal">Delete Goal</a></div>`
          $('div.goals-list').append(goalDiv);

          if (children >= 1){
            title = "<h5 class='habitGoals'>Goals: </h5>"
            $("div.goalTitle").html(title)
          } else if (children === 0) {
            title = "<h5 class='habitGoal'>Goal: </h5>"
            $("div.goalTitle").html(title)
          }
       })
       .error(function(error) {
        $('div.goals-list').before("there has been an error, try again")
       });
}

$(function() {
  $('form#add_goal').on("submit", function(e){
    e.preventDefault();
    var form = $(this)
    buildGoal(form)
  });
})
