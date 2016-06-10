function deleteLinkHandler(object){
	$.ajax({
		url: $(object).attr("data-link"),
		type: 'DELETE',
		success: function(){
			$(object.parentElement).remove();	
			if ($('.student').length == 0)
				$('.students').html("Список пуст")
		}
	});
	return false;
}

function addStudent(fio,id){
	var deleteLink = '<a title="Удалить" onclick="deleteLinkHandler(this); return false" class="delete-link" data-link="/groups/' + $('#group-id').val() + '/students/' + id + '"><i class="fa fa-remove"></i></a>'
	var html = " <a href='/students/" + id + "'>" + fio + "</a><br>";
	html = deleteLink + html;
	html = '<div class="student">' + html + "</div>";
	
	if ($('.students').html().trim() == "Список пуст")
		$('.students').html(html);
	else
		$('.students').prepend(html);
}

function groupsController() {
    var studentId = undefined;

    $('#get-students-link').click(function() {
      $(this.parentElement.parentElement).hide();
      $('.students-list').slideDown();
      return false;
    });
    
    $('input[type="search"').on("change paste keyup", function() {
      $('.add-student').prop("disabled", true);
    });
    
	$('input[type="search"').autocomplete({
		serviceUrl: '/groups/' + $('#group-id').val() + '/actual-students',
		width: 300,
		noCache: true,
	    onSelect: function (suggestion) {
	        $('.add-student').prop("disabled", false);
	        studentId = suggestion.data;
	    }
	});

	$('.create-student').click(function(){
		$.fancybox("#student-registration-form");
		return false;
	})

	$('.fancybox').fancybox();

	$('.add-student').click(function(){
		if (!studentId)
			return;
		
		$('.add-student').prop("disabled", true);

		$.ajax({
			url: '/groups/' + $('#group-id').val() + '/students/' + studentId,
			type: 'POST',
			success: function(result){
				addStudent($('input[type="search"').val(), studentId);
				$('input[type="search"').val("");
			},
			error: function(){
				$('.add-student').prop("disabled", false);
				alert('Не удалось добавить студента в группу');
			}
		})
	})

	$('#new_student').submit(function(){
		$.ajax({
			url: '/groups/' + $('#group-id').val() + '/create_student',
			data: $('#new_student').serialize(),
			type: 'POST',
			success: function(student){
				var fio  = student.l_n + " " + student.f_n + " " + student.s_n;
				addStudent(fio, student.id);
				$.fancybox.close();
				return false;
			},
			error: function(response){
				var html = "";
				errors = response.responseJSON;
				for (var i = 0; i < errors.length; i++)
					html = html + errors[i] + "<br>"
				$('.errors .list').html(html);
				$('.errors').show();
				setTimeout(function(){
					$('.errors').fadeOut();
				}, 1500)
				return false;
			}
		});
		return false;
	});

};
