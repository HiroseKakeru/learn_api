# Rails apiモードとrspecの勉強

## Railsアプリの作成
- rails newのオプションでapi
    ```
    $ rails new learn_api --api -T
    ```

## modelとcontrollerの作成
    ```
    $ rails generate model item name:string
    $ rails generate controller items
    $ rails db:migrate
    ```

## ルーティングを設定
- <code>https://github.com/HiroseKakeru/learn_api/blob/master/config/routes.rb</code>
- rails routesで確認
    ```
    api_v1_items   GET    /api/v1/items(.:format)      api/v1/items#index
                  POST    /api/v1/items(.:format)      api/v1/items#create
    api_v1_item    GET    /api/v1/items/:id(.:format)  api/v1/items#show
                 PATCH    /api/v1/items/:id(.:format)  api/v1/items#update
                   PUT    /api/v1/items/:id(.:format)  api/v1/items#update
                DELETE    /api/v1/items/:id(.:format)  api/v1/items#destroy
    ```

## コントローラの設定
- routes.rbで設定した名前空間に合わせたディレクトリ構成にする
    - app/controllers/api/v1/items_controller.rb

- コントローラにCRUDのactionを追加
    <code>https://github.com/HiroseKakeru/learn_api/blob/master/app/controllers/api/v1/items_controller.rb</code>

## APIをrspecでテストする
- Gemfileに追加
    ```ruby
    group :development, :test do
      gem 'factory_bot_rails'
      gem 'rspec-rails'
    end
    ```
    ```
    $ bundle install
    ```
- Rspecの初期設定
    ```
    $ rails generate rspec:install
    ```
- factory_botのメソッドを使えるようにする
    - spec/rails_helper.rb
        ```ruby
        ...
        RSpec.configure do |config|
        ...
        # factory_botのmethodを適用
        config.include FactoryBot::Syntax::Methods
        ...
        end
        ```
- テストコードを書く
    <code>https://github.com/HiroseKakeru/learn_api/blob/master/spec/requests/api/v1/items_spec.rb</code>
- テストを実行
    ```
    $ rspec
    ```
    - 緑になればOK
