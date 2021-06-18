# RubyCamp Monterail API
    
## Must have    
### Functional requirements:    
   
- [x] Endpoint to buy tickets/create reservation from ticket desk   
- [x] Endpoint to buy tickets/create reservation from online application   
- [x] There should be mechanism (Cronjob? Background job?) to terminate reservation if somebody did not pay ~30 minutes before screening (for reservations created by online application)    
- [ ] There should be email communication provided:    
- [ ] When reservation is created (tickets, seats and price should be attached)   
- [ ] When reservation is terminated (the reason should be attached)   
- [x] Creating reservation should be robust and there should be validations (for instance - for already taken seats etc., - consider edge cases).   
- [x] Application should have implemented authentication (there should be logging by user and by employer)   
- [x] Application should have authorization in terms of role-based separation   
- [x] Regular user should have ability to create only online reservation   
- [x] Employer should have ability to create online reservation but also offline reservation
     
### Not functional requirements:  
   
- [x] API should be documented    
- [ ] Application should have provided seeds and should be generally operational   
- [x] At least 80% of tests coverage    
- [ ] Application should have connected Sentry and CircleCI   
- [ ] Application should be accessible publicly (for instance by Heroku)   
- [x] Application should have configured rubocop and should fulfill all rubocop requirements. 
      
### Nice to have:   
   
- [x] JSON:API endpoint   
- [ ] GraphQL endpoint  
- [ ] File upload (for instance avatar for user?)  
- [x] Other functionalities like adding new movies, screenings, cinema halls   

## Technologies:
- Ruby 2.7.3
- Rails 6.1.3
- Bundler 2.2.17
- PostgreSQL 12.7

### Setup
To install the gems required by the application:
```
bundle install
```

Set your username/password (PostgreSQL) in config/database.yml, then run:
```
rails db:create
rails db:migrate
```

#### Run server
Start the Rails app:
```
rails s
```
Now You can find your app by pointing your browser to http://localhost:3000/

##### RubyCamp Monterail 2021
