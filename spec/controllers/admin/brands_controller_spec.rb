require 'rails_helper'

describe Admin::BrandsController do
  let(:brand) { create(:brand) }
  let(:administrator) { create(:administrator, role: :normal) }

  before { sign_in administrator, scope: :admin_administrator }

  describe 'GET #index' do
    it '`ブランド`のデータを取得できること' do
      brands = []
      10.times { brands << create(:brand) }
      get :index
      expect(assigns(:brands)).to match_array(brands)
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #index pagination' do
    it 'ページングが正しく機能していること' do
      brands = []
      50.times { brands << create(:brand) }
      get :index
      expect(assigns(:brands).count).to eq(25)
      expect(assigns(:brands).next_page).to eq(2)

      get :index, { params: { page: 2 } }
      expect(assigns(:brands).count).to eq(25)
      expect(assigns(:brands).next_page).to eq(nil)
      expect(assigns(:brands).prev_page).to eq(1)
    end
  end

  describe 'GET #new' do
    it '@brandに空のデータが割り当てられていること' do
      get :new
      expect(assigns(:brand)).to be_a_new(Brand)
    end

    it ':new テンプレートを表示すること' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context '正常系' do
      it 'ブランドが正しく登録されていること' do
        expect { post :create, params: { brand: attributes_for(:brand) } }
            .to change(Brand, :count).by(1)
      end

      it 'admin/brands#indexにリダイレクトすること' do
        post :create, params: { brand: attributes_for(:brand) }
        expect(response).to redirect_to admin_brands_path
      end
    end

    context '異常系' do
      it 'バリデーションエラーでデータベースに保存されないこと' do
        expect { post :create, params: { brand: attributes_for(:brand, name: nil) } }
            .not_to change(Brand, :count)
      end

      it 'newテンプレートを表示すること' do
        post :create, params: { brand: attributes_for(:brand, name: nil) }
        expect(response).to render_template :new
      end
    end
  end
end
