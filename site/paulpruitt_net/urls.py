from django.conf.urls import patterns, include, url
from django.views.generic.base import RedirectView 
from django.contrib import admin
import views
import pblog.urls

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^blog/',  include(pblog.urls), name='blog'),
    url(r'^about/$', views.about, name='about'),                       
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$',      RedirectView.as_view(url = '/blog/', permanent = False), name = 'index'), 
)
