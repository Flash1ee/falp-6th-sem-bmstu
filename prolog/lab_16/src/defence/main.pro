% Кринж защита - Студенты-преподы-интересы с GUI
% GUI - через http сервер с отдачей index.html, написанном на vuetify гениями
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_path)).
:- use_module(library(http/http_server_files)).

:- initialization server.


:- dynamic student/3.
:- dynamic interes/2.
:- dynamic mentor/4.


student("19u390", "Борисов Максим Андреевич", budget).
student("19u394", "Буланый Константин Сергеевич", budget).
student("19u755", "Варин Дмитрий Владимирович", budget).
student("19u463", "Ивахненко Дмитрий Александрович", budget).
student("19u783", "Казаева Татьяна Алексеевна", budget).
student("19u791", "Котцов Матвей Дмитриевич", budget).
student("19u794", "Кузьмин Кирилл Олегович", budget).
student("19u232", "Ларин Владимир Николаевич", budget).
student("19u525", "Леонов Владислав Вячеславович", budget).
student("19u534", "Мазур Екатерина Алексеевна", budget).
student("19u811", "Межеровский Александр Сергеевич", budget).
student("19u587", "Параскун София Дмитриевна", money).
student("19u591", "Петрова Анна Алексеевна", money).
student("19u594", "Пинский Марк Григорьевич", money).
student("19u833", "Порошин Даниил Юрьевич", money).
student("19u609", "Прянишников Александр Николаевич", money).
student("19u638", "Сироткина Полина Юрьевна", money).
student("19u641", "Слепокурова Мария Федоровна", money).
student("19u648", "Солнцева Татьяна Викторовна", money).
student("19u651", "Супрунова Екатерина Алексеевна", money).
student("19u855", "Тагилов Александр Михайлович", money).
student("19u857", "Тартыков Лев Евгеньевич", money).
student("19u665", "Тонкоштан Андрей Алексеевич", money).
student("19u668", "Трошкин Николай Романович", money).
student("19u867", "Хрюкин Арсений Александрович", money).

mentor("stroganov", "Строганов Юрий Владимирович", 1, 1).
mentor("kostritskiy", "Кострицкий Александр Сергеевич", 2, 3).
mentor("tassov", "Тассов Кирилл Леонидович", 2, 3).


interes("19u755", "Backend на гошке").
interes("19u755", "Макдак").

interes("stroganov", "Чука-Рума").
interes("stroganov", "Lisp").
interes("stroganov", "Отчислить").
interes("stroganov", "Лаба - курсач").


interes("kostritskiy", "Ничто не торт кроме торта").
interes("kostritskiy", "Траливирование").
interes("kostritskiy", "Траливалирование").
interes("kostritskiy", "Как же я хорош").
interes("kostritskiy", "Как мощны мои лапища").


interes("19u594", "Украина").
interes("19u783", "Компьютерная графика").

interes("19u534", "Ничто не торт кроме торта").

interes("19u811", "Как же я хорош").

interes("19u232", "Отчислить").
interes("19u232", "Лаба - курсач").

interes("tassov", "Украина").
interes("tassov", "ООП").
interes("tassov", "Индусский код").

student("tassov", "Индусский код").



common_interes(StudentLogin, MentorLogin, Interes):-
    interes(StudentLogin, Interes),
    interes(MentorLogin, Interes).

all_common_interes_count(MentorLogin, StudentLogin, Name, Type, Count):-
    bagof(I,common_interes(StudentLogin, MentorLogin, I), Interes),
    length(Interes,Count),
    student(StudentLogin, Name, Type).

find_students(MentorLogin, StudentsPair, Type):-
    findall([Student, Name, Type, Count], all_common_interes_count(MentorLogin, Student, Name, Type, Count), StudentsPair).

take(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
take(_, [], []).
take(N, [X|Xs], [X|Ys]) :- N > 0, M is N-1, take(M, Xs, Ys).

sort_students_pred([_,_,_, A], [_,_,_, B]):- A @> B.
sort_students_pred(R, [_,_,_, C1], [_,_,_, C2]):-         C1>C2 -> R = < ; R = > .



prepare_students(MentorLogin, StudentsPair, Type, Count):-
    find_students(MentorLogin, UnsortedStudentsPair, Type)
    , predsort(sort_students_pred, UnsortedStudentsPair,  StudentsPair).

add_mentor(Login, Name, Budget, Money):-
    assertz(mentor(Login, Name, Budget, Money)).

add_student(Login, Name, Type):-
    assertz(student(Login, Name, Type)).

add_interes(Login, Interes):-
    assertz(interes(Login, Interes)).


	
% :- http_handler(root(.), my_func, []).

% my_func(_Request):-
%     reply_json(json{field:"hello"}).


file_search_path(static, '/Users/dvvarin/BMSTU/falp-6th-sem-bmstu/prolog/lab_16/src/defence').
http:location(static,	root(.), []).
:- http_handler(static(.), serve_files_in_directory(static), [prefix]).




:- http_handler(root(mentor/Mentor), get_mentor_handler(Mentor), []).

get_mentor_handler(AMentor, _Request):-
    atom_string(AMentor, Mentor),
	mentor(Mentor, Name, Budget, Money), !,
    findall(X, interes(Mentor, X), IntersL),
    prepare_students(Mentor, BStudents, budget, Budget), !,
    prepare_students(Mentor, MStudents, money, Money), !,
	reply_json(json{mentor:json{login:Mentor, name: Name, budget:Budget, money:Money, interes: IntersL, students: json{
        budget:BStudents,
        money:MStudents
        }}}).

get_mentor_handler(_, _Request):-
    reply_json(json{}).

:- http_handler(root(student/Student), get_student_handler(Student), []).

get_student_handler(AStudent, _Request):-
    atom_string(AStudent, Student),
	student(Student, Name, Type), !,
    findall(X, interes(Student, X), IntersL),
	reply_json(json{student:json{login:Student, name: Name, type:Type, interes: IntersL}}).

get_student_handler(Student, _Request):-
    reply_json(json{query:Student}).


:- http_handler(root(students), get_students_handler, []).

get_students_handler(_Request):-
    findall(json{login:Student, name: Name, type:Type},student(Student, Name, Type), List),
	reply_json(json{students:List}).


:- http_handler(root(mentors), get_mentors_handler, []).

get_mentors_handler(_Request):-
    findall(json{login:Mentor, name: Name, budget:Budget, money:Money},mentor(Mentor, Name, Budget, Money), List),
	reply_json(json{mentors:List}).

:- http_handler(root(add/mentor), add_mentor_handler, []).

add_mentor_handler(Request):-
    http_parameters(Request,
        [ login(Login, [ string ]),
          name(Name, [ string ]),
          budget(Budget,   [integer]),
          money(Money,   [integer ])
        ]),
        Budget >= 0,
        Money >= 0,
    add_mentor(Login, Name, Budget, Money),
    reply_json(json{status:'ok'}).

add_mentor_handler(Request):-
    reply_json(json{status:'error'}).


:- http_handler(root(add/student), add_student_handler, []).

add_student_handler(Request):-
    http_parameters(Request,
        [ login(Login, [ string ]),
          name(Name, [ string ]),
          type(Type,   [atom])
        ]),
    member(Type, [budget, money]),
    add_student(Login, Name, Type),
    reply_json(json{status:'ok'}).

add_student_handler(_Request):-
    reply_json(json{status:'error'}).

:- http_handler(root(add/interes), add_interes_handler, []).
add_interes_handler(Request):-
    http_parameters(Request,
        [ login(Login, [ string ]),
          interes(Interes, [ string ])
        ]),
    add_interes(Login, Interes),
    reply_json(json{status:'ok'}).



server() :-
        http_server(http_dispatch, [port(1488)]).