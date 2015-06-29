if Permission.count == 0
  Permission.create(:title => 'roles')
  Permission.create(:title => 'permissions')
  Permission.create(:title => 'tags')
  Permission.create(:title => 'authors')
  Permission.create(:title => 'categories')
end

if Role.count == 0
  Role.create(:title => 'Admin', :permissions => Permission.all)
end

if Person.count == 0
  Person.create(:name => 'Admin',
          :slug => 'admin',
          :password => 'password',
          :about => 'Default admin account, edit profile then change name and password.',
          :avatar => '/images/avatar.png',
          :roles => Role.all)
end