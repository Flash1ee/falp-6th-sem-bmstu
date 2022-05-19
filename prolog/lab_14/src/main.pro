domains
  sex = symbol
  name = string
  man = man(sex, name)
  
predicates
  parent(man, man)
  grandparent(man, sex, name)
  
clauses
  grandparent(man(Sex, Gname), Anysex, Name) :- 
    parent(man(Sex, Gname), man(Anysex, Anyname)), parent(man(Anysex, Anyname), man(_, Name)).

  parent(man(f, "Masha"), man(m, "Alexey")).
  parent(man(m, "Vasiliy"), man(m, "Alexey")).
  parent(man(f, "Alex"), man(f, "Masha")).
  parent(man(m, "Sergey"), man(f, "Masha")).
  parent(man(f, "Sasha"), man(m,"Vasiliy")).
  parent(man(m, "Vasiliy"), man(m, "Vasiliy")).
  
% Alex Sasha
goal
  grandparent(man(f, Gname), _, "Alexey").
  %grandparent(man(m, Gname), _, "Alexey").
  %grandparent(man(_, Gname), _, "Alexey").
  %grandparent(man(f, Gname), f, "Alexey").
  %grandparent(man(_, Gname), f, "Alexey").