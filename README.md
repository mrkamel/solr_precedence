
# SolrPrecedence

Fixing precendence for the OR operator of Solr's default query parser by using groups

## Example

<pre>
irb> SolrPrecedence.fix "a OR b c"
=> "( a OR b ) c"
irb> SolrPrecedence.fix "a (b c) OR d"
=> "a ( ( b c ) OR d )"
</pre>

