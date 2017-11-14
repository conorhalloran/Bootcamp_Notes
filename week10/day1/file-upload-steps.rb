1.) Install these Gems:
    gem 'carrierwave', '~> 1.0'
    gem "mini_magick"
    gem 'fog-aws'

    1.2) bundle
2.) rails g uploader Image
    2.1) rails g migration add_image_to_products image
    2.2) rails db:migrate
3.) #in app/uploaders/image_uploader.rb Uncomment: 
    def extension_whitelist
        %w(jpg jpeg gif png)
    end

4.) in product.rb 
mount_uploader :image, ImageUploader
5.) in _form.html.erb:
# <%= form.input :image %>
6.) in products_controller.rb
#add to product_params:
    params.require(:product).permit(:title, :description, :image, :price, :category_id, {tag_ids: []})
7.) in show.html.erb:
# <%= image_tag @question.image.url %>
8.) Setup Multiple Sized Images: Install Mini_Magic
Ensure imageMagic is installed: brew install imagemagick
gem "mini_magick"

    8.1) in image_uploader.rb:
        uncomment:   include CarrierWave::MiniMagick

        and

        version :thumb do
            process resize_to_fit: [50, 50]
        end

    8.2) create:

        version :medium do
            process resize_to_fit: [150, 150]
        end

        version :large do
            process resize_to_fit: [350, 350]
        end
    8.3) uncomment: fog, replace with:
    if Rails.env.production?
        storage :fog
    else
        storage :file
    end

    to test if fog works, have other lines commented out:
    # if Rails.env.production?
        storage :fog
    # else
    #     storage :file
    # end 

9.) Create a setup_fog.rb file in /config/initializers:
    CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'] || '',
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || '',
        region: 'us-west-2'
    }

    config.fog_directory = 'amazon-clone-conor' # AWS S3 Bucket Name
    config.fog_public = false
    config.fog_attributes = {
        'Cache-Control' => "max-age=#{365.day.to_i}"
    }
    end
10.) setup aws key_id and access_key in app_keys
ENV['AWS_ACCESS_KEY_ID'] = 'PUT YOUR AWS ACCESS KEY ID HERE'
ENV['AWS_SECRET_ACCESS_KEY'] = 'PUT YOUR AWS SECRET ACCESS KEY HERE'
