require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title',  with: 'task'
        fill_in 'task_content',  with: '買い物'
        fill_in 'task_deadline',  with: '002022-07-06'
        find("#task_status").find("option[value='未着手']").select_option
        find("#task_priority").find("option[value='高']").select_option
        click_button '投稿する'
        click_button '投稿する'
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: '買い物', deadline: '2022-07-06', status: '未着手', priority: '高')
        
        visit tasks_path
        
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: '買い物', deadline: '2022-07-06', status: '未着手', priority: '高')

        visit tasks_path

        click_link '詳細'

        expect(page).to have_content 'task'
      end
    end
  end
end