// document.addEventListener('DOMContentLoaded', function(event) { $('.jquery-postback').on('click', function(element) {
//   element.preventDefault();
//
//       var $this = $(this);
//
//       $.post({
//           type: $this.data('method'),
//           url: $this.attr('href')
//       }).success(function (data) {
//           alert('success');
//       });
//    });
//  });

// $(function() {
//   $("a.jquery-postback").click(function(element) {
//     element.preventDefault();
//     // var $this = $(this);
//     // $this.addClass("disable-link")
//     // $.post({
//     //     type: $this.data('method'),
//     //     url: $this.attr('href')
//     // }).done(function (data) {
//     //   // debugger;
//     //   // success(function (data) {
//     //     alert('success');
//     // });
//   });
// });
// </script>
//
//
// <script type="text/javascript">
//
//   $(document).on("click", 'a.jquery-postback', function(event){
//     var goal = this
//     event.preventDefault();
//     // goal.parentElement.remove()
//     debugger;
//     deleteGoal(goal)
//   })
//
//   var deleteGoal = function(goal){
//   $.ajax({
//     url: goal.href,
//     type: 'DELETE',
//     success: function(result) {
//     },
//     error: function(result){
//       "something went wrong" + result
//     }
// });
// }
