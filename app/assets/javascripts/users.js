$(function () {
  $(".js-habit-index").on("click", function(element) {
    element.preventDefault();
    var userId = parseInt($(".js-habit-index").attr("data-id"));
    $.get("/users/" + userId + "/habits" + ".json", function(data) {
    var habits = $(data)
      habits.each(function( index ) {
        var id = this.id;
        var path = Routes.habit_path(id)
        var hName = "<a href='"+ path + "'>" + "‣ " + "Name: " + this.name + "</a>";
        console.log(hName)
        $(".habitName-" + id).html(hName);
        var des = "Description: " + this.description;
        $(".habitDes-" + id).text(des);
        var c = this.categories;
        var categories = $(c)
        $(".habitCategories").text("Categories: ")
        $(".habitCategory").text("Category: ")
        categories.each(function( index ) {
          var categoryId = this.id;
          var cName = "» " + this.name;
          $(".categoryName-" + categoryId).text(cName);
        });

        var g = this.goals;
        var goals = $(g)
        $(".habitGoals").text("Goals: ")
        $(".habitGoal").text("Goal: ")
        goals.each(function( index ) {
          var goalId = this.id;
          var gName = "» " + this.name;
          $(".goalName-" + goalId).text(gName);

          var header = "<h3> Habits: </h3>";
          $('.js-habit-index').html(header);
        });
      });
    });
  });
});
