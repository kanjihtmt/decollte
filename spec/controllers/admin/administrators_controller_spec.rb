require 'rails_helper'

describe Admin::AdministratorsController do
  let(:administrator) { create(:administrator) }
  let(:normal_admininistrator) { create(:administrator, role: :normal) }

  before { sign_in administrator, scope: :admin_administrator }

  describe 'GET #index' do
    it '管理者のデータを取得できること' do
      administrators = []
      10.times { administrators << create(:administrator) }
      get :index
      expect(assigns(:administrators)).to match_array([administrator] + administrators)
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it '@administratorに空のデータが割り当てられていること' do
      get :new
      expect(assigns(:administrator)).to be_a_new(Administrator)
    end

    it ':new テンプレートを表示すること' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context '正常系' do
      it '管理者が正しく登録されていること' do
        expect { post :create, params: { administrator: attributes_for(:administrator) } }
            .to change(Administrator, :count).by(1)
      end

      it 'admin/brands#indexにリダイレクトすること' do
        post :create, params: { administrator: attributes_for(:administrator) }
        expect(response).to redirect_to admin_administrators_path
      end
    end

    context '異常系' do
      it 'バリデーションエラーでデータベースに保存されないこと' do
        expect { post :create, params: { administrator: attributes_for(:administrator, username: nil) } }
            .not_to change(Administrator, :count)
      end

      it 'newテンプレートを表示すること' do
        post :create, params: { administrator: attributes_for(:administrator, username: nil) }
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it '@administratorに指定された管理者が割り当てるられていること' do
        administrator = create(:administrator)
        get :edit, params: { id: administrator }
        expect(assigns(:administrator)).to eq administrator
      end

      it ':editテンプレートを表示すること' do
        administrator = create(:administrator)
        get :edit, params: { id: administrator }
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context '正常系' do
        it '指定した@administratorを取得すること' do
          patch :update, params: { id: administrator, administrator: attributes_for(:administrator) }
          expect(assigns(:administrator)).to eq(administrator)
        end

        it '登録内容が変更されていること' do
          patch :update, params: { id: administrator, administrator: attributes_for(:administrator, username: 'testuser') }
          administrator.reload
          expect(administrator.username).to eq('testuser')
        end

        it 'admin/administrators#indexページへリダイレクトされること' do
          patch :update, params: { id: administrator, administrator: attributes_for(:administrator) }
          expect(response).to redirect_to admin_administrators_path
        end
      end

      context '異常系' do
        it 'バリデーションエラーでデータベースに保存されないこと' do
          before_save_administrator = administrator
          patch :update, params: { id: administrator, administrator: attributes_for(:administrator, username: nil) }
          administrator.reload
          expect(administrator.username).to eq(before_save_administrator.username)
        end

        it 'editテンプレートを表示すること' do
          patch :update, params: { id: administrator, administrator: attributes_for(:administrator, username: nil) }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it '指定した店舗が削除されること' do
        administrator = create(:administrator)
        expect { delete :destroy, params: { id: administrator } }.to change(Administrator, :count).by(-1)
      end

      it 'shops#indexページへリダイレクトすること' do
        delete :destroy, params: { id: administrator }
        expect(response).to redirect_to admin_administrators_path
      end
    end
  end

  describe 'Authorization' do
    before do
      sign_out administrator
      sign_in normal_admininistrator, scope: :admin_administrator
    end

    it '一般管理者は管理ユーザ一覧を閲覧できないこと' do
      expect do
        get :index
      end.to raise_error Pundit::NotAuthorizedError
    end

    it '一般管理者は管理ユーザ作成画面を表示できないこと' do
      expect do
        get :new
      end.to raise_error Pundit::NotAuthorizedError
    end

    it '一般管理者は管理ユーザ編集画面を表示できないこと' do
      expect do
        get :edit, params: { id: administrator }
      end.to raise_error Pundit::NotAuthorizedError
    end

    it '一般管理者は管理ユーザを編集できないこと' do
      expect do
        patch :update, params: { id: administrator, administrator: attributes_for(:administrator) }
      end.to raise_error Pundit::NotAuthorizedError
    end

    it '一般管理者は管理ユーザを作成できないこと' do
      expect do
        post :create, params: { administrator: attributes_for(:administrator) }
      end.to raise_error Pundit::NotAuthorizedError
    end

    it '一般管理者は管理ユーザを削除できないこと' do
      expect do
        delete :destroy, params: { id: administrator }
      end.to raise_error Pundit::NotAuthorizedError
    end
  end
end
