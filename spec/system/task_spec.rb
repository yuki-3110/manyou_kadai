require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user) }
  before do
    visit new_session_path
    fill_in 'session_email', with: 'test_user_01@test.com'
    fill_in 'session_password', with: '11111111'
    click_on 'log in' 
    click_on 'タスク一覧'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_link 'タスクを追加する'
        fill_in 'task_title',  with: 'task'
        fill_in 'task_content',  with: '買い物'
        fill_in 'task_deadline',  with: '002022-07-14'
        # select "未着手", from: "task_status"
        # select "高", from: "task_priority"
        find("#task_status").find("option[value='not_yet']").select_option
        find("#task_priority").find("option[value='high']").select_option
        click_button '登録する'
        click_button '登録する'
        expect(page).to have_content 'task'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
  end

  describe '詳細表示機能' do
    let!(:task) { FactoryBot.create(:task, user: user) }
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        click_on '詳細'
        expect(page).to have_content 'task1'
      end
    end
  end
  
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        fill_in 'task_title',  with: 'task'
        click_button '検索'
        expect(page).to have_content 'task1'
      end
    end

    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        find("#task_status").find("option[value='not_yet']").select_option
        click_button '検索'
        expect(page).to have_content 'task1'
      end
    end
    
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'task_title',  with: 'task'
        find("#task_status").find("option[value='not_yet']").select_option
        click_button '検索'
        expect(page).to have_content 'task1'
      end
    end
  end
end