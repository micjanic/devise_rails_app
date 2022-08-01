require 'rails_helper'

RSpec.describe "Posts", type: :request do
  current_user = User.first_or_create!(email: "mjanicki@sittercity.com", password: "password", password_confirmation: "password")

  let(:valid_attributes) do
    {
      'id' => '1',
      'title' => 'Test',
      'body' => '12345',
      'user' => current_user
    }
  end

  let(:invalid_attributes) do
    {
      'id' => 'a',
      'title' => '1',
      'body' => '1234',
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save
      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save
      get post_url(post)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_post_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save
      get edit_post_url(post)
      expect(response).to be_successful
    end
  end
  describe "POST /create" do
    context 'with valid parameters'do
      it 'creates a new Post' do
        expect do
          post = Post.new(valid_attributes)
          post.user = current_user
          post.save
          post posts_url, params: {post: valid_attributes}
        end.to change(Post, :count).by(1)
      end
    end
  end
end
