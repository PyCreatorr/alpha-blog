require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    # this line runs vbefore each test is runn:
    def setup
        @category = Category.new(name: "Sports")
    end

    test "category should be valid" do       
        assert @category.valid?
    end
   
    test "name should be present" do
        # @category = Category.new(name: " ")
        @category.name = ""
        assert_not @category.valid?
    end

    test "name should be unique" do
        @category.save
        @category2 = Category.new(name:"Sports")
        assert_not @category2.valid?
    end

    test "name should be not so long" do
        @category.name = "a" * 26
        assert_not @category.valid?

    end

    test "name should be not so short" do
        @category.name = "aa"
        assert_not @category.valid?
    end
end