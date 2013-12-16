""" URL Patterns for blog """

from django.conf.urls import patterns, url
import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^(?P<article_id>\d+)/$', views.detail, name = 'detail'),
)
