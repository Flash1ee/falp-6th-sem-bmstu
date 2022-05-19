domains
  lastname = string.
  city, street = string.
  house, flat = integer.
  phone = string.
  address = addr(city, street, house, flat).
  mark = string.
  color = string.
  price = integer.
  bank = string.
  name = string.
  id, amount = integer.
  some_property = car(mark, color, price);
    real_estate(name, price);
    plot(name, price);
    water_transport(mark, color, price).

  
predicates
  phones(lastname, phone, address).
  bank_depositor(lastname, bank, id, amount).
  owner(lastname, some_property).

  all_property(lastname, name).
  all_property_with_price(lastname, name, price).

clauses
  phones("Bakin", "66", addr("Moscow", "Red Square", 1, 1)).
  phones("Somov", "4422",addr("Novgorod", "Mira", 22, 11)).
  phones("Shevtsov", "22",addr("Odessa", "IU7", 21, 2)).
  phones("Averina", "664422", addr("Kiev", "Baumana", 10, 4)).

  owner("Bakin", car("Lada", "blue", 1000)).
  owner("Bakin", plot("house", 1000)).
  owner("Bakin", real_estate("burdj halifa", 1000)).

  owner("Somov", car("Mazda", "red", 1000)).
%   owner("Somov", plot("odintsovo", 10000)).
  owner("Somov", real_estate("village", 20000)).
%   owner("Somov", water_transport("honda", "red", 10000)).

  owner("Shevtsov", car("Belaz", "white", 20000)).
  owner("Shevtsov", plot("box", 200000)).
  owner("Averina", car("Opel", "silver", 30000)).
  owner("Averina", plot("secret info", 10)).

  bank_depositor("Bakin", "Raiffaizen", 1, 10000).
  bank_depositor("Bakin", "Sberbank", 2, 4000).
  bank_depositor("Somov", "Tinkoff", 3, 10340).
  bank_depositor("Averina", "Alfabank", 4, 1550).
  bank_depositor("Shevtsov", "VTB", 5, 900600).

  all_property(Lastname, Name) :- owner(Lastname, car(Name, _, _)).
  all_property(Lastname, Name) :- owner(Lastname, real_estate(Name, _)).
  all_property(Lastname, Name) :- owner(Lastname, plot(Name, _)).
  all_property(Lastname, Name) :- owner(Lastname, water_transport(Name, _, _)).

  all_property_with_price(Lastname, Name, Price) :- owner(Lastname, car(Name, _, Price)).
  all_property_with_price(Lastname, Name, Price) :- owner(Lastname, real_estate(Name, Price)).
  all_property_with_price(Lastname, Name, Price) :- owner(Lastname, plot(Name, Price)).
  all_property_with_price(Lastname, Name, Price) :- owner(Lastname, water_transport(Name, _, Price)).
  
goal
  all_property("Bakin", Name).
  %all_property_with_price("Somov", Name, Price).
