require 'rails_helper'

describe Admin::ShopsController do
  let(:brand) { create(:brand) }
  let(:shop) { create(:shop, brand: brand) }
  let(:administrator) { create(:administrator) }
  let(:normal_administrator) { create(:administrator, role: :normal) }

  describe 'Admin' do
    before { sign_in administrator, scope: :admin_administrator }

    describe 'GET #index' do
      it '店舗データを取得していること' do
        shops = []
        10.times { shops << create(:shop, brand: brand) }
        get :index, params: { brand_id: brand.id }
        expect(assigns(:shops)).to match_array(shops)
      end

      it 'indexテンプレートを表示すること' do
        get :index, params: { brand_id: brand.id }
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      it '@shopに空のデータが割り当てられていること' do
        get :new, params: { brand_id: brand.id }
        expect(assigns(:shop)).to be_a_new(Shop)
      end

      it ':new テンプレートを表示すること' do
        get :new, params: { brand_id: brand.id }
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context '正常系' do
        it 'Shopが正しく登録されていること' do
          shop = build(:shop, brand: brand)
          expect { post :create, params: { brand_id: brand.id, shop: shop.attributes } }
              .to change(Shop, :count).by(1)
        end

        it 'admin/shops#indexにリダイレクトすること' do
          shop = build(:shop, brand: brand)
          post :create, params: { brand_id: brand.id, shop: shop.attributes }
          expect(response).to redirect_to admin_brand_shops_path(brand)
        end
      end

      context '異常系' do
        it 'バリデーションエラーでデータベースに保存されないこと' do
          expect { post :create, params: { brand_id: brand.id, shop: attributes_for(:shop, name: nil) } }
              .not_to change(Shop, :count)
        end

        it 'newテンプレートを表示すること' do
          post :create, params: { brand_id: brand.id, shop: attributes_for(:shop, name: nil) }
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      it '@shopに指定されたデータが割り当てられていること' do
        get :edit, params: { brand_id: brand.id, id: shop }
        expect(assigns(:shop)).to eq shop
      end

      it ':editテンプレートを表示すること' do
        get :edit, params: { brand_id: brand.id, id: shop }
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context '正常系' do
        it '指定した@shopを取得すること' do
          patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop) }
          expect(assigns(:shop)).to eq(shop)
        end

        it '登録内容が変更されていること' do
          patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop, name: '店舗1') }
          shop.reload
          expect(shop.name).to eq('店舗1')
        end

        it 'admin/shops#indexページへリダイレクトされること' do
          patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop) }
          expect(response).to redirect_to admin_brand_shops_path(brand)
        end
      end

      context '異常系' do
        it 'バリデーションエラーでデータベースに保存されないこと' do
          before_save_shop = shop
          patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop, name: nil) }
          shop.reload
          expect(shop.name).to eq(before_save_shop.name)
        end

        it 'editテンプレートを表示すること' do
          patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop, name: nil) }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it '指定した店舗が削除されること' do
        shop = create(:shop, brand: brand)
        expect { delete :destroy, params: { brand_id: brand.id, id: shop } }.to change(Shop, :count).by(-1)
      end

      it 'shops#indexページへリダイレクトすること' do
        delete :destroy, params: { brand_id: brand.id, id: shop }
        expect(response).to redirect_to admin_brand_shops_path(brand)
      end
    end
  end

  describe 'Authorization' do
    before do
      sign_in normal_administrator, scope: :admin_administrator
    end

    it '一般管理者は店舗一覧を表示可能であること' do
      get :index, params: { brand_id: brand.id }
      expect(response).to render_template :index
    end

    it '一般管理者は店舗の新規登録画面が表示できないこと' do
      get :new, params: { brand_id: brand.id }
      expect(response).to redirect_to admin_root_path
    end

    it '一般管理者は店舗の編集画面が表示できないこと' do
      get :edit, params: { brand_id: brand.id, id: shop }
      expect(response).to redirect_to admin_root_path
    end

    it '一般管理者は店舗の登録ができないこと' do
      shop = build(:shop, brand: brand)
      post :create, params: { brand_id: brand.id, shop: shop.attributes }
      expect(response).to redirect_to admin_root_path
    end

    it '一般管理者は店舗の編集ができないこと' do
      patch :update, params: { brand_id: brand.id, id: shop, shop: attributes_for(:shop) }
      expect(response).to redirect_to admin_root_path
    end

    it '一般管理者は店舗の削除ができないこと' do
      delete :destroy, params: { brand_id: brand.id, id: shop }
      expect(response).to redirect_to admin_root_path
    end
  end
end
