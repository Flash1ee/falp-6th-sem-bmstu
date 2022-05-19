domains
    id = unsigned.
    name, university = symbol.

predicates
    StudentID(id, name).
    StudyIn(id, university).
    studentsFromUniversity(university, id, name).

clauses
    StudentID(0, "Dmitriy").
    StudentID(1, "Dmitriy").
    StudentID(2, "Volodya").
    StudentID(3, "Maxim").
    StudentID(4, "Nikolay").

    StudyIn(0, "BMSTU").
    StudyIn(1, "MSU").
    StudyIn(2, "MAI").
    StudyIn(3, "BMSTU").
    StudyIn(4, "BMSTU").
    StudyIn(0, "KTU").
    StudyIn(2, "Cambridge").
    StudyIn(3, "MIREA").

    studentsFromUniversity(University, Id, Name) :- StudentID(Id, Name), StudyIn(Id, University).

goal
    StudentID(ID, "Dmitriy").
    % StudentID(0, Name).

    % StudyIn(ID, "BMSTU").
    % StudyIn(0, U).

    % studentsFromUniversity("BMSTU", ID, NAME).
    % studentsFromUniversity(U, ID, "Maxim").

	Символьная константа

	имя отношения
	значение конкретного отношения, объекта предметной области