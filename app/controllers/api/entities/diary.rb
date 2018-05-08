module API
  module Entities
    class Diary < Base
      expose :title, documentation: '理事ビア落ち'
      expose :content, documentation: '日记内容'
      expose :weather
      expose :mood
    end
  end
end