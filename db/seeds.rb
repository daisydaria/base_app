admin = User.create(email: 'admin', password: 'admin', password_confirmation: 'admin')
admin.update_attribute(:activation_state, "active")
teacher = User.create(email: 'teacher', password: 'teacher', password_confirmation: 'teacher')
teacher.update_attribute(:activation_state, "active")
student = User.create(email: 'student', password: 'student', password_confirmation: 'student')
student.update_attribute(:activation_state, "active")
operator = User.create(email: 'operator', password: 'operator', password_confirmation: 'operator')
operator.update_attribute(:activation_state, "active")


s=Student.create(l_n: "Стрельская", f_n: "Дарья", s_n: "Александровна", birth: Date.new(1995, 3, 14), studbook: "123456", user_id: student.id)
t=Teacher.create(lname: "Радыгин", fname: "Виктор", sname: "Юрьевич", birth: Date.new(1980, 5, 11), degree: "к.т.н.", rank: "доцент", post: "доцент", user_id: teacher.id)

d=Discipline.create(title: "Базы данных", tip: "Курсовая работа", plan_id: p.id)
d2=Discipline.create(title: "Проектирование и разработка корпоративных инф. систем", tip: "Курсовая работа", plan_id: p.id)
d3=Discipline.create(title: "Защита информации", tip: "Курсовая работа", plan_id: p.id)

dt=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d.id)
dt2=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d2.id)
dt3=Duty.create(name: "Пояснительная записка к курсовой работе", discipline_id: d3.id)

t.disciplines << d
t.disciplines << d2
t.disciplines << d3


r1=Role.find_or_create_by(name: "Администратор", full_name: "Администратор системы")
r2=Role.find_or_create_by(name: "Студент", full_name: "Студент")
r3=Role.find_or_create_by(name: "Преподаватель", full_name: "Преподаватель")
r4=Role.find_or_create_by(name: "Оператор учебного центра", full_name: "Оператор учебного центра")

RoleUser.create(user: admin, role: r1)
RoleUser.create(user: student, role: r2)
RoleUser.create(user: teacher, role: r3)
RoleUser.create(user: operator, role: r4)

specialty = Specialty.create(code: "код",gen:"поколоение", title:"название", level: "уровень")
group = Group.create(title: "Группа",course:"1",semester:"1")
plan = Plan.create(specialty: specialty, learn_form: "очная", learn_period: 36)
plan.disciplines << Discipline.all
plan.groups << group
group.students << Student.first
AcademicHour.create(teacher: Teacher.first, discipline: Discipline.first, group: Group.first)
Department.create(num: "номер", title: "кафедра", superunit: "вышестоящее подразделение")