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
        it "creates a new instance of category with submitted attributes"
        it "saves the record"
        it "sets flash thanking the admin"
        it "redirects to the particpants index page"
      end
      context "Whan invalid" do
        it "renders the new page"
      end
    end
  end
end
