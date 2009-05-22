module CanHasPermalink
  def can_has_permalink?
    include CanHasPermalink::InstanceMethods
    validates_uniqueness_of :permalink
    validate :must_be_present_and_have_correct_format
    before_validation :downcase_permalink
    define_method(:to_param) { self.permalink }
  end

  module InstanceMethods
    def downcase_permalink
      self.permalink.downcase! if self.permalink
    end

    def must_be_present_and_have_correct_format
      valid = self.permalink &&
              self.permalink.length <= 250 &&
              self.permalink =~ /\A[0-9a-z-]+\Z/

      errors.add(:permalink, <<-err) unless valid
is required.  It must be a unique string of alphanumerics and dashes no \
more than 250 characters long.
      err
    end
  end

end
