module API
  class Diaries < Grape::API
    helpers SharedParams

    before do
      authenticate_user!
    end

    desc '获取当前登录用户的所有日记内容', tags: ['日记']
    params do
      optional :limit, type: Integer, default: 10, desc: '结果条数'
    end
    get '/diaries' do
      diaries = current_user.diaries.limit(params[:limit])
      present diaries, with: API::Entities::Diary
    end

    desc '新增日记内容', consumes: ['application/x-www-form-urlencoded'], tags: ['日记']
    params do
      use :diary
    end
    post '/diaries' do
      diary = Diary.new declared(params)
      diary.user_id = current_user.id
      diary.save
      present diary, with: API::Entities::Diary
    end

    desc '修改日记内容', consumes: ['application/x-www-form-urlencoded'], tags: ['日记']
    params do
      use :diary
    end
    put '/diaries/:id' do
      diary = Diary.find(params[:id])
      error!({ error_code: 404, error_message: "没有这篇日记" }, 404) unless diary
      diary.update declared(params)
      present diary, with: API::Entities::Diary
    end

    desc '删除日记', tags: ['日记']
    delete '/diaries/:id' do
      diary = Diary.find(params[:id])
      error!({ error_code: 404, error_message: "没有这篇日记" }, 404) unless diary
      { status: 'ok' } if diary.destroy
    end
  end
end