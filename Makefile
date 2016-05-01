CPP = g++

CPPFLAGS = -std=c++11

DISTDIR = cs118-1-$(user)

HTTPSOURCES = HttpRequest.cpp HttpResponse.cpp
WEBSERVERSOURCES = web-server.cpp
WEBCLIENTSOURCES = web-client.cpp
SOURCES = $(HTTPSOURCES) $(WEBSERVERSOURCES) $(WEBCLIENTSOURCES)

HTTPOBJECTS = $(subst .cpp,.o,$(HTTPSOURCES))
WEBSERVEROBJECTS = $(subst .cpp,.o,$(WEBSERVERSOURCES))
WEBCLIENTOBJECTS = $(subst .cpp,.o,$(WEBCLIENTSOURCES))

DIST_SOURCES = \
	$(SOURCES) \
	Makefile

all: web-server web-client

web-server: $(WEBSERVERSOURCES) $(HTTPSOURCES)
	$(CPP) $(CPPFLAGS) $(WEBSERVERSOURCES) $(HTTPSOURCES) -o web-server

web-client: $(WEBCLIENTSOURCES) $(HTTPSOURCES)
	$(CPP) $(CPPFLAGS) $(WEBCLIENTSOURCES) $(HTTPSOURCES) -o web-client

dist: $(DISTDIR).tar.gz

$(DISTDIR).tar.gz: $(DIST_SOURCES) 
	rm -fr $(DISTDIR)
	tar -czf $@.tmp --transform='s,^,$(DISTDIR)/,' $(DIST_SOURCES)
	mv $@.tmp $@

clean:
	rm -fr *.o *~ *.bak *.tar.gz core *.core *.tmp web-server web-client $(DISTDIR)

remake: clean all

.PHONY: all dist check clean
