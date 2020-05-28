module Slugifiable

    module ClassMethods
        def find_by_slug(slug)
            self.all.detect{|instance| instance.slug == slug}
        end

        def valid_name?(name)
            name.scan(/[^a-zA-Z0-9 ]/).length == name.length ? false : true 
        end

    end

    module InstanceMethods
        def slug
            self.name.downcase.gsub(/[^a-zA-Z0-9 ]/, '').gsub(' ', '-')
        end
    end

end