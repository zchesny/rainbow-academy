module Sortable 
    module ClassMethods
        def sort_by_name
            self.all.sort_by{|item| item.name}
        end
    end
end