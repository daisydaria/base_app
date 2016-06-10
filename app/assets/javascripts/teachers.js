function deleteTeacherLinkHandler(object){
	$.ajax({
		url: $(object).attr("data-link"),
		type: 'DELETE',
		success: function(){
			$(object.parentElement).remove();	
			if ($('.hour').length == 0)
				$('.hours').html("Список пуст")
		}
	});
	return false;
}

function addHour(hourID){
	var deleteLink = '<a title="Удалить" onclick="deleteTeacherLinkHandler(this); return false" class="delete-link" data-link="/teachers/' + $('#teacher-id').val() + '/remove-hour/' + hourID + '"><i class="fa fa-remove"></i></a>'
	var firstLink = " <a href='/groups/" + $('#group').val() + "'>" + $('#group option:selected').text() + "</a> - ";
	var secondLink = " <a href='/disciplines/" + $('#discipline').val() + "'>" + $('#discipline option:selected').text() + "</a>";
	var html = deleteLink + firstLink + secondLink;
	html = '<div class="student">' + html + "</div>";
	
	if ($('.hours').html().trim() == "Список пуст")
		$('.hours').html(html);
	else
		$('.hours').prepend(html);
}

function teacherController() {
    var groupId = undefined;

    $('#get-hours-link').click(function() {
      $(this.parentElement.parentElement).hide();
      $('.hours-list').slideDown();
      return false;
    });

	$('#new_hour').submit(function(){
		$.ajax({
			url: '/teachers/' + $('#teacher-id').val() + '/add-hour/' + $('#group').val() + '/' + $('#discipline').val(),
			type: 'POST',
			success: function(result){
				addHour(result.id);
				return false;
			},
			error: function(response){
				alert("Не удалось добавить дисциплину");
				return false;
			}
		});
		return false;
	});

};
