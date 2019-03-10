# frozen_string_literal: true

require 'csv'

module FileImporterService
  class << self

    def importer(params)
      @file = params[:file]
      archives = []
      CSV.foreach(@file.path, headers: true, col_sep: "\t") do |row|
        archives << Archive.new(parse(row))
      end
      archives
    end

    private

    def parse(row)
      values = {}
      row.to_h.each do |item|
        key = item.first.tr(' ', '_')
        value = if key == 'item_price'
                  item.last.to_f
                elsif key == 'purchase_count'
                  item.last.to_i
                else
                  item.last
                end
        values[key] = value
      end
      values
    end

  end
end
