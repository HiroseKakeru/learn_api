require 'rails_helper'

describe 'ItemAPI' do
  it '全てのポストを取得する' do
    FactoryBot.create_list(:item, 10)

    get '/api/v1/items'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 正しい数のデータが返されたか確認する。
    expect(json['data'].length).to eq(10)
  end

  it '特定のitemを取得する' do
    item = create(:item, name: 'test-name')

    get "/api/v1/items/#{item.id}"
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 要求した特定のポストのみ取得した事を確認する
    expect(json['data']['name']).to eq(item.name)
  end

  it '新しいitemを作成する' do
    valid_params = { name: 'name' }

    #データが作成されている事を確認
    expect { post '/api/v1/items', params: { item: valid_params } }.to change(Item, :count).by(+1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end

  it 'itemの編集を行う' do
    item = create(:item, name: 'old-name')

    put "/api/v1/items/#{item.id}", params: { item: {name: 'new-name'}  }
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    #データが更新されている事を確認
    expect(json['data']['name']).to eq('new-name')
  end

  it 'itemを削除する' do
    item = create(:item)

    #データが削除されている事を確認
    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end
end
