require 'rails_helper'

RSpec.describe AlbumController, :type => :controller do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    @different_user = FactoryGirl.create(:user)
    @different_user.confirm!
    @travel = FactoryGirl.create(:travel, user: @user)
    FactoryGirl.create(:album, travel: @travel)
  end

  describe "#index" do
    it "show all data when user don't logged in" do
      albums = Album.all
      get :index
      expect(assigns(:albums)).to match_array albums
    end
    it "show all data when user logged in" do
      sign_in :user, @user
      albums = Album.all
      get :index
      expect(assigns(:albums)).to match_array albums
    end
  end

  describe "#show" do
    it "assigns the requested album as @album" do
      album = Album.first
      get :show, {:id => album.id}
      expect(assigns(:album)).to eq album
    end
  end

  describe "#new" do
    it "access to new, does not work without a signed in user" do
      sign_out :user
      travel = Travel.first
      get :new, {travel_id: travel.id}
      response.should redirect_to(new_user_session_path)
    end
    it "assigns as new travel as @travel when sign in" do
      sign_in :user, @user
      travel = Travel.first
      get :new, {travel_id: travel.id}
      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "#edit" do
    it "access to edit, does not work without a signed in user" do
      sign_out :user
      album = @user.travels.first.albums.first
      get :edit,{ :id => album.id }
      response.should redirect_to(new_user_session_path)
    end

    it "assign as edit travel as @album when sign in" do
      sign_in :user, @different_user
      album = @user.travels.first.albums.first
      get :edit ,{:id => album.id}
      response.should redirect_to(album)
    end
  end


  before(:each) do
    @album_params = {title: "タイトル",travel_id: Travel.first }
  end

  describe "#POST create" do
    describe "without login" do
      it "should be redirect to login page" do
        sign_out :user
        post :create
        response.should redirect_to(new_user_session_path)
      end
    end
    describe "with login" do
      it " create new Album" do
        sign_in :user,@user
        expect {
          post :create,album_params: @album_params
        }.to change(Album, :count).by(1)
      end

      it "create new travel s @travel" do
        sign_in :user,@user
        post :create, album_params: @album_params
        expect(assigns(:album)).to be_a(Album)
      end

      it "dosen't create new album with invaild params" do
        sign_in :user,@user
        Album.any_instance.stub(:save).and_return(false)
        post :create, :album_params => @album_params
        expect(assigns(:album)).to be_a_new(Album)
      end

      it "doesn't create new album with invaild params" do
        sign_in :user,@user
        Album.any_instance.stub(:save).and_return(false)
        post :create,:album_params => @album_params
        expect(response).to render_template("new")
      end
    end

    describe "#POST update" do
      describe "without login" do
        it "should be redirect to login page" do
          sign_out :user
          album = @user.travels.first.albums.first
          post :update,{id: album.id}
          response.should redirect_to(new_user_session_path)
        end
      end

      describe "another user" do
        it "should be redirect to another page" do
          sign_in :user,@different_user
          album = @user.travels.first.albums.first
          post :update,{id: album.id, album_params: @album_params}
          response.should redirect_to(album)
        end
      end

      describe "with vaild params" do
        it "asigns the requested travel as @album" do
          sign_in :user,@user
          album = @user.travels.first.albums.first
          post :update, {id: album.id, album_params: @album_params}
          assigns(:album).should eq(album)
        end

        it "redirects to the album" do
          sign_in :user,@user
          album = @user.travels.first.albums.first
          put :update, {id: album.id, album_params: @album_params}
          response.should redirect_to(album)
        end
      end

      describe "with invalid params" do
        it "assings the travel as @album" do
          sign_in :user,@user
          album = @user.travels.first.albums.first
          Album.any_instance.stub(:save).and_return(false)
          put :update, {id: album.id, album_params: @album_params}
          expect(assigns(:album)).to eq album

        end

        it "re-renders the 'edit' template" do
          sign_in :user,@user
          album = @user.travels.first.albums.first
          Album.any_instance.stub(:save).and_return(false)
          put :update, {id: album.id,album_params: @album_params}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      describe "without login" do
        it "should be redirect to login page" do
          sign_out :user
          album = @user.travels.first.albums.first
          delete :update,{id: album.id}
          response.should redirect_to(new_user_session_path)
        end
      end

      describe "another user" do
        it "should be redirect to another page" do
          sign_in :user, @different_user
          album = @user.travels.first.albums.first
          delete :update,  {id: album.id,album_params: @album_params}
          response.should redirect_to(album)
        end
      end

      it "destroys the requested Album" do
        sign_in :user,@user
        album = @user.travels.first.albums.first
        expect {
          delete :destroy, {id: album.id}
        }.to change(Album, :count).by(-1)
      end

      it "redirects to the albums list" do
        sign_in :user,@user
        album = FactoryGirl.create(:album)
        delete :destroy, {id: album.id}
        response.should redirect_to(album_url)
      end
    end
  end
end
