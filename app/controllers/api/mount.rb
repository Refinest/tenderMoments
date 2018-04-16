module API
  class Mount < Grape::API
    mount Diaries
  end
end