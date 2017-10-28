AdminUser.create!(email: 'admin@example.com', password: ENV['ADMIN_USER_PASSWORD'], password_confirmation: ENV['ADMIN_USER_PASSWORD'], role: 1)
