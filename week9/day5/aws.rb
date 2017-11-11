Storage: S3:
Create Bucket. Set Region. Name must unique. 

1.) Install Fog Gem: gem 'fog-aws'

2.) create setup_fog.rb in config/initializers

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'] || '',
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || '',
    region: 'us-west-2'
  }

  config.fog_directory = 'awesome_answers_conor' # AWS S3 Bucket Name
  config.fog_public = false
  config.fog_attributes = {
    'Cache-Control' => "max-age=#{365.day.to_i}"
  }
end

3.) Get credentials: 
AWS: Click on your name, my security credentials, create key
4.) Add to app_keys:
ENV['AWS_ACCESS_KEY_ID'] = 'INSERT ACCESS_KEY_ID'
ENV['AWS_SECRET_ACCESS_KEY'] = 'INSERT SECRET_ACCESS_KEY'

5.) Image_uploader.rb
if Rails.env.production?
        storage :fog
    else
        storage :file
    end
6.) 