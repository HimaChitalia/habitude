$(function () {
  $(".js-next").on("click", function(element) {
    element.preventDefault();

    var totalHabits = $('div.habitsCount').attr('data-info');
    var firstHabitId = $('div.firstHabit').attr('data-info');
    var jsNextID = $(".js-next").attr("data-id");
    var allHabits = $(".habits").attr("data-info");
    var lastHabitId = $('div.lastHabit').attr('data-info')
    
    if (jsNextID === lastHabitId ){
      jsNextID = parseInt(firstHabitId);
    } else {
      for(let i = parseInt(jsNextID) + 1; i <= lastHabitId; i++ ){
        if(allHabits.includes(i)){
          jsNextID = i;
          break;
        }
      }
    }
    
    var currentUser = ($(".js-next").attr("data-current-user"))
    var currentUserId = ($(".js-next").attr("data-current-user-id"))
    var csrfValue = $("meta[name='csrf-token']").attr('content');

    path = Routes.habit_path(jsNextID);
    $.get(path + ".json", function(data) {
      var hName = "<h2 class='habitName'>Habit name: " + data.name + "</h2>"
      var hId = data.id
      var uPath = Routes.user_path(data.user.id)
      userName = data.user.name
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
          var gInfo = ""

          if (currentUser === userName){
            gInfo = `
            <div class="goalDiv-${goalId}">
            <h5 class='goalName'><a href="${goalPath}"> » ${this.name}</a></h5>
            <a href="/habits/${hId}/goals/${goalId}" data-confirm="Destroy gaol: '${this.name}'?" class="js-delete-goal" >Delete Goal</a>
            </div>
            `
          } else {
            gInfo = `
            <div class="goalDiv-${goalId}">
            <h5 class='goalName'><a href="${goalPath}"> » ${this.name}</a></h5>
            </div>
            `
          }

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

      if (currentUser === userName){
        var formHTML = `
            <h5 class="createGoals">Create a new Goal for your habit ${data.name}</h5>
            <form id="add_goal" class="edit_habit" action="/habits/${hId}/addgoals" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input type="hidden" name="_method" value="patch">
            		<input type="hidden" name="authenticity_token" value="${csrfValue}">
            <label for="habit_goals_attributes_0_name">Name</label>
            <input type="text" name="habit[goals_attributes][0][name]" id="habit_goals_attributes_0_name">
            <br>
            <input type="submit" name="commit" value="Add a goal">
          </form>
        `
        $('.renderForm').html(formHTML);
      } else {
        $('.renderForm').html("");
      }

      if (currentUser !== userName){
        var commentFormHTML = `
            <h5>Add your comment below! </h5>

            <form class="new_comment" id="new_comment" action="/habits/${hId}/comments" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <input type="hidden" name="authenticity_token" value="${csrfValue}">

              Description: <textarea name="comment[description]" id="comment_description" cols="10" rows="5"></textarea> <br>
              <input value="Hima" type="hidden" name="comment[user_name]" id="comment_user_name">
              <input type="submit" name="commit" value="Create Comment">
            </form>
        `
        $('.renderCommentForm').html(commentFormHTML);
      } else {
        $('.renderCommentForm').html("");
      }

      var c = data.comments;
      var comments = $(c)
      var habitCommentsNames = [];
      $(".commentHeader").text("")
      if (comments.length >= 1) {
        if (comments.length === 1) {
        $(".commentHeader").append("<h5 class='commentTitle'> Comment: </h5><br />")
      } else {
        $(".commentHeader").append("<h5 class='commentTitle'> Comments: </h5><br />")
      }
        comments.each(function(index ) {
          var commentId = this.id;
          var commentlPath = Routes.habit_comment_path(hId, commentId)
          var cInfo = ""
          var commentUserId = this.user_id
          if (Number(currentUserId) === commentUserId){
            cInfo = `
            <div class="commentDiv-${commentId}">
<<<<<<< HEAD
              <h5> » ${this.description}</h5>
              <h5>User: <a href="/users/${commentUserId}">${currentUser}</a></h5>
              <a href="/habits/${hId}/comments/${commentId}/edit" data-method="get">Edit</a>
              <a href="/habits/${hId}/comments/${commentId}" class="js-delete-comment" data-confirm="Destroy Comment: '${this.description}'?">Delete</a>
=======
            <h5> » ${this.description}</h5>
            <h5>User: <a href="/users/${this.user_id}">${this.user_name}</a></h5>
            <a href="/habits/${hId}/comments/${commentId}/edit" data-method="get">Edit</a>
            <a href="/habits/${hId}/comments/${commentId}" class="js-delete-comment" data-confirm="Destroy Comment: '${this.description}'?">Delete</a>
>>>>>>> 22160926f3974fe4a77f326fbb612352abde65c6
            </div>
            `
          } else {
            cInfo = `
            <div class="commentDiv-${commentId}">
            <h5> » ${this.description}</h5>
            <h5>User: <a href="/users/${this.user_id}">${this.user_name}</a></h5>
            </div>
            `
          }

          habitCommentsNames.push(cInfo)
        });
        $(".onlyComments").text("")
        $(".onlyComments").append(habitCommentsNames);
        $(".onlyComments").append("<br />");
      } else {
        $(".onlyComments").text("")
        $(".commentHeader").html("<h5 class='commentTitle'>There are no comments for this Habit yet! </h5>")
      };


      $(".js-next").attr("data-id", data["id"]);
    });
  });
});

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
  $("body").on('submit', '#add_goal', function(e){
    e.preventDefault();
    var form = $(this)
    buildGoal(form)
  });
})
