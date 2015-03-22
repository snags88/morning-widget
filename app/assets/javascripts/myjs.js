$(function(){
  submitTask();
  deleteTask();
  fadeNotices();
});

function deleteTask(){
  $(".task_delete").on('click', deleteExistingTask);
}

function deleteExistingTask(e){
  var link = $(this);
  stopAction(e);
  $.ajax({
      url: link.attr("href"),
      method: 'DELETE',
      context: this,
      success: function(result) {
        link.parent().remove();
      }
  });
}


function submitTask(){
  $("#new_task").on('submit', createNewTask);
}

function createNewTask(e){
  stopAction(e);
  submitForm($(this), function(savedTask){
    $("#task_name").val("");
    $("#tasks").prepend($(savedTask));
    deleteTask();
  });
}

function stopAction(e){
  e.preventDefault();
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