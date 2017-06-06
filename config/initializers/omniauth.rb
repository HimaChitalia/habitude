OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "1025298811953-gnnbqubvj0advfbdiuohqckhq0hjg2o6.apps.googleusercontent.com", "-1TwWv5regYB_6bXG6DhmdD_"
end
