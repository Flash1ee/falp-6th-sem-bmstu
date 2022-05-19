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
  owner_by_car(mark, color, lastname, city, phone, bank)
  
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
  car("Kautz", "Opel", "silver", 7980).
  bank_depositor("Vlasov", "Raiffaizen", 1, 10000).
  bank_depositor("Lee", "Sberbank", 2, 4000).
  bank_depositor("Somov", "Tinkoff", 3, 10340).
  bank_depositor("Kautz", "Alfabank", 4, 1550).
  bank_depositor("Shevtsov", "VTB", 5, 900600).

owner_by_car(Mark, Color, Lastname, City, Phone, Bank) :- 
  car(Lastname, Mark, Color, _),
  phone(Lastname, Phone, addr(City, _, _, _)),
  bank_depositor(Lastname, Bank, _, _).
  
goal
  owner_by_car("Opel", "silver", A, B, C, D)
  % owner_by_car("honda", "civik", A, B, C, D)
  % owner_by_car("Lada", "black", A, B, C, D)

