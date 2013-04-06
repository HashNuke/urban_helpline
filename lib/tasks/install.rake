  desc "Populate database with sample user data"
  task install: :environment do
    admin = User.new email: "admin@example.com", password: "password"
    if admin.save
      puts "Sample user created"
      puts "Email: #{admin.email}"
      puts "Password: password"
    end
  end

