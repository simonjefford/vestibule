require 'test_helper'

class ReasonTest < IntegrationTestCase
  context "When signing in after registering without having supplied a reason" do
    setup do
      user = Factory(:user, :signup_reason => nil)
      sign_in user
    end

    should "tell the user that they haven't stated a reason for siging up" do
      assert has_content?("Other attendees are wondering what you hope to get out of Ruby Manor.")
    end

    context "be able to provide a reason now" do
      setup do
        click_link "Tell them now"
      end

      should "not show the you haven't added a reason message" do
        assert !has_content?("Other attendees are wondering what you hope to get out of Ruby Manor.")
      end

      context "be able to update the sign up reason" do
        setup do
          fill_in "About you", :with => "I have signed up because I want to help shape the content"
          click_button "Update User"
        end

        should "show new sign up reason" do
          assert has_css?("#signup_reason", :text => "I have signed up because I want to help shape the content")
        end
      end
    end
  end

  context "When signing in after registering when they have supplied a reason" do
    setup do
      user = Factory(:user)
      sign_in user
    end

    should "not tell the user that they haven't stated a reason for siging up" do
      assert !has_content?("Other attendees are wondering what you hope to get out of Ruby Manor.")
    end
  end
end