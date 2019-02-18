require "application_system_test_case"

class OptionalsTest < ApplicationSystemTestCase
  setup do
    @optional = optionals(:one)
  end

  test "visiting the index" do
    visit optionals_url
    assert_selector "h1", text: "Optionals"
  end

  test "creating a Optional" do
    visit optionals_url
    click_on "New Optional"

    fill_in "Is gamified", with: @optional.is_gamified
    fill_in "Response", with: @optional.response
    fill_in "User", with: @optional.user_id
    click_on "Create Optional"

    assert_text "Optional was successfully created"
    click_on "Back"
  end

  test "updating a Optional" do
    visit optionals_url
    click_on "Edit", match: :first

    fill_in "Is gamified", with: @optional.is_gamified
    fill_in "Response", with: @optional.response
    fill_in "User", with: @optional.user_id
    click_on "Update Optional"

    assert_text "Optional was successfully updated"
    click_on "Back"
  end

  test "destroying a Optional" do
    visit optionals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Optional was successfully destroyed"
  end
end
