require File.dirname(__FILE__) + '/../spec_helper'

describe Event do

  context "has getters and setters for club- and standard price" do
    before (:each) do
      @event = FactoryGirl.build(:event)
    end
    it "sets the club price through an Item" do
      @event.club_price = 10
      @event.items.length.should == 2
      @event.items.select{ |i| i.name == Event::PRICE_TYPES[:club]}[0].price.should == 10
    end

    it "sets the standard price through an Item" do
      @event.standard_price = 15
      @event.items.length.should == 2
      @event.items.select{ |i| i.name == Event::PRICE_TYPES[:standard]}[0].price.should == 15
    end

    it "provides the standard price Item" do
      item = @event.standard_price_item
      item.name.should == Event::PRICE_TYPES[:standard]
      item.price.should == 0
    end

    it "provides the club price Item" do
      item = @event.club_price_item
      item.name.should == Event::PRICE_TYPES[:club]
      item.price.should == 0
    end
  end

  it "returns club price when registered member is logged in" do
    @event.club_price, @event.standard_price = 20.00, 30.00
    current_user = FactoryGirl.create(:active_user)
    @event.get_price(current_user).should == 20.00
  end

  it "returns standard price when user is not logged in" do
    @event.club_price, @event.standard_price = 20.00, 30.00
    @event.get_price(nil).should == 30.00
  end

  context "Event scope :with_sponsor" do
    it "Filters Events creating an array with only sponsored events" do
      Event.create([
        {:name => "Test",  :sponsored => true},
        {:name => "Test2", :sponsored => true},
        {:name => "Test3", :sponsored => false}])
      events = Event.with_sponsor
      events.length.should == 2
    end
  end

  describe "Event RSVP"
    before :each do
      @event = FactoryGirl.build(:event)
    end
    describe "Event#member_rsvp?" do
      it "Returns true if the member price is set to either 0 or nil" do
        @event.member_rsvp?.should be_true
      end
    end

    describe "Event#guest_rsvp?" do
      it "Returns true if the standard price is set to either 0 or nil" do
        @event.guest_rsvp?.should be_true
      end
    end

    describe "Event#get_view_mode(current_user)" do
      context "Logged in User" do
        before (:each) do
          @event = Event.create(:name => "Test", :club_price => 0)
        end
        it "Returns Member RSVP when club price is 0" do
          @event.get_view_mode(FactoryGirl.create(:active_user)).should == "member_rsvp"
        end
        it "Returns Member Registration when club price is greater than 0" do
          @event.club_price = 5
          @event.get_view_mode(FactoryGirl.create(:active_user)).should == "member_registration"
        end
      end
      context "Guest User" do
        before (:each) do
          @event = FactoryGirl.build(:event)
          #@event = Event.create(:name => "Test", :standard_price => 0)
        end
        it "Returns Guest RSVP when standard price is 0" do
          @event.get_view_mode(nil).should == "/shared/guest_rsvp"
        end
        it "Returns Guest Registration when standard price is greater thn 0" do
          @event.standard_price = 5
          @event.get_view_mode(nil).should == "/shared/guest_registration"
        end
      end
    end

  describe "#increment_attendee_count" do
    it "adds 1 to the attendee_count" do
      event = Event.create(name: "new event", standard_price: 0, club_price: 0)
      expect { event.increment_attendee_count }.to change { event.attendee_count }.from(0).to(1)
    end
  end
end
