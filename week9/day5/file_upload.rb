PaperClip / CarrierWave:

PaperClip = Easier
CarrierWave = Configurable.

CarrierWave Gem
rails generate uploader Image
rails g migration add_image_to_questions image

#in app/uploaders/image_uploader.rb
Uncomment: 
def extension_whitelist
    %w(jpg jpeg gif png)
end

in question.rb 
mount_uploader :image, ImageUploader

in _form.html.erb:
# <%= form.input :image %>

in questions_controller.rb
add to question_params:
    params.require(:question).permit(:title, :body, :image, {tag_ids: []})

in show.html.erb:
# <%= image_tag @question.image.url %>

2.) Setup Multiple Sized Images: Install Mini_Magic
Ensure imageMagic is installed: brew install imagemagick
gem "mini_magick"

in image_uploader.rb:
uncomment:   include CarrierWave::MiniMagick

and

version :thumb do
    process resize_to_fit: [50, 50]
end

create:

version :medium do
    process resize_to_fit: [150, 150]
end

version :large do
    process resize_to_fit: [350, 350]
end

UPDATE SHOW.HTML.ERB FILE:
<%= image_tag @question.image.url(:large) %>

