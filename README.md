# praxis-exception-handler
A simple plugin for the [Praxis framework](http://praxis-framework.io/) that 
allows multiple listeners to be notified of exceptions.

# Why?

Praxis supports overriding its default error handler to perform some custom work 
with unhandled exceptions. This is rather limiting since, for example, it's not 
possible for two plugins to each set their own handler without one overriding 
the other.

The ExceptionHandler plugin solves the issue by allowing other components to 
register their exception handlers with it.

# Getting Started

First, register the plugin with your application:

    application.bootloader.use ExceptionHandler
    
Then, declare your custom handler:

    ExceptionHandler.handle do |request, exception|
      ...
    end
    
The parameters are the same as those passed to the default exception handler.

If an error handler returns a value other than `nil`, that value will be used as
the response. If all handlers return `nil`, the default Praxis exception handler
will be called and its response will be used.