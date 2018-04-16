module API
  class Diaries < Grape::API
    desc 'Get all diaries'
    params do
      optional :limit, type: Integer, default: 10, desc: 'Set result limit.'
    end
    get '/diaries' do
      diaries = Diary.all
      present diaries
    end

  end
end