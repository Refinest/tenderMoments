module API
  module Entities
    class Diary < Base
      expose :title
      expose :content
      expose :weather
      expose :mood
    end
  end
end