$(function(){
  submitTask();
  deleteTask();
  fadeNotices();
  failedLogin();
});

function deleteTask(){
  $(".task_delete").on('click', deleteExistingTask);
}

function deleteExistingTask(e){
  e.preventDefault();
  $.ajax({
      url: $(this).attr("href"),
      method: 'DELETE',
      context: this,
      success: function(result) {
        $(this).parent().remove();
      }
  });
}

function submitTask(){
  $("#new_task").on('submit', createNewTask);
}

function createNewTask(e){
  e.preventDefault();
  submitForm($(this), function(savedTask){
    $("#task_name").val("");
    $("#tasks").prepend($(savedTask));
    deleteTask();
  });
}

function submitForm(form, callbackAction){
  var action = form.attr("action");
  var params = form.serialize();
  $.post(action, params, callbackAction);
}

function fadeNotices(){
   setTimeout(function() {
   $('#alert_close').trigger("click");
    },3000);
}

function failedLogin(){
  if (document.getElementById("error_explanation")){
    $(".jumbotron button:first").trigger("click")
  }
}