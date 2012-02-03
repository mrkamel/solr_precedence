
require "solr_precedence/version"

module SolrPrecedence
  class SubQuery < Array
    attr_accessor :parent

    def embrace
      res = SubQuery.new

      within = false

      each_with_index do |token, index|
        if token.is_a?(SubQuery)
          res.push token.embrace

          if within && self[index + 1] != "OR"
            res.push ")"

            within = false
          end
        elsif token == "OR" && !within
          last = res.pop

          res.push "("
          res.push last
          res.push token

          within = true
        else
          res.push token

          if within && ![self[index + 1], token].include?("OR") && !["-", "+", "!"].include?(token)
            res.push ")"

            within = false
          end          
        end
      end

      res
    end
  end

  def self.parse(s)
    str = s.gsub(/\(/, " ( ").gsub(/\)/, " ) ").gsub(/\"/, " \" ")

    res = SubQuery.new
    current = res

    within = false

    str.split(" ").each do |token|
      if token == "("
        sub_query = SubQuery.new
        sub_query.parent = current

        sub_query.push "("

        current.push sub_query

        current = sub_query
      elsif token == "\""
        if within
          current.push "\""

          current = current.parent || res

          within = false
        else
          sub_query = SubQuery.new
          sub_query.parent = current

          current.push sub_query

          sub_query.push "\""

          current = sub_query

          within = true
        end
      elsif token == ")"
        current.push ")"

        current = current.parent || res
      else
        current.push token
      end
    end

    res
  end

  def self.fix(s)
    parse(s).embrace.join(" ")
  end
end

