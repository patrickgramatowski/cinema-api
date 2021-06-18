# Create ticket desks
TicketDesk.create(online: true)
4.times { TicketDesk.create(online: false) }

# Create halls
Hall.create(hall: 'Hall 1', seats: 200)
Hall.create(hall: 'Hall 2', seats: 100)
Hall.create(hall: 'Hall 3', seats: 100)
Hall.create(hall: 'Hall 4', seats: 100)
Hall.create(hall: 'Hall 5', seats: 100)
Hall.create(hall: 'Hall 6', seats: 50)
Hall.create(hall: 'Hall 7', seats: 50)
Hall.create(hall: 'Hall 8', seats: 50)
Hall.create(hall: 'Hall 9', seats: 50)
Hall.create(hall: 'Hall 10', seats: 20)

# Create 'abstract' user
User.create(id: 999, email: "abstract_user@gmail.com", password: "wordpass" employee: false)
