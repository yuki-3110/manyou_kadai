require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', deadline: '2022-07-06', status: '未着手', priority: '高')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'テスト', content: '', deadline: '2022-07-06', status: '未着手', priority: '高')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', deadline: '2022-07-06', status: '未着手', priority: '高')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) {FactoryBot.create(:task, title: 'task') }
    let!(:second_task) {FactoryBot.create(:second_task, title: "sample")}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードが絞り込まれる' do
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do

      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        
      end
    end
  end
end