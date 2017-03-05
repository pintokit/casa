desc "This task is called by the Heroku scheduler add-on"
task :pull_listings => :environment do
  puts "Pulling listings..."
  JsonListingJob.new("nema", ENV['NEMA_URL'], 0).perform_now
  JsonListingJob.new("nema", ENV['NEMA_URL'], 1).perform_now
  puts "Listings pulled successfully."
end
