require 'rails_helper'

RSpec.describe 'ユーザー登録・セッション機能・管理画面のテスト', type: :system do
  describe 'ユーザーの登録機能のテスト' do
    context 'ユーザーが登録がなく、ログインしていない場合' do
      it 'ユーザーが新規登録をすれば、詳細画面に移動する' do
        visit new_user_path
        fill_in 'user_name', with: 'test_user_01'
        fill_in 'user_email', with: 'test_user_01@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'アカウント登録'
        expect(page).to have_content 'test_user_01'
      end
      
      it '​ログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end 
    end
  end

  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @user_second = FactoryBot.create(:user_second)
    end
    context 'アカウント登録済みで、ログインしていない場合' do
      it 'ログイン画面からログインできること' do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'log in'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end

    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'log in'        
      end

      it '自分の詳細画面に飛べること' do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end 
    
      it '一般ユーザーが他人の詳細画面に飛ぶと、タスク一覧画面に遷移すること' do
        visit user_path(id: @user_second.id)
        expect(current_path).to eq tasks_path
      end

      it 'ログアウトができる' do
        visit user_path(id: @user.id)
        click_on 'Logout'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者ユーザーのアカウントがある場合' do
      before do
        @user_second = FactoryBot.create(:user_second)
        visit new_session_path
        fill_in 'session_email', with: @user_second.email
        fill_in 'session_password', with: @user_second.password
        click_on 'log in'        
      end

      it '管理者ユーザーは管理画面にアクセスできること' do
        click_on '管理者用ユーザー一覧'
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザーがログインしている場合' do
      before do
        @user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'log in' 
      end

      it '管理画面へのアクセスが制限されること' do
        visit user_path(id: @user.id)
        click_on '管理者用ユーザー一覧'
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

    context '管理者がログインしている場合' do
      before do
        @user = FactoryBot.create(:user)
        @user_second = FactoryBot.create(:user_second)
        visit new_session_path
        fill_in 'session_email', with: @user_second.email
        fill_in 'session_password', with: @user_second.password
        click_on 'log in' 
        click_on '管理者用ユーザー一覧'
      end

      it '管理ユーザはユーザの新規登録ができること' do
        click_link '新たにユーザーを登録する'
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test_user@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'アカウント登録'
        expect(page).to have_content 'test_user'
      end

      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        click_on '詳細', match: :first
        expect(page).to have_content 'test_user_01'
      end

      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        click_on '編集', match: :first
        fill_in 'user_name', with: 'edit_test_user_01'
        click_on '編集'
        expect(page).to have_content 'edit_test_user_01'
      end

      it '管理ユーザはユーザの削除をできること' do
        page.accept_confirm do
          click_on '削除', match: :first
        end
        expect(page).to have_no_content 'edit_test_user_01'
      end   
    end
  end
end




