require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:tpost) { create(:post) }

  describe 'GET #index' do
    let(:posts) { create_list(:post, 2) }

    before { get :index }

    it 'populates an array of all posts' do
      expect(assigns(:posts)).to match_array(posts)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do 
    before { get :show, id: tpost }

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq tpost
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    login_user

    before { get :new }

    it 'assigns a new Post to the @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do 
    before { get :edit, id: tpost }

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq tpost
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    login_user
    
    context 'with valid attributes' do
      it 'saves a new post in the database' do
        expect { post :create, post: attributes_for(:post) }
          .to change(Post, :count).by(1)
      end

      it 'redirects to the show view' do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to post_path(assigns(:post))
      end
    end

    context 'with invalid attributes' do
      it 'does not save a new post in the database' do
        expect { post :create, post: attributes_for(:invalid_post) }
          .to_not change(Post, :count)
      end

      it 're-renders new view' do
        post :create, post: attributes_for(:invalid_post)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested post to @post' do
        patch :update, id: tpost, post: attributes_for(:post)
        expect(assigns(:post)).to eq tpost
      end

      it 'changes post attributes' do
        patch :update, id: tpost, post: { title: 'New title', body: 'New body'}
        tpost.reload
        expect(tpost.title).to eq 'New title'
        expect(tpost.body).to eq 'New body'
      end

      it 'redirects to the updated post' do
        patch :update, id: tpost, post: attributes_for(:post)
        expect(response).to redirect_to tpost
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: tpost, post: { title: 'New', body: nil} }

      it 'does not change post attributes' do
        tpost.reload
        expect(tpost.title).to eq 'Test title'
        expect(tpost.body).to eq 'Test body'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { tpost }

    it 'deletes post' do
      expect { delete :destroy, id: tpost }.to change(Post, :count).by(-1)
    end

    it 'redirects to the index view' do
      delete :destroy, id: tpost
      expect(response).to redirect_to posts_path
    end
  end
end
