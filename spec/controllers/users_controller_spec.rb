require 'rails_helper'
require_relative '../../app/models/user.rb'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dashboard REDIRECT" do
    it "returns http success" do
      get :dashboard
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #dashboard" do
    it "returns http success" do

      get :dashboard, params: { id: 1 , email:'testemail@gmail.com'}

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login_post' do
    it 'returns http success' do
      post :login_user
      expect(response).to have_http_status(:success)
    end

    it 'ensure login fail flash messages' do
      post :login_user
      expect(flash[:errors]).to eq('Email Not Found')
    end

    it 'Ensure Login With User registered' do
      params = {
          email: 'danwillscott@gmail.com',
          password: '7599black'
      }
      @pass  = {first_name: 'Daniel', last_name: 'Scott', email: 'danwillscott@gmail.com',
                password: '7599black', password_confirmation: '7599black' }
      User.create(@pass)
      post :login_user, params: {
            email: 'danwillscott@gmail.com',
            password: '7599black'
      }

      expect(session).to have_key(:id)
      expect(session[:truth]).to be_truthy
      expect(session[:first_name]).to eq('Daniel')
      expect(session[:last_name]).to eq('Scott')
      expect(session[:email]).to eq('danwillscott@gmail.com')
      expect(session[:id]).to be_a_kind_of(Integer)
    end
  end

  describe '' do

  end
end
