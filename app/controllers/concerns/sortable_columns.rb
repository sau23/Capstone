module SortableColumns
    extend ActiveSupport::Concern

    included do
        helper_method :sort_column, :sort_direction
    end

    def sort_column(table)
        table.column_names.include?(params[:sort]) ? params[:sort] : table.column_names[0]
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
