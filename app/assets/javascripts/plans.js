function deletePlanLinkHandler(object){
	$.ajax({
		url: $(object).attr("data-link"),
		type: 'DELETE',
		success: function(){
			$(object.parentElement).remove();	
			if ($('.group').length == 0)
				$('.groups').html("Список пуст")
		}
	});
	return false;
}

function addGroup(title,id){
	var deleteLink = '<a title="Удалить" onclick="deletePlanLinkHandler(this); return false" class="delete-link" data-link="/groups/' + $('#group-id').val() + '/students/' + id + '"><i class="fa fa-remove"></i></a>'
	var html = " <a href='/groups/" + id + "'>" + title + "</a><br>";
	html = deleteLink + html;
	html = '<div class="student">' + html + "</div>";
	
	if ($('.groups').html().trim() == "Список пуст")
		$('.groups').html(html);
	else
		$('.groups').prepend(html);
}

function planController() {
    var groupId = undefined;

    $('#get-groups-link').click(function() {
      $(this.parentElement.parentElement).hide();
      $('.groups-list').slideDown();
      return false;
    });
    
    $('input[type="search"').on("change paste keyup", function() {
      $('.add-group').prop("disabled", true);
    });
    
	$('input[type="search"').autocomplete({
		serviceUrl: '/plans/' + $('#plan-id').val() + '/actual-groups',
		width: 300,
		noCache: true,
	    onSelect: function (suggestion) {
	        $('.add-group').prop("disabled", false);
	        groupId = suggestion.data;
	    }
	});

	$('.add-group').click(function(){
		if (!groupId)
			return;
		
		$('.add-group').prop("disabled", true);

		$.ajax({
			url: '/plans/' + $('#plan-id').val() + '/groups/' + groupId,
			type: 'POST',
			success: function(result){
				addGroup($('input[type="search"').val(), groupId);
				$('input[type="search"').val("");
			},
			error: function(){
				$('.add-group').prop("disabled", false);
				alert('Не удалось добавить группу');
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
				addGroup(fio, student.id);
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
