Class {
	#name : #RDFTurtleParser,
	#superclass : #SmaCCParser,
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleParser class >> definitionComment [
"%glr;
%root Document;
%prefix RdfTurtle;
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

{ #category : #accessing }
RDFTurtleParser class >> scannerClass [
	^ RdfTurtleScanner
]
