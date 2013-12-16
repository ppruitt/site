""" URL Patterns for blog """

from django.conf.urls import patterns, url
import views

urlpatterns = patterns('',
    url(r'^$', views.IndexView.as_view(), name='index'),
    url(r'^(?P<pk>\d+)/$', views.DetailView.as_view(), name = 'detail'),
)
