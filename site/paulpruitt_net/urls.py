from django.conf.urls import patterns, include, url

from django.contrib import admin
import pblog.urls

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'paulpruitt_net.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^blog/',  include(pblog.urls), name='blog'),
    url(r'^admin/', include(admin.site.urls)),
)
