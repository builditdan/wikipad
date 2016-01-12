class FavoriteMailer < ApplicationMailer
  default from: ENV('GMAIL_PASSWORD')

end
