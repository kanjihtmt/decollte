require 'rails_helper'

describe Admin::ShopsController do
  let(:shop) { create(:shop) }
  let(:administrator) { create(:administrator) }

  before { sign_in administrator, scope: :admin_administrator }

  describe 'GET #index' do
    it '店舗データを取得していること' do
      shops = []
      10.times { shops << create(:shop) }
      get :index
      expect(assigns(:shops)).to match_array(shops)
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #index pagination' do
    it 'ページングが正しく機能していること' do
      shops = []
      50.times { shops << create(:shop) }
      get :index
      expect(assigns(:shops).count).to eq(25)
      expect(assigns(:shops).next_page).to eq(2)

      get :index, { params: { page: 2 }}
      expect(assigns(:shops).count).to eq(25)
      expect(assigns(:shops).next_page).to eq(nil)
      expect(assigns(:shops).prev_page).to eq(1)
    end
  end

  describe 'GET #new' do
    it '@shopに空のデータが割り当てられていること' do
      get :new
      expect(assigns(:shop)).to be_a_new(Shop)
    end

    it ':new テンプレートを表示すること' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context '正常系' do
      it 'Shopが正しく登録されていること' do
        shop = build(:shop)
        expect { post :create, params: { shop: shop.attributes } }
            .to change(Shop, :count).by(1)
      end

      it 'admin/shops#indexにリダイレクトすること' do
        shop = build(:shop)
        post :create, params: { shop: shop.attributes }
        expect(response).to redirect_to admin_shops_path
      end
    end

    context '異常系' do
      it 'バリデーションエラーでデータベースに保存されないこと' do
        expect { post :create, params: { shop: attributes_for(:shop, name: nil) } }
            .not_to change(Shop, :count)
      end

      it 'newテンプレートを表示すること' do
        post :create, params: { shop: attributes_for(:shop, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it '@shopに指定されたデータが割り当てられていること' do
      get :edit, params: { id: shop }
      expect(assigns(:shop)).to eq shop
    end

    it ':editテンプレートを表示すること' do
      get :edit, params: { id: shop }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context '正常系' do
      it '指定した@shopを取得すること' do
        patch :update, params: { id: shop, shop: attributes_for(:shop) }
        expect(assigns(:shop)).to eq(shop)
      end

      it '登録内容が変更されていること' do
        patch :update, params: { id: shop, shop: attributes_for(:shop, name: '店舗1') }
        shop.reload
        expect(shop.name).to eq('店舗1')
      end

      it 'admin/shops#indexページへリダイレクトされること' do
        patch :update, params: { id: shop, shop: attributes_for(:shop) }
        expect(response).to redirect_to admin_shops_path
      end
    end

    context '異常系' do
      it 'バリデーションエラーでデータベースに保存されないこと' do
        before_save_shop = shop
        patch :update, params: { id: shop, shop: attributes_for(:shop, name: nil) }
        shop.reload
        expect(shop.name).to eq(before_save_shop.name)
      end

      it 'editテンプレートを表示すること' do
        patch :update, params: { id: shop, shop: attributes_for(:shop, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it '指定した店舗が削除されること' do
      shop = create(:shop)
      expect { delete :destroy, params: { id: shop } }.to change(Shop, :count).by(-1)
    end

    it 'shops#indexページへリダイレクトすること' do
      delete :destroy, params: { id: shop }
      expect(response).to redirect_to admin_shops_url
    end
  end
end