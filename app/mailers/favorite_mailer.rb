class FavoriteMailer < ApplicationMailer
  default from: ENV('GMAIL_PASSWORD')
  byebug
end
