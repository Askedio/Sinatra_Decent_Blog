if Person.count == 0
  person = Person.create(:name => 'Admin', :slug => 'admin', :password => 'password', :about => 'Default admin account, edit profile then change name and password.', :avatar => '/images/avatar.png')

end