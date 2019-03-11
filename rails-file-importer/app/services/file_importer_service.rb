# frozen_string_literal: true

require 'csv'

module FileImporterService
  class << self

    def importer(params, user)
      @file = params[:file]
      @user = user
      sales = []
      CSV.foreach(@file.path, headers: true, col_sep: "\t") do |row|
        sales << Sale.new(parse(row))
      end
      sales
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
      values[:user] = @user
      values
    end

  end
end
