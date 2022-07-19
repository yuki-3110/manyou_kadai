require 'rails_helper'

RSpec.describe 'ラベル機能のテスト', type: :system do
  let!(:user){ FactoryBot.create(:user) }
  before do
    visit new_session_path
    fill_in 'session_email', with: 'test_user_01@test.com'
    fill_in 'session_password', with: '11111111'
    click_on 'log in' 
  end

  describe '新規作成機能' do
    context 'タスク投稿時にラベルを登録した場合' do
      let!(:label){ FactoryBot.create(:label) }
      let!(:label_second){ FactoryBot.create(:label_second) }
      let!(:label_third){ FactoryBot.create(:label_third) }
      it 'タスク一覧にラベルが表示される' do
        visit tasks_path
        click_link 'タスクを追加する'
        fill_in 'task_title',  with: 'task'
        fill_in 'task_content',  with: '買い物'
        fill_in 'task_deadline',  with: '002022-07-14'
        find("#task_status").find("option[value='not_yet']").select_option
        find("#task_priority").find("option[value='high']").select_option
        check '勉強'
        check '家事'
        click_button '登録する'
        click_button '登録する'
        expect(page).to have_content '勉強'
        expect(page).to have_content '家事'
      end
    end

    context 'タスク一覧よりラベルの登録内容を編集した場合' do
      let!(:task) { FactoryBot.create(:task, user: user) }
      let!(:label){ FactoryBot.create(:label) }
      let!(:label_third){ FactoryBot.create(:label_third) }
      it '編集後の内容がタスク一覧に表示される' do
        visit tasks_path
        click_on '編集', match: :first
        check '遊び'
        click_button '登録する'
        expect(page).to have_content '遊び'
      end
    end

    context 'タスク一覧でラベル検索をした場合' do
      let!(:task){ FactoryBot.create(:task, user: user) }
      let!(:label){ FactoryBot.create(:label) }
      let!(:label_third){ FactoryBot.create(:label_third) }
      it '選択したラベルのタスクのみが表示される' do
        visit tasks_path
        select "家事", from: "task_label_id"
        click_button '検索'
        expect(page).to have_content 'task1'
      end
    end
  end
end 