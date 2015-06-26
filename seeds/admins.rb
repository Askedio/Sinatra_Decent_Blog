person= Person.all
if person.count == 0
  new_person = Person.new(:name => 'Admin', :password => 'password', :about => 'Default admin account, edit profile then change name and password.', :avatar => '/images/avatar.png')
  new_person.save
end