module PlansHelper
  def link_to_add_discipline(form)
    new_object = Discipline.new
    fields = form.fields_for(:disciplines, new_object,
      :child_index => 'new_disciplines') do |builder|
      render('plans/add_disciplines', df: builder)
    end
    link_to(?#, class: 'btn btn-info',
        id: 'add_discipline_link', data: {content: "#{fields}"}) do
      fa_icon("plus") + "Новая дисциплина"
    end
  end

  def link_to_remove_discipline(form)
    form.hidden_field(:_destroy, class: 'remove_fields') +
      link_to(?#, class: 'remove_fields remove_discipline') do
       fa_icon('times', title: 'Удалить дисциплину') + 'Удалить'
    end
  end
end
