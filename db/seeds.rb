admin = User.create(email: 'admin', password: 'admin', password_confirmation: 'admin')
admin.update_attribute(:activation_state, "active")
teacher = User.create(email: 'teacher', password: 'teacher', password_confirmation: 'teacher')
teacher.update_attribute(:activation_state, "active")
student = User.create(email: 'student', password: 'student', password_confirmation: 'student')
student.update_attribute(:activation_state, "active")
operator = User.create(email: 'operator', password: 'operator', password_confirmation: 'operator')
operator.update_attribute(:activation_state, "active")

users = [['Гаврелюк', 'Артемий', 'Андреевич', 'gaa120@mail.msiu.ru'], 
['Фомин', 'Валерий', 'Алексеевич', 'fva12@mail.msiu.ru'],
['Фомина', 'Наталья', 'Александровна', 'fna9@mail.msiu.ru'],
['Хараборчев', 'Илья', 'Сергеевич', 'xis4@mail.msiu.ru'],
['Салкин', 'Никита', 'Юрьевич', 'snq13@mail.msiu.ru'],
['Опекунов', 'Сергей', 'Дмитриевич', 'osd2@mail.msiu.ru'],
['Стрельская', 'Дарья', 'Александровна', 'sda102@mail.msiu.ru'],
['Умурзакова', 'Алина', 'Станиславовна', 'uak2@mail.msiu.ru'],
['Мишин', 'Андрей', 'Дмитриевич', 'mad19@mail.msiu.ru'],
['Сикачев', 'Евгений', 'Александрович', 'sea83@mail.msiu.ru'],
['Седых', 'Дмитрий', 'Владимирович', 'sdv39@mail.msiu.ru'],
['Никандрова', 'Ксения', 'Сергеевна', 'nks8@mail.msiu.ru'], 
['Татаринов', 'Сергей', 'Александрович', 'tsa27@mail.msiu.ru'], 
['Хачковский', 'Алексей', 'Дмитриевич', 'xad2@mail.msiu.ru']] 

users_obj = []
users.each do |u|
  u1 = User.find_by_email(u[3])
  if u1.blank?
    u1 = User.create(email: u[3], password: "123", password_confirmation: "123")
    u1.activation_state = 'active'
    u1.save
  end
  users_obj << u1
end

r1=Role.find_or_create_by(name: "Администратор", full_name: "Администратор системы")
r2=Role.find_or_create_by(name: "Студент", full_name: "Студент")
r3=Role.find_or_create_by(name: "Преподаватель", full_name: "Преподаватель")
r4=Role.find_or_create_by(name: "Оператор учебного центра", full_name: "Оператор учебного центра")

u2 = User.find_by_email("radigin@yandex.ru")
if u2.blank?
  u2 = User.create(email: "radigin@yandex.ru", password: "321", password_confirmation: "321")
  u2.activation_state = 'active'
  u2.save
end
RoleUser.create(user: u2, role: r3)

specialty = Specialty.create(code: "09.03.01",gen:"ФГОС3+", title:"Информатика и вычислительная техника", level: "Бакалавриат")
group = Group.create(title: "121132",course:"4",semester:"8")
plan = Plan.create(specialty: specialty, learn_form: "очная", learn_period: 48)
d1=Discipline.create(title: "Методы хранения и обработки информации", tip: "Курсовая работа", plan: plan)
d2=Discipline.create(title: "Базы данных", tip: "Курсовая работа", plan: plan)
d3=Discipline.create(title: "Структуры и алгоритмы компьютерной обработки данных", tip: "Курсовая работа", plan: plan)
d4=Discipline.create(title: "Вычислительные модели и алгоритмы", tip: "Курсовая работа", plan: plan)
d5=Discipline.create(title: "Веб-технологии", tip: "Курсовая работа", plan: plan)
d6=Discipline.create(title: "Производственная практика", tip: "Практика", plan: plan)
d7=Discipline.create(title: "ВКР", tip: "ВКР", plan: plan)
plan.groups << group


studs_obj = []
sda = nil
j = 0
users.each_with_index do |u, i|
  s1 = Student.create(l_n: u[0], f_n: u[1], s_n: u[2], birth: Date.new(1995, 3, 14) + rand(365).days, studbook: ((i + 1).to_s*6)[0..5], user: users_obj[i])
  group.students << s1
  studs_obj << s1
  if u[0] == 'Стрельская'
    s1.avatar = File.open('D.jpg', 'r')
    s1.birth = Date.new(1995, 3, 14)
    s1.about =<<END
<p>
Окончила Среднюю общеобразовательную школу № 1902 в 2012 году. 
Отучилась хорошо, окончила без троек. Во время учебы активно участвовала в творческой деятельности, 
а также отстаивала честь школы на олимпиадах по физике, русскому языку и МХК.</p>

<p>Участвовала во многих мероприятиях в рамках Университета.</p>

<p>Окончила курсы английского языка в 2015 году.</p>

<p>В свободное время уделяю внимание своим увлечениям, таким как латиноамериканские танцы, плаванье, декупаж, различные походы на выставки и фестивали города и многое другое.</p>    
END
    s1.save
    sda = s1
    RoleUser.create(user: users_obj[i], role: r1)
    RoleUser.create(user: users_obj[i], role: r2)
    RoleUser.create(user: users_obj[i], role: r4)
  elsif j < 5
    s1.avatar = File.open("s#{j + 1}.jpg", 'r')
    s1.save
    j += 1
  elsif j < 8
    s1.avatar = File.open("u#{j - 4}.jpg", 'r')
    s1.save
    j += 1
  end
end

RoleUser.create(user: admin, role: r2)
RoleUser.create(user: student, role: r2)
RoleUser.create(user: teacher, role: r3)
RoleUser.create(user: operator, role: r4)

t=Teacher.create(lname: "Радыгин", fname: "Виктор", sname: "Юрьевич", birth: Date.new(1980, 5, 10), degree: "к.т.н.", rank: "доцент", post: "доцент", user: u2)

AcademicHour.create(teacher: Teacher.first, discipline: Discipline.first, group: Group.first)
Department.create(num: "номер", title: "кафедра", superunit: "вышестоящее подразделение")

dt1=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d1.id)
dt2=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d2.id)
dt3=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d3.id)
dt4=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d4.id)
dt5=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d5.id)
dt6=Duty.create(name: "Отчёт о практике", discipline_id: d6.id)
dt7=Duty.create(name: "Пояснительная записка к ВКР", discipline_id: d7.id)

dt1=StudentWork.create(student: sda, title: "Пояснительная записка к курсовой работе", description: "Тема «Вычисление мощности множества точек пересечения границы
выпуклой оболочки со сторонами заданного стандартного
прямоугольника. Определение суммы длин проекций полностью
видимых ребер полиэдра, образующих с вертикалью угол не более 10∘»", discipline_id: d1.id, status: StudentWork::STATUS_SUCCESS)
dt2=StudentWork.create(student: sda, title: "Пояснительная записка к курсовой работе", description: "Тема «Модификация эталонного проекта «Аэропорт»: добавление
книги Жалоб и Предложений»", discipline_id: d2.id, status: StudentWork::STATUS_SUCCESS)
dt3=StudentWork.create(student: sda, title: "Пояснительная записка к курсовой работе", description: "Тема «Графы. Нахождение максимального потока по транспортной сети. Алгоритм Эдмондса-Карпа»", discipline_id: d3.id, status: StudentWork::STATUS_SUCCESS)
dt4=StudentWork.create(student: sda, title: "Пояснительная записка к курсовой работе", description: "Тема «Задача про Бонни и Клайда»", discipline_id: d4.id, status: StudentWork::STATUS_SUCCESS)
dt5=StudentWork.create(student: sda, title: "Пояснительная записка к курсовой работе", description: "Тема «Добавление системы отзывов о фильмах»", discipline_id: d5.id, status: StudentWork::STATUS_SUCCESS)
dt6=StudentWork.create(student: sda, title: "Отчёт о практике", description: "нет", discipline_id: d6.id, status: StudentWork::STATUS_ERROR)
dt7=StudentWork.create(student: sda, title: "Пояснительная записка к ВКР", description: "нет", discipline_id: d7.id, status: StudentWork::STATUS_ERROR)

t.disciplines << d1
t.disciplines << d2
t.disciplines << d3
t.disciplines << d4
t.disciplines << d5
t.disciplines << d6
t.disciplines << d7


