# frozen_string_literal: true

ActiveRecord::Base.transaction do
  ["common", Rails.env].each do |e|
    seed_file = Rails.root.join("db/seeds/#{e}.rb").to_s
    if File.exist?(seed_file)
      Rails.logger.debug { "- - Seeding data from file: #{seed_file}" }
      require seed_file
    end
  end
end
