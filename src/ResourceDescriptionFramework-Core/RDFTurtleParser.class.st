Class {
	#name : #RDFTurtleParser,
	#superclass : #SmaCCGLRParser,
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #'generated-accessing' }
RDFTurtleParser class >> cacheId [
	^'2021-04-23T11:34:19.165133+02:00'
]

{ #category : #generated }
RDFTurtleParser class >> definitionComment [
"%glr;
%root Document;
%prefix RDFTurtle;
%suffix Node;

<whitespace>	: \s+;


turtleDoc
   : statement 'statements' * {{}}
   ;

statement
   : directive 'statement' {{}}
   | triples 'statement' ""."" {{}}
   ;

directive
   : prefixID 'directive' {{}}
   | base 'directive' {{}}
   | sparqlPrefix 'directive' {{}}
   | sparqlBase 'directive' {{}}
   ;

prefixID
   : ""@prefix"" <PNAME_NS> 'name' <IRIREF> 'iri' ""."" {{}}
   ;

base
   : ""@base"" <IRIREF> 'iri' ""."" {{}}
   ;

sparqlBase
   : ""BASE"" <IRIREF> 'iri' {{}}
   ;

sparqlPrefix
   : ""PREFIX"" <PNAME_NS> 'name' <IRIREF> 'iri' {{}}
   ;

triples
   : subject 'subject' predicateObjectList 'predicateObject' {{}}
   | blankNodePropertyList 'subject' predicateObjectList 'predicateObject' ? {{}}
   ;

predicateObjectList
   : verb 'verb' objectList 'objectList' ("";"" (verb 'verb' objectList 'objectList')?)* {{}}
   ;

objectList
   : object 'object' ("","" object 'object')* {{}}
   ;

verb
   : predicate 'verb' {{}}
   | ""a"" 'verb' {{}}
   ;

subject
   : iri 'subject' {{}}
   | <BlankNode> 'subject' {{}}
   | collection 'subject' {{}}
   ;

predicate
   : iri 'iri' {{}}
   ;

object
   : iri 'object' {{}}
   | <BlankNode> 'object' {{}}
   | collection 'object' {{}}
   | blankNodePropertyList 'object' {{}}
   | literal 'object' {{}}
   ;

literal
   : rdfLiteral 'literal' {{}}
   | <NumericLiteral> 'literal' {{}}
   | <BooleanLiteral> 'literal' {{}}
   ;

blankNodePropertyList
   : ""["" predicateObjectList 'list' ""]"" {{}}
   ;

collection
   : ""("" object* "")"" {{}}
   ;


<NumericLiteral>
   : <INTEGER> | <DECIMAL> | <DOUBLE>
   ;

rdfLiteral
   : <String> 'string' (<LANGTAG> 'tag' | ""^^"" iri 'iri')? {{}}
   ;


<BooleanLiteral>
   : true | false
   ;


<String>
   : <STRING_LITERAL_QUOTE> | <STRING_LITERAL_SINGLE_QUOTE> | <STRING_LITERAL_LONG_SINGLE_QUOTE> | <STRING_LITERAL_LONG_QUOTE>
   ;

iri
   : <IRIREF> 'iri' {{}}
   | <PrefixedName> 'iri' {{}}
   ;


<BlankNode>
   : <BLANK_NODE_LABEL> | <ANON>
   ;


<WS>
   : ([\t\r\n\x000C] | \ ) + /* TODO: -> skip*/
   ;

# LEXER

<PN_PREFIX>
   : <PN_CHARS_BASE> ((<PN_CHARS> | \.)* <PN_CHARS>)?
   ;

#IRIREF	        :	'<' (~(['\u0000'..'\u0020']|'<'|'>'|'""'|'{'|'}'|'|'|'^'|'`'|'\\') | UCHAR)* '>'; /* \u00=NULL #01-\u1F=control codes \u20=space */

<IRIREF>
   : \< (<PN_CHARS> | \. | \: | \/ | \\ | \# | \@ | \% | \& | <UCHAR>)* \>
   ;

<PNAME_NS>
   : <PN_PREFIX>? \:
   ;

<PrefixedName>
   : <PNAME_LN> | <PNAME_NS>
   ;

<PNAME_LN>
   : <PNAME_NS> <PN_LOCAL>
   ;

<BLANK_NODE_LABEL>
   : _\: (<PN_CHARS_U> | [0-9]) ((<PN_CHARS> | \.)* <PN_CHARS>)?
   ;

<LANGTAG>
   : \@ [a-zA-Z] + (\- [a-zA-Z0-9] +)*
   ;

<INTEGER>
   : [\+\-]? [0-9] +
   ;

<DECIMAL>
   : [\+\-]? [0-9]* \. [0-9] +
   ;

<DOUBLE>
   : [\+\-]? ([0-9] + \. [0-9]* <EXPONENT> | \. [0-9] + <EXPONENT> | [0-9] + <EXPONENT>)
   ;

<EXPONENT>
   : [eE] [\+\-]? [0-9] +
   ;

<STRING_LITERAL_LONG_SINGLE_QUOTE>
   : \'\'\' ((\' | \'\')? ([\^\'\\] | <ECHAR> | <UCHAR> | \""))* \'\'\'
   ;

<STRING_LITERAL_LONG_QUOTE>
   : \""\""\"" ((\"" | \""\"")? ([^\""\\] | <ECHAR> | <UCHAR> | \'))* \""\""\""
   ;

<STRING_LITERAL_QUOTE>
   : \"" ([^\""\\\r\n] | \' | \\\"")* \""
   ;

<STRING_LITERAL_SINGLE_QUOTE>
   : \' ([^\x0027\x005C\x000A\x000D] | <ECHAR> | <UCHAR> | \"")* \'
   ;

<UCHAR>
   : \\u <HEX> <HEX> <HEX> <HEX> | \\U <HEX> <HEX> <HEX> <HEX> <HEX> <HEX> <HEX> <HEX>
   ;

<ECHAR>
   : \\ [tbnrf\""\'\\]
   ;

<ANON_WS>
   : \  | \t | \r | \n
   ;

<ANON>
   : \[ <ANON_WS>* \]
   ;

<PN_CHARS_BASE>
   : [A-Z] | [a-z]
   ;

<PN_CHARS_U>
   : <PN_CHARS_BASE> | _
   ;

<PN_CHARS>
   : <PN_CHARS_U> | \- | [0-9]
   ;

<PN_LOCAL>
   : (<PN_CHARS_U> | \: | [0-9] | <PLX>) ((<PN_CHARS> | \. | \: | <PLX>)* (<PN_CHARS> | \: | <PLX>))?
   ;

<PLX>
   : <PERCENT> | <PN_LOCAL_ESC>
   ;

<PERCENT>
   : \% <HEX> <HEX>
   ;

<HEX>
   : [0-9] | [A-F] | [a-f]
   ;

<PN_LOCAL_ESC>
   : \\ (_ | \~ | \. | \- | \! | \$ | \& | \' | \( | \) | \* | \+ | \, | \; | \= | \/ | \? | \# | \@ | \%)
   ;"
]

{ #category : #generated }
RDFTurtleParser class >> reduceTable [
^#(
	#(25 0 #reduceActionForstatement__statements___1: 96257 false ) 
	#(24 1 #reduceActionForturtleDoc1: 80897 false ) 
	#(46 0 #nil 1549313 false ) 
	#(40 1 #reduceActionForsubject2: 1022978 false ) 
	#(48 1 #reduceActionForiri1: 1908737 false ) 
	#(48 1 #reduceActionForiri1: 1908738 false ) 
	#(25 2 #reduceActionForstatement__statements___2: 96258 false ) 
	#(26 1 #reduceActionForstatement1: 133121 false ) 
	#(27 1 #reduceActionFordirective1: 217089 false ) 
	#(27 1 #reduceActionFordirective1: 217090 false ) 
	#(27 1 #reduceActionFordirective1: 217092 false ) 
	#(27 1 #reduceActionFordirective1: 217091 false ) 
	#(32 1 #reduceActionFortriples2: 608258 false ) 
	#(40 1 #reduceActionForsubject2: 1022979 false ) 
	#(40 1 #reduceActionForsubject2: 1022977 false ) 
	#(30 2 #reduceActionForsparqlBase1: 485377 false ) 
	#(39 1 #reduceActionForverb2: 962562 false ) 
	#(39 1 #reduceActionForverb2: 962561 false ) 
	#(41 1 #reduceActionForpredicate1: 1126401 false ) 
	#(26 2 #reduceActionForstatement1: 133122 false ) 
	#(32 2 #reduceActionFortriples1: 608257 false ) 
	#(32 2 #reduceActionFortriples1: 608259 false ) 
	#(45 3 #reduceActionForcollection1: 1528833 false ) 
	#(43 1 #reduceActionForliteral2: 1332226 false ) 
	#(43 1 #reduceActionForliteral2: 1332227 false ) 
	#(47 1 #reduceActionForrdfLiteral1: 1636353 false ) 
	#(42 1 #reduceActionForobject2: 1163266 false ) 
	#(46 2 #liftFirstValue: 1549314 false ) 
	#(42 1 #reduceActionForobject2: 1163269 false ) 
	#(42 1 #reduceActionForobject2: 1163268 false ) 
	#(42 1 #reduceActionForobject2: 1163267 false ) 
	#(43 1 #reduceActionForliteral2: 1332225 false ) 
	#(42 1 #reduceActionForobject2: 1163265 false ) 
	#(29 3 #reduceActionForbase1: 436225 false ) 
	#(31 3 #reduceActionForsparqlPrefix1: 535553 false ) 
	#(44 3 #reduceActionForblankNodePropertyList1: 1454081 false ) 
	#(35 0 #reduceActionFor______verb__verb__objectList__objectList_____1: 836609 false ) 
	#(38 0 #reduceActionForstatement__statements___1: 927745 false ) 
	#(47 2 #reduceActionForrdfLiteral2: 1636354 false ) 
	#(28 4 #reduceActionForprefixID1: 362497 false ) 
	#(33 3 #reduceActionForpredicateObjectList1: 774145 false ) 
	#(36 2 #reduceActionForobjectList1: 894977 false ) 
	#(47 3 #reduceActionForrdfLiteral3: 1636355 false ) 
	#(34 1 #reduceActionFor______verb__verb__objectList__objectList____1: 836609 false ) 
	#(35 2 #reduceActionFor______verb__verb__objectList__objectList_____2: 836610 false ) 
	#(38 2 #reduceActionForstatement__statements___2: 927746 false ) 
	#(37 2 #liftSecondValue: 927745 false ) 
	#(34 3 #reduceActionFor______verb__verb__objectList__objectList____2: 836610 false )
	).
]

{ #category : #'generated-accessing' }
RDFTurtleParser class >> scannerClass [
	^RDFTurtleScanner
]

{ #category : #generated }
RDFTurtleParser class >> startingStateForturtleDoc [
	^ 1
]

{ #category : #generated }
RDFTurtleParser class >> symbolNames [
	^ #('"("' '")"' '","' '"."' '";"' '"@base"' '"@prefix"' '"BASE"' '"PREFIX"' '"["' '"]"' '"^^"' '"a"' '<whitespace>' '<NumericLiteral>' '<BooleanLiteral>' '<String>' '<BlankNode>' '<IRIREF>' '<PNAME_NS>' '<PrefixedName>' '<LANGTAG>' 'B e g i n' 'turtleDoc' 'statement ''statements'' *' 'statement' 'directive' 'prefixID' 'base' 'sparqlBase' 'sparqlPrefix' 'triples' 'predicateObjectList' '(";" (verb ''verb'' objectList ''objectList'')?)' '(";" (verb ''verb'' objectList ''objectList'')?)*' 'objectList' '("," object ''object'')' '("," object ''object'')*' 'verb' 'subject' 'predicate' 'object' 'literal' 'blankNodePropertyList' 'collection' 'object*' 'rdfLiteral' 'iri' 'E O F' 'error')
]

{ #category : #generated }
RDFTurtleParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #RDFTurtleTurtleDocNode #RDFTurtleTurtleDocNode #OrderedCollection #RDFTurtleStatementNode #RDFTurtleDirectiveNode #RDFTurtlePrefixIDNode #RDFTurtleBaseNode #RDFTurtleSparqlBaseNode #RDFTurtleSparqlPrefixNode #RDFTurtleTriplesNode #RDFTurtlePredicateObjectListNode #OrderedCollection #OrderedCollection #RDFTurtleObjectListNode #RDFTurtleObjectNode #OrderedCollection #RDFTurtleVerbNode #RDFTurtleSubjectNode #RDFTurtlePredicateNode #RDFTurtleObjectNode #RDFTurtleLiteralNode #RDFTurtleBlankNodePropertyListNode #RDFTurtleCollectionNode nil #RDFTurtleRdfLiteralNode #RDFTurtleIriNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
RDFTurtleParser class >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 18 0 6 0 19 0 6 0 21 0 9 0 24 0 13 0 25 0 6 0 49] 
#[0 0 0 0 49] 
#[1 0 17 0 1 0 21 0 6 0 25 0 7 0 29 0 8 0 33 0 9 0 37 0 10 0 41 0 18 0 45 0 19 0 49 0 21 0 53 0 26 0 57 0 27 0 61 0 28 0 65 0 29 0 69 0 30 0 73 0 31 0 77 0 32 0 81 0 40 0 85 0 44 0 89 0 45 0 93 0 48 0 10 0 49] 
#[1 0 14 0 1 0 14 0 2 0 14 0 10 0 14 0 15 0 14 0 16 0 14 0 17 0 14 0 18 0 14 0 19 0 14 0 21 0 97 0 46] 
#[0 0 101 0 19] 
#[0 0 105 0 20] 
#[0 0 109 0 19] 
#[0 0 113 0 20] 
#[1 0 117 0 13 0 45 0 19 0 49 0 21 0 121 0 33 0 125 0 39 0 129 0 41 0 133 0 48] 
#[0 0 18 0 13 0 19 0 21] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 13 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 13 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 30 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 34 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 38 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 42 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 46 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 50 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 137 0 4] 
#[1 0 117 0 13 0 45 0 19 0 49 0 21 0 141 0 33 0 125 0 39 0 129 0 41 0 133 0 48] 
#[1 0 54 0 4 0 117 0 13 0 45 0 19 0 49 0 21 0 145 0 33 0 125 0 39 0 129 0 41 0 133 0 48] 
#[0 0 58 0 13 0 19 0 21] 
#[0 0 62 0 13 0 19 0 21] 
#[1 0 17 0 1 0 149 0 2 0 37 0 10 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 45 0 19 0 49 0 21 0 169 0 42 0 173 0 43 0 177 0 44 0 181 0 45 0 185 0 47 0 189 0 48] 
#[0 0 193 0 4] 
#[0 0 197 0 19] 
#[0 0 66 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 201 0 19] 
#[0 0 70 0 1 0 10 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 205 0 11] 
#[1 0 17 0 1 0 37 0 10 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 45 0 19 0 49 0 21 0 209 0 36 0 213 0 42 0 173 0 43 0 177 0 44 0 181 0 45 0 185 0 47 0 189 0 48] 
#[0 0 74 0 1 0 10 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 78 0 1 0 10 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 82 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 86 0 4] 
#[0 0 90 0 4] 
#[0 0 94 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 13 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 98 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 102 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[1 0 106 0 1 0 106 0 2 0 106 0 3 0 106 0 4 0 106 0 5 0 106 0 10 0 106 0 11 0 217 0 12 0 106 0 15 0 106 0 16 0 106 0 17 0 106 0 18 0 106 0 19 0 106 0 21 0 221 0 22] 
#[0 0 110 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 114 0 1 0 2 0 10 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 118 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 130 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 134 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 138 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 225 0 4] 
#[0 0 142 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 13 0 15 0 16 0 17 0 18 0 19 0 21] 
#[1 0 150 0 4 0 150 0 5 0 150 0 11 0 229 0 35] 
#[1 0 154 0 3 0 154 0 4 0 154 0 5 0 154 0 11 0 233 0 38] 
#[1 0 45 0 19 0 49 0 21 0 237 0 48] 
#[0 0 158 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[0 0 162 0 1 0 6 0 7 0 8 0 9 0 10 0 18 0 19 0 21 0 49] 
#[1 0 166 0 4 0 241 0 5 0 166 0 11 0 245 0 34] 
#[1 0 249 0 3 0 170 0 4 0 170 0 5 0 170 0 11 0 253 0 37] 
#[0 0 174 0 1 0 2 0 3 0 4 0 5 0 10 0 11 0 15 0 16 0 17 0 18 0 19 0 21] 
#[1 0 178 0 4 0 178 0 5 0 178 0 11 0 117 0 13 0 45 0 19 0 49 0 21 1 1 0 39 0 129 0 41 0 133 0 48] 
#[0 0 182 0 4 0 5 0 11] 
#[1 0 17 0 1 0 37 0 10 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 45 0 19 0 49 0 21 1 5 0 42 0 173 0 43 0 177 0 44 0 181 0 45 0 185 0 47 0 189 0 48] 
#[0 0 186 0 3 0 4 0 5 0 11] 
#[1 0 17 0 1 0 37 0 10 0 153 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 45 0 19 0 49 0 21 1 9 0 36 0 213 0 42 0 173 0 43 0 177 0 44 0 181 0 45 0 185 0 47 0 189 0 48] 
#[0 0 190 0 3 0 4 0 5 0 11] 
#[0 0 194 0 4 0 5 0 11]
	).
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFor______verb__verb__objectList__objectList____1: nodes [
	| result |
	result := Array new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFor______verb__verb__objectList__objectList____2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFor______verb__verb__objectList__objectList_____1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFor______verb__verb__objectList__objectList_____2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForbase1: nodes [
	| result |
	result := RDFTurtleBaseNode new.
	result iri: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForblankNodePropertyList1: nodes [
	| result |
	result := RDFTurtleBlankNodePropertyListNode new.
	result list: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForcollection1: nodes [
	| result |
	result := RDFTurtleCollectionNode new.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFordirective1: nodes [
	| result |
	result := RDFTurtleDirectiveNode new.
	result directive: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForiri1: nodes [
	| result |
	result := RDFTurtleIriNode new.
	result iri: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForliteral2: nodes [
	| result |
	result := RDFTurtleLiteralNode new.
	result literal: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForobject2: nodes [
	| result |
	result := RDFTurtleObjectNode new.
	result object: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForobjectList1: nodes [
	| result |
	result := RDFTurtleObjectListNode new.
	result addNode: (nodes at: 1) to: result objects.
	result addNodes: (nodes at: 2) to: result objects.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForpredicate1: nodes [
	| result |
	result := RDFTurtlePredicateNode new.
	result iri: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForpredicateObjectList1: nodes [
	| result |
	result := RDFTurtlePredicateObjectListNode new.
	result addNode: (nodes at: 1) to: result verbs.
	result addNode: (nodes at: 2) to: result objectLists.
	result addNodes: ((nodes at: 3) at: 1) to: result verbs.
	result addNodes: ((nodes at: 3) at: 2) to: result objectLists.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForprefixID1: nodes [
	| result |
	result := RDFTurtlePrefixIDNode new.
	result name: (nodes at: 2).
	result iri: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForrdfLiteral1: nodes [
	| result |
	result := RDFTurtleRdfLiteralNode new.
	result string: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForrdfLiteral2: nodes [
	| result |
	result := RDFTurtleRdfLiteralNode new.
	result string: (nodes at: 1).
	result tag: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForrdfLiteral3: nodes [
	| result |
	result := RDFTurtleRdfLiteralNode new.
	result string: (nodes at: 1).
	result iri: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForsparqlBase1: nodes [
	| result |
	result := RDFTurtleSparqlBaseNode new.
	result iri: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForsparqlPrefix1: nodes [
	| result |
	result := RDFTurtleSparqlPrefixNode new.
	result name: (nodes at: 2).
	result iri: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForstatement1: nodes [
	| result |
	result := RDFTurtleStatementNode new.
	result statement: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForstatement__statements___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForstatement__statements___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForsubject2: nodes [
	| result |
	result := RDFTurtleSubjectNode new.
	result subject: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFortriples1: nodes [
	| result |
	result := RDFTurtleTriplesNode new.
	result subject: (nodes at: 1).
	result predicateObject: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionFortriples2: nodes [
	| result |
	result := RDFTurtleTriplesNode new.
	result subject: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForturtleDoc1: nodes [
	| result |
	result := RDFTurtleTurtleDocNode new.
	result addNodes: (nodes at: 1) to: result statementses.
	^ result
]

{ #category : #'generated-reduction actions' }
RDFTurtleParser >> reduceActionForverb2: nodes [
	| result |
	result := RDFTurtleVerbNode new.
	result verb: (nodes at: 1).
	^ result
]
