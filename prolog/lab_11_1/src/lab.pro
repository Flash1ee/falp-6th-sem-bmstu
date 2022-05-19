domains
	name = string
	city = string
	phone = integer

predicates
  	record(name, city, phone)
  
clauses
	record("Dmitry", "Moscow", "8(953)827-23-16").
	record("Alexey", "Novgorod", "8(960)522-74-27").
	record("Kate", "Kiev", "8(127)76-03-11").
	record("Vasily", "Krasnodar", "8(720)311-38-45").
	record("Maxim", "Samara", "8(495)641-49-14").
	record("Nastya", "London", "8(120)821-47-74").
	record("Volodya", "Kiev", "8(921)128-43-90").

goal
	record(Name, "Kiev", Phone).