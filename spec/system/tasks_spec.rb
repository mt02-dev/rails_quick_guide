require 'rails_helper'

describe 'タスク管理機能', type: :system do
  #ユーザを作成しておく
  let(:user_a) { FactoryBot.create(:user, name:"ユーザーA", email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name:"ユーザーB", email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) } 

  before do  #ユーザAでログインする
    #作成者がユーザAであるタスクを作成しておく
    #ログイン画面にアクセス
    visit login_path
    #メールアドレスを入力
    fill_in 'session_email', with: login_user.email
    #password入力
    fill_in 'session_password', with: login_user.password
    #ログインする
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    #作成済みのタスクの名称が画面上に表示されているいこと
    # page(画面)に期待する, 最初のタスクという内容が, have_contentはmatcherと呼ばれる
    it { expect(page).to have_content '最初のタスク' }
  end
  
  describe '一覧表示機能' do
    
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end

    context 'ユーザBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end

    end

  end

  describe '詳細表示機能' do
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a }
      
      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end


  end

  describe '新規作成機能' do
    let(:login_user) { user_a }
    let(:task_name) { '新規作成のテストを書く' } #デフォルトとして設定する

    before do
      visit new_task_path
      fill_in '名前', with: task_name
      click_button '登録する'
    end

    context '新規作成で名称を入力した時' do
      it '正常に登録される' do
        # HTML内の特定の要素セレクタ(CSSセレクタ)を指定することができる
        # 今回は作成成功時のフラッシュの内容
        expect(page).to have_selector '.alert-primary', text: '新規作成のテストを書く'
      end
    end

    context '新規作成で名称を入力していない場合' do
      let(:task_name) { '' } #デフォルトを上書き

      it 'エラーになる' do
        # withinで検証範囲を限定する
        # ”#error_explanation"というid要素を探す
        within '#error_explanation' do
          expect(page).to have_content '名前を入力してください'
        end
      end
    end
  end
  
end