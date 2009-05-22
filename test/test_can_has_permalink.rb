require 'test_helper'

class Post < ActiveRecord::Base
  extend CanHasPermalink
  can_has_permalink?
end

class TestCanHasPermalink < Test::Unit::TestCase
  def setup
    silence_stream(STDOUT) { load 'schema.rb' }
  end

  test "redefines to_param" do
    assert_equal 'my-permalink', Post.new(:permalink => 'my-permalink').to_param
  end

  test "downcases permalink before validation" do
    assert_equal 'permalink', Post.create(:permalink => 'PERMALINK').permalink
  end

  test "validates permalink is given" do
    p = Post.new(:permalink => nil)
    assert !p.valid?
    assert_not_nil p.errors.on(:permalink)
  end

  test "validates permalink no more than 250 characters" do
    # Page caching adds ".html" and some FS crash on >255 chars
    p = Post.new(:permalink => 'a'*251)
    assert !p.valid?
    assert_not_nil p.errors.on(:permalink)
  end

  test "validates permalink contains only alphanumerics and dashes" do
    ['foo!bar', 'foo_bar', 'foo bar', 'foo\nbar'].each do |permalink|
      p = Post.new(:permalink => permalink)
      assert !p.valid?
      assert_not_nil p.errors.on(:permalink)
    end
  end

  test "validates uniqueness of permalink" do
    
  end
end