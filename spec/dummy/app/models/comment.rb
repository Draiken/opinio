class Comment < ActiveRecord::Base
  opinio
  paginates_per 10
end
