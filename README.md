sinatra-example
===============

I put this example together to demonstrate how I write sinatra apps.
Some of the design principles I want to demonstrate:

Domain Driven Design
* Leverage terms in the ubiquitous language to name domain models
* Create types that make implicit concepts explicit   

Single Reponsibility Principle 
* Avoid large classes and long methods
* Minimize logic in the web layer

Dependency Inversion Principle
* Reduce coupling by depending on message protocols instead of types
* Minimize dependencies to other libraries/frameworks
* Use Rack Middleware pipeline to build up dependency tree

Common Closure Principle and Common Reuse Principle 
* Isolate the domain layer from the web application layer
* Group types based on a bounded context 
