# Linked Data

Linked Data is structured data which is interlinked with other data so it becomes more useful through semantic queries. It builds upon standard Web technologies such as HTTP, RDF and URIs, but rather than using them to serve web pages only for human readers, it extends them to share information in a way that can be read automatically by computers. Part of the vision of linked data is for the Internet to become a global database [[Wikipedia](https://en.wikipedia.org/wiki/Linked_data)].

# Instalation 

```Smalltalk
EpMonitor current disable.
[
Metacello new
   baseline: 'LinkedData';
   repository: 'github://feenkcom/linkeddata/src';
   load.
] ensure: [ EpMonitor current enable ]
```
