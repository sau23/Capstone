module ApplicationHelper

    # sort table columns
    def sortable(column, table, title = nil)
        title ||= column.titleize
        css_class = (column == sort_column(table)) ? "current #{sort_direction}" : nil
        direction = (column == sort_column(table) && sort_direction == "asc") ? "desc" : "asc"
        link_to title, :sort => column, :direction => direction
    end

end
