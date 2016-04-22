# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Location.all().each do |loc|
    loc.destroy!()
end

Video.all().each do |vid|
    vid.destroy!()
end

Obd.all().each do |obd|
    obd.destroy!()
end

Employee.all().each do |emp|
    emp.destroy!()
end

User.all().each do |user|
    user.destroy!()
end

user = User.create(email: 'fake@fake.com', password_digest: User.digest('bob') )
employee1 = user.employees.create!(name: 'Hunter', eid: 1)
employee2 = user.employees.create!(name: 'Tyler', eid: 2)
employee1.locations.create!(lat: 30.5879615, lng: -96.3344641, time: Time.now)
employee1.locations.create!(lat: 30.585, lng: -96.3, time: Time.now)
employee1.locations.create!(lat: 30.587, lng: -96.33, time: Time.now.advance(:days => 1))
employee2.locations.create!(lat: 30.59, lng: -96.33, time: Time.now)
employee2.locations.create!(lat: 30.595, lng: -96.335, time: Time.now)
employee2.locations.create!(lat: 30.587, lng: -96.33, time: Time.now.advance(:days => 1))
