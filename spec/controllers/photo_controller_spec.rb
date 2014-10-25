require 'rails_helper'

RSpec.describe PhotoController, :type => :controller do

  before(:all) do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    @different_user = FactoryGirl.create(:user)
    @different_user.confirm!
    @travel = FactoryGirl.create(:travel, :user => @user)
    @album = FactoryGirl.create(:album,travel: @travel)
    FactoryGirl.create(:photo, album: @album)
  end

  describe "#index" do
    it "show all data when user don't logged in" do
      photos = Photo.all
      get :index
      expect(assigns(:photos)).to match_array photos
    end
    it "show all data when user logged in" do
      sign_in :user, @user
      photos = Photo.all
      get :index
      expect(assigns(:photos)).to match_array photos
    end
  end

  describe "#show" do
    it "assigns the requested photo as @photo" do
      photo = Photo.first
      get :show, {:id => photo.id}
      expect(assigns(:photo)).to eq photo
    end
  end

  describe "#new" do
    it "access to new, does not work without a signed in user" do
      sign_out :user
      get :new
      response.should redirect_to(new_user_session_path)
    end
    it "assigns as new travel as @travel when sign in" do
      sign_in :user, @user
      get :new
      expect(assigns(:photo)).to be_a_new(Photo)
    end
  end


  before(:each) do
    @photo_params = { user_id: @user.id, album_id: @album.id, image: fixture_file_upload("/rails.png",'image/png') , comment:"コメント"}
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
      it " create new Photo" do
        sign_in :user,@user
        expect {
          post :create, photo: @photo_params
        }.to change(Photo, :count).by(1)
      end

      it "create new photos @photos" do
        sign_in :user,@user
        post :create, photo: @photo_params
        expect(assigns(:photo)).to be_a(Photo)
      end

      it "dosen't create new photo with invaild params" do
        sign_in :user,@user
        Photo.any_instance.stub(:save).and_return(false)
        post :create, photo: @photo_params
        expect(assigns(:photo)).to be_a_new(Photo)
      end

      it "doesn't create new photo with invaild params" do
        sign_in :user,@user
        Photo.any_instance.stub(:save).and_return(false)
        post :create, photo: @photo_params
        expect(response).to render_template("new")
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested Photo" do
        sign_in :user,@user
        photo = @user.travels.first.albums.first.photos.first
        expect {
          delete :destroy, {id: photo.id}
        }.to change(Photo, :count).by(-1)
      end

      it "redirects to the photos list" do
        sign_in :user,@user
        photo = FactoryGirl.create(:photo)
        delete :destroy, {id: photo.id}
        response.should redirect_to(photo_url)
      end
    end
  end
end
