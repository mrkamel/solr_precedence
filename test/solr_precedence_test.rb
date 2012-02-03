
require "test/unit"
require File.expand_path("../../lib/solr_precedence", __FILE__)

class SolrPrecedenceTest < Test::Unit::TestCase
  def test_fix
    assert_equal "( a OR b ) c", SolrPrecedence.fix("a OR b c")
    assert_equal "( a OR ( b c ) )", SolrPrecedence.fix("a OR (b c)")
    assert_equal "( ( a b ) OR c )", SolrPrecedence.fix("(a b) OR c")
    assert_equal "( a OR \" b c \" )", SolrPrecedence.fix("a OR \"b c\"")
    assert_equal "( \" a b \" OR c )", SolrPrecedence.fix("\"a b\" OR c")
    assert_equal "a ( ( b OR c ) ) d", SolrPrecedence.fix("a (b OR c) d")
    assert_equal "a ( ( ( b OR c ) ) OR d )", SolrPrecedence.fix("a (b OR c) OR d")
    assert_equal "a ( ( ( ( b OR c ) ) OR d ) ) e", SolrPrecedence.fix("a ((b OR c) OR d) e")
    assert_equal "a ( b OR -c )", SolrPrecedence.fix("a b OR -c")
    assert_equal "a ( b OR - c )", SolrPrecedence.fix("a b OR - c")
    assert_equal "a ( ( b OR c ) ) - d e", SolrPrecedence.fix("a (b OR c) - d e")
  end
end

