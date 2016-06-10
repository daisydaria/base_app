module SideBarHelper
  def side_bar_items(ru)
    result = []
    result << {
      :name => 'Главная',
      :icon => 'list',
      :controller => :welcome, 
      :action => :index
    }

    if is_admin?
      result << {
        :name => 'Администрирование',
        :icon => 'users',
        :children => [
          {:name => 'Пользователи',
           :controller => :users, :action => :index,
           :icon => 'file-text-o',
           :class => 'long'},
          {:name => 'Добавление',
           :controller => :users, :action => :new,
           :icon => 'user-plus'}
      ]} 
      result << {
      :name => 'Кафедры',
      :icon => 'star',
      :controller => :departments, 
      :action => :index
    }
    end

    if is_teacher?
        result << {
          :name => 'Студенты',
          :icon => 'user',
          :controller => :students, 
          :action => :index
        }
    end

    if is_student?
      result << {
            name: "Мои работы",
            :controller => :students,
            :action => :my_works,
            :icon => 'star'
          }
      result << {
            name: "Мои достижения",
            :controller => :students,
            :action => :my_honors,
            :icon => 'star'
          }
    end
    if is_operator?
      result << {
          :name => 'Студенты',
          :icon => 'user',
          :controller => :students, 
          :action => :index
        }
      result << {
        :name => 'Учебные группы',
        :icon => 'sitemap',
        :children => [
          {:name => 'Все группы',
           :controller => :groups, :action => :index,
           :icon => 'file-text-o'},
           {:name => 'Добавить группу',
           :controller => :groups, :action => :new,
           :icon => 'plus',
           :class => 'long'}
      ]}
      result << {
      :name => 'Специальности',
      :icon => 'star',
      :controller => :specialties, 
      :action => :index
    }
    result << {
      :name => 'Уч. планы',
      :icon => 'list',
      :controller => :plans, 
      :action => :index
    }
    
    result << {
      :name => 'Дисциплины',
      :icon => 'th',
      :controller => :disciplines, 
      :action => :index
    }

    result << {
      :name => 'Преподаватели',
      :icon => 'star',
      :controller => :teachers, 
      :action => :index
    }
    end

    result
end



  
  def is_open?(ctr, act)
    case ctr.to_s
    when 'users'
      ctr.to_s == controller_name.to_s  
    else
      false
    end
  end
end
