require 'rails_helper'

describe Admin::BrandsController do
  let(:brand) { create(:brand) }
  let(:administrator) { create(:administrator) }

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
    it '@brandに空の`お医者さん`を割り当てること' do
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
      it 'Brandが正しく登録されていること' do
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

  describe 'GET #edit' do
    it '@brandに指定されたブランドが割り当てるられていること' do
      get :edit, params: { id: brand }
      expect(assigns(:brand)).to eq brand
    end

    it ':editテンプレートを表示すること' do
      get :edit, params: { id: brand }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context '正常系' do
      it '指定した@brandを取得すること' do
        patch :update, params: { id: brand, brand: attributes_for(:brand) }
        expect(assigns(:brand)).to eq(brand)
      end

      it '登録内容が変更されていること' do
        patch :update, params: { id: brand, brand: attributes_for(:brand, name: 'testbrand') }
        brand.reload
        expect(brand.name).to eq('testbrand')
      end

      it 'admin/brands#indexページへリダイレクトされること' do
        patch :update, params: { id: brand, brand: attributes_for(:brand) }
        expect(response).to redirect_to admin_brands_url
      end
    end

    context '異常系' do
      it 'バリデーションエラーでデータベースに保存されないこと' do
        before_save_brand = brand
        patch :update, params: { id: brand, brand: attributes_for(:brand, name: nil) }
        brand.reload
        expect(brand.name).to eq(before_save_brand.name)
      end

      it 'editテンプレートを表示すること' do
        patch :update, params: { id: brand, brand: attributes_for(:brand, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end
end
