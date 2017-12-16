server "13.230.13.45",
   user: "umeki",
   roles: %w{web app db}

set :ssh_options, keys: '~/.ssh/amiry_id_rsa'  
