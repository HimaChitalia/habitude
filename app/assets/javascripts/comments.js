var buildComment = function (object){
 var form = $(object)
 var values = form.serialize();
 var myString = form.attr("action")
 var path = myString.replace('http://localhost:3000/habits/','');
 var textEmpty =  $("textarea[id=comment_description]")
 var userName = $("input[id=comment_user_name]").val()
 $.post(path, values)
     .done(function(data) {
       textEmpty.val('');
       var children = $("div.onlyComments > div").length
       var title = ""
       if (children >= 1){
         $("div.commentHeader").text('')
         title = "<h5 class='commentTitle'> Comments: </h5><br/>"
         $("div.commentHeader").html(title)
       } else if (children === 0) {
         title = "<h5 class='commentTitle'> Comment: </h5><br/>"
         $("div.commentHeader").html(title)
       }

         data.user_name = userName
         var comment = new Comment(data)
         $('div.allComments').append(comment.showComment())
      })
      .error(function(error) {
        $('div.allComments').before("there has been an error, try again")
      })
}

$(function() {
   $("body").on('submit', '#new_comment', function(e){
     e.preventDefault();
     buildComment(this)
   });
})


function Comment(comment){
  this.id = comment.id
  this.description = comment.description
  this.user_id = comment.user_id
  this.user_name = comment.user_name
  this.habit_id = comment.habit_id
}

Comment.prototype.showComment = function(){
  let commentHtml = `
  <div class="commentDiv-${this.id}">
    <h5> » ${this.description}</h5>
    <h5> User: ${this.user_name}</h5>
    <a href="/habits/${this.habit_id}/comments/${this.id}/edit"  data-method="get">Edit</a>
    <a href="/habits/${this.habit_id}/comments/${this.id}" class="js-delete-comment" data-confirm="Destroy Comment: '${this.description}'?" >Delete</a>
  </div>
  `
  return commentHtml
}


$(document).on("click", 'a.js-delete-comment', function(event){
  event.preventDefault();
  var comment = this
  var children = $("div.allComments > div").length
  var title = ""
  if (children > 3){
    title = "<h5 class='commentTitle'> Comments: </h5> <br/>"
    $("div.commentHeader").html(title)
  } else if (children === 3) {
    title = "<h5 class='commentTitle'> Comment: </h5> <br/>"
    $("div.commentHeader").html(title)
  }else if (children === 2) {
    title = "<h5 class='commentTitle'>There are no comments for this Habit yet! </h5>"
    $("div.commentHeader").html(title)
  }
  comment.parentElement.remove()
  $.ajax({
        type: 'DELETE',
        url: comment.href,
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
