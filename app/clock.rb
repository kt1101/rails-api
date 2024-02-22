require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
 every(1.minutes, 'less.frequent.user_tokens.clean') {
   UserToken.where("created_at <= ?", 1.hours.ago).destroy_all
 }
end