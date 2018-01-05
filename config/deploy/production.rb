server "13.230.13.45",
   user: "umeki",
   roles: %w{web app db}

set :ssh_options, keys: '~/.ssh/amiry_id_rsa'

set :default_env, {
  AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
  AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY'],
  S3_ASSET_HOST: ENV['S3_ASSET_HOST']
}
