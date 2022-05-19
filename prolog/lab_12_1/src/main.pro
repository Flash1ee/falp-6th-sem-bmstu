domains
  lastname = string
  city, street = string
  house, flat = integer
  phone = string
  address = addr(city, street, house, flat)
  mark = string
  color = string
  price = integer
  bank = string
  id, amount = integer
  
predicates
  phone(lastname, phone, address)
  car(lastname, mark, color, price)
  bank_depositor(lastname, bank, id, amount)
  car_by_phone(phone, lastname, mark, price)
  only_mark_by_phone(phone, mark)
  data_by_surname_and_city(lastname, city, street, bank, phone)
  
clauses
  phone("Bakin", "66", addr("Moscow", "Red Square", 1, 1)).
  phone("Somov", "4422",addr("Novgorod", "Mira", 22, 11)).
  phone("Shevtsov", "22",addr("Odessa", "IU7", 21, 2)).
  phone("Averina", "664422", addr("Kiev", "Baumana", 10, 4)).
  car("Kautz", "BMW", "black", 220).
  car("Vlasov", "Kamaz", "yellow", 128).
  car("Lakin", "Lada", "blue", 3000).
  car("Averina", "Opel", "silver", 458).
  car("Lukash", "Belaz", "white", 5120).
  car("Somov", "Mazda", "red", 2200).
  bank_depositor("Vlasov", "Raiffaizen", 1, 10000).
  bank_depositor("Lee", "Sberbank", 2, 4000).
  bank_depositor("Somov", "Tinkoff", 3, 10340).
  bank_depositor("Kautz", "Alfabank", 4, 1550).
  bank_depositor("Shevtsov", "VTB", 5, 900600).
   
  car_by_phone(Phone, Surname, Mark, Price) :- phone(Surname, Phone, _), car(Surname, Mark, _, Price).
  only_mark_by_phone(Phone, Mark) :- car_by_phone(Phone, _, Mark, _).
  data_by_surname_and_city(Surname, City, Street, Bank, Phone) :- phone(Surname, Phone, addr(City, Street, _, _)), bank_depositor(Surname, Bank, _, _).
  
goal
  %car_by_phone("664422", Surname, Mark, Price).
  %only_mark_by_phone("664422", Mark).
  data_by_surname_and_city("Shevtsov", "Odessa", Street, Bank, Phone).