source "https://rubygems.org"

ruby "3.2.3"

gem "rails", "~> 8.0.0.beta1"
gem "puma", "~> 6.4"
gem "sqlite3", "~> 1.7"
gem "httparty", "~> 0.23"
gem "rack-cors", "~> 2.0"
gem "bootsnap", "~> 1.18", require: false

group :development, :test do
  gem "dotenv-rails", "~> 3.1"
  gem "debug", platforms: %i[mri x64_mingw32 arm64_darwin]
end

group :development do
  gem "web-console", ">= 4.2.0"
  gem "listen", "~> 3.8"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
platforms :mingw, :x64_mingw, :mswin, :jruby, :truffleruby do
  gem "tzinfo-data"
end
