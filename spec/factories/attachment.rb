FactoryBot.define do
  factory :attachment do
    basic_user
    invoice

    factory :correct_attachment do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'avatar.png'), 'image/png') }
    end

    factory :too_big_attachment do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'large_avatar.png'), 'image/png') }
    end

    factory :bad_extension_attachment do
      file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'avatar.mp3'), 'music/mp3') }
    end

  end

end
