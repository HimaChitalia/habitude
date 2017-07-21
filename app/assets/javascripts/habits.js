
<script type="text/javascript" charset="utf-8">
$(function () {
  $(".js-next").on("click", function(element) {
    element.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;
    path = Routes.habit_path(nextId);
    $.get(path + ".json", function(data) {
      console.log(data);
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
        var cName = "<a href='"+ path + "'> » " + this.name + "</a>";
        catNames.push(cName);
        var b = "<br/>"
        catNames.push(b)
      });
      $(".categoryName").html(catNames);


      var g = data.goals;
      var goals = $(g)
      var habitGoalsNames = [];
      $(".goalTitle").text("")
      if (goals.length >= 1) {
        if (goals.length === 1) {
        $(".goalTitle").append("Goal: ")
      } else {
        $(".goalTitle").append("Goals: ")
      }
        goals.each(function(index ) {
          var goalId = this.id;
          var goalPath = Routes.habit_goal_path(hId, goalId)
          var gName = "<a href='"+ goalPath + "'> » " + this.name + "</a>";
          habitGoalsNames.push(gName)
          var b = "<br/>"
          habitGoalsNames.push(b)
        });
        $(".buildGoal").text("")
        $(".noGoal").text("")
        $(".viewGoals").append(habitGoalsNames);
      } else {
        $(".buildGoal").html("<h5 class='buildGoal'>There are no goals for this habit yet! Create one.</h5>")
        $(".noGoal").html("<h5 class='noGoal'>There are no goals for this habit yet!</h5>")
      };

      $(".js-next").attr("data-id", data["id"]);
    });
  });
});
</script>
