var buildComment = function (object){
 var form = $(object)
 var values = form.serialize();
 var myString = form.attr("action")
 var path = myString.replace('http://localhost:3000/habits/','');
 var userName = $("input[id=comment_user_name]").val()
 $.post(path, values)
     .done(function(data) {
         data.user_name = userName
         var comment = new Comment(data)
         $('div.allComments').append(comment.showComment())
      })
      .error(function(error) {
        $('div.allComments').before("there has been an error, try again")
      })
}

$(function() {
   $('form#new_comment').on("submit", function(e){
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
  <h5> » ${this.description}</h5>
  <h5> User: ${this.user_name}</h5>
  <a href="/habits/${this.habit_id}/comments/${this.id}/edit"  data-method="get">Edit</a>
  <a href="/habits/${this.habit_id}/comments/${this.id}" data-confirm="Destroy Comment: '${this.description}'?" data-method="delete" rel="nofollow">Delete</a>
  `
  return commentHtml
}
