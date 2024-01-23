require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      #ユーザを作成しておく
      # user_a = FactoryBot.create(:user)
      user_a = FactoryBot.create(:user, name:"ユーザーA", email: 'a@example.com')
      #作成者がユーザAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザAがログインしている時' do
      before do  #ユーザAでログインする
        #ログイン画面にアクセス
        visit login_path
        #メールアドレスを入力
        fill_in 'session_email', with: 'a@example.com'
        #password入力
        fill_in 'session_password', with: 'password'
        #ログインする
        click_button 'ログイン'
      end

      it 'ユーザAが作成したタスクが表示される' do
       #作成済みのタスクの名称が画面上に表示されているいこと
       # page(画面)に期待する, 最初のタスクという内容が
       # have_content は　matcherと呼ばれる
       expect(page).to have_content '最初のタスク'
      end
    end


  end
end