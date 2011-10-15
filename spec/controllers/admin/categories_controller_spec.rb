require 'spec_helper'

module Admin
  describe CategoriesController do

    before do
      @controller.stub(:requires_admin).and_return(true)
    end

    describe "GET #new" do
      it "assigns a new instance of category to categories" do
        category = mock_model(Category)
        Category.should_receive(:new).and_return(category)

        get :new
        assigns(:category).should == category
      end
    end

    describe "POST #create" do
      context "When valid" do

        before do
          @category = mock_model(Category, :name => "Food and Drink")
          Category.stub(:new) { @category }
          @category.stub(:save) { true }
        end

        it "creates a new instance of category with submitted attributes" do
          Category.should_receive(:new).with("name" => "Food and Drink").and_return(@category)

          post :create, :category => {:name => "Food and Drink"}
          assigns(:category).should == @category
        end

        it "saves the record" do
          @category.should_receive(:save)

          post :create, :category => {:name => "Food and Drink"}
        end

        it "sets flash thanking the admin" do
          post :create, :category => {:name => "Food and Drink"}
          flash[:notice].should == "Thank you for adding a new category!"
        end

        it "redirects to the particpants index page" do
          post :create, :category => {:name => "Food and Drink"}
          response.should redirect_to(admin_participants_path)
        end
      end

      context "Whan invalid" do

        it "renders the new page" do
          category = mock_model(Category, :save => false)
          Category.stub(:new).and_return(category)

          post :create
          response.should render_template(:new)
        end
      end

      describe "GET #edit"  do

        let(:category) { mock_model(Category, :id => 1, :name => "Category Name") }

        it "finds the category" do
          Category.should_receive(:find).with('1').and_return(category)

          get :edit, :id => 1
          assigns(:category).should == category
        end

        it "renders the edit form" do
          Category.stub(:find).with('1') { category }

          get :edit, :id => 1
          response.should render_template(:edit)
        end
      end
    end
  end
end
